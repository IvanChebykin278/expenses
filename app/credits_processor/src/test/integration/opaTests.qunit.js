sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'expenses/app/mycredits/test/integration/FirstJourney',
		'expenses/app/mycredits/test/integration/pages/CreditsList',
		'expenses/app/mycredits/test/integration/pages/CreditsObjectPage'
    ],
    function(JourneyRunner, opaJourney, CreditsList, CreditsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('expenses/app/mycredits') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCreditsList: CreditsList,
					onTheCreditsObjectPage: CreditsObjectPage
                }
            },
            opaJourney.run
        );
    }
);