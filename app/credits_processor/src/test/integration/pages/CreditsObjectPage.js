sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'expenses.app.mycredits',
            componentId: 'CreditsObjectPage',
            entitySet: 'Credits'
        },
        CustomPageDefinitions
    );
});