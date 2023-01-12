sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'expenses/app/myexpenses/test/integration/FirstJourney',
		'expenses/app/myexpenses/test/integration/pages/ExpensesList',
		'expenses/app/myexpenses/test/integration/pages/ExpensesObjectPage',
		'expenses/app/myexpenses/test/integration/pages/UserExpenseObjectPage'
    ],
    function(JourneyRunner, opaJourney, ExpensesList, ExpensesObjectPage, UserExpenseObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('expenses/app/myexpenses') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheExpensesList: ExpensesList,
					onTheExpensesObjectPage: ExpensesObjectPage,
					onTheUserExpenseObjectPage: UserExpenseObjectPage
                }
            },
            opaJourney.run
        );
    }
);