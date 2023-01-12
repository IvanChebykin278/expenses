import BaseObject from "sap/ui/base/Object";
import ODataModel from "sap/ui/model/odata/v4/ODataModel";
import Log from "sap/base/Log";

/**
 * @namespace expenses.app.mycredits.ext
 */
export default class CheckUserExistence extends BaseObject {
    private model : ODataModel;
    
    constructor(oDataModel : ODataModel) {
        super();

        this.model = oDataModel;
    };

    public execute() : void {
        this.model
            .bindContext('/checkUserExistence(...)')
            .execute()
            .then(
                () => {},
                err => Log.error('Faild to execute action checkUserExistence', err, this.getMetadata().getName())
            )
    };

    public destroy() : void {
        super.destroy();
    };
};

