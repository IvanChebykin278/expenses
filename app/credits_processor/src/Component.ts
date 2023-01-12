import AppComponent from "sap/fe/core/AppComponent";
import ODataModel from "sap/ui/model/odata/v4/ODataModel";
import CheckUserExistence from "./ext/CheckUserExistence";

/**
 * @namespace expenses.app.mycredits.Component
 */
export default class Component extends AppComponent {
    private checkUserExistence : CheckUserExistence;
    
    public metadata : object = {
        manifest: "json"
    };

    public init() : void {
        const model : ODataModel = this.getModel() as ODataModel;
        this.checkUserExistence = new CheckUserExistence(model);
        this.checkUserExistence.execute();

        super.init();
    };

    public exit() : void {
        this.checkUserExistence.destroy();
    };
};