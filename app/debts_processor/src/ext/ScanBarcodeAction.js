sap.ui.define([
    "sap/ndc/BarcodeScanner",
    "sap/m/MessageBox"
], function(BarcodeScanner, MessageBox) {
    return {
        onScanBarcode: function(context) {
            const utils = {
                barcodeMapping: {
                    cost: {
                        codeKey: 'O',
                        formatter: 'formatCost'
                    },
                    date: {
                        codeKey: 'F',
                        formatter: 'formatDate'
                    },
                    description: {
                        codeKey: 'G'
                    }
                },

                showScanError: () => MessageBox.error('Невалидный QR - код. Невозможно прочитать данные'),

                createBarcodeParser: function(text) {
                    const isValid = this.validateBarcode(text);
                    const oParsedCode = text
                        .split('*')
                        .reduce((obj, part) => {
                            const [ key, value ] = part.split(':');
                            
                            return { ...obj, [key]: value };
                        }, {});

                    return {
                        getProperty: (sKey) => oParsedCode[sKey],
                        getIsValid: () => isValid
                    }
                },

                validateBarcode: (text = '') => text.includes('*F:') && text.includes('*O:'),

                formatCost: (value) => Number(value),
                formatDate: (value) => value.substring(0,4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8)
            }

            BarcodeScanner.scan(
                function(result) {
                    const parser = utils.createBarcodeParser(result.text);

                    if(parser.getIsValid()) {
                        Object
                            .entries(utils.barcodeMapping)
                            .forEach(([ key, value ]) => {
                                const codeValue = parser.getProperty(value.codeKey);

                                if(codeValue) {
                                    const formattedCodeValue = utils[value.formatter] && typeof utils[value.formatter] === 'function' 
                                        ? utils[value.formatter](codeValue) 
                                        : codeValue;
                                    
                                    context.setProperty(key, formattedCodeValue);
                                }
                            });
                    } else {
                        BarcodeScanner.closeScanDialog();
                        utils.showScanError();
                    }
                }.bind(this),
                function(error) { utils.showScanError(); }.bind(this),
                (result) => {  },
                "Enter Product Barcode",
                true,
                30,
                1,
                false
            );
        },
    }
});