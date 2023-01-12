import BaseObject from "sap/ui/base/Object";
import BarcodeScanner from "sap/ndc/BarcodeScanner";
import MessageBox from "sap/m/MessageBox";
import ExtensionAPI from "sap/fe/templates/ObjectPage/ExtensionAPI";
import Context from "sap/ui/model/odata/v4/Context";

interface Extension {
    onScanBarcode : (context : Context) => void
}

type Formatter<T> = (value : string) => T
type ParsedCode = { [index: string | symbol]: string }
type MappingProperty = {
    codeKey : string;
    formatter?: Formatter<number | string>;
}

const formatCost : Formatter<number> = (value : string) : number => Number(value);
const formatDate : Formatter<string> = (value : string) : string => value.substring(0,4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8);
const formatDesc : Formatter<string> = (value : string) : string => value;

const showScanError = () : void => MessageBox.error('Невалидный QR - код. Невозможно прочитать данные');

class BarcodeMapping {
    public static cost : MappingProperty = {
        codeKey: 'O',
        formatter: formatCost
    };

    public static date : MappingProperty = {
        codeKey: 'F',
        formatter: formatDate
    };

    public static description : MappingProperty = {
        codeKey: 'G',
        formatter: formatDesc
    }
};

/**
 * @namespace expenses.app.mycredits.ext
 */
class BarcodeParser extends BaseObject {
    private text : string;
    private isValid : boolean;
    private parsedCode : ParsedCode;


    constructor(text : string) {
        super();

        this.isValid = this.validate(text);
        this.parsedCode = this.parse(text);
        this.text = text;
    };

    private parse(text : string) : ParsedCode {
        return text
            .split('*')
            .reduce((parcedCode : ParsedCode, part : string) => {
                const [ key , value ] = part.split(':');

                return { ...parcedCode, [key as keyof ParsedCode]: value };
            }, {} as ParsedCode);
    };

    private validate(text : string) : boolean {
        return text.includes('*F:') && text.includes('*O:');
    };

    public getProperty(name : string) : string {
        return this.parsedCode[name as keyof ParsedCode];
    };

    public getValid() : boolean {
        return this.isValid;
    };
};

export default {
    onScanBarcode: function(context : Context) : void {
        BarcodeScanner.scan(
            (result) => {
                const parser : BarcodeParser = new BarcodeParser(result.text);
                const isValid : boolean = parser.getValid();

                if(isValid) {
                    Object
                        .entries(BarcodeMapping)
                        .forEach(([ key, value ]) => {
                            const codeValue = parser.getProperty(value.codeKey);

                            if(codeValue) {
                                context.setProperty(key, value.formatter ? value.formatter(codeValue) : codeValue);
                            }
                        });
                } else {
                    BarcodeScanner.closeScanDialog();
                    showScanError();
                }
            },
            () => showScanError(),
            () => {}
        )
    }
} as Extension & ExtensionAPI;