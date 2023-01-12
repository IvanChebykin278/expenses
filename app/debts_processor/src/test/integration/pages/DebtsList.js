sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'expenses.app.mydebts',
            componentId: 'DebtsList',
            entitySet: 'Debts'
        },
        CustomPageDefinitions
    );
});