sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'expenses/app/mydebts/test/integration/FirstJourney',
		'expenses/app/mydebts/test/integration/pages/DebtsList',
		'expenses/app/mydebts/test/integration/pages/DebtsObjectPage'
    ],
    function(JourneyRunner, opaJourney, DebtsList, DebtsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('expenses/app/mydebts') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheDebtsList: DebtsList,
					onTheDebtsObjectPage: DebtsObjectPage
                }
            },
            opaJourney.run
        );
    }
);