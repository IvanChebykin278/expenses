using { expenses as db } from '../db/schema';

@path : 'service/Controller'
service Controller @(requires: 'User') {

    @readonly
    entity Status as projection on db.Status;

    @(restrict: [{ grant: ['READ'], where: 'ID != $user' }])
    entity Users as select
        from db.Users {
            *,
            firstName || ' ' || secondName as fullName : String
        };

    @readonly
    entity Categories as projection on db.Categories;

    @(restrict: [{ grant: ['CREATE','READ','UPDATE','DELETE'], where: 'createdBy = $user' }])
    entity Expenses as select
        from db.Expenses {
            *,
            case
                when cost >= 50 then 1
                when cost < 50 and cost > 20 then 2
                when cost <= 20 then 3
                else 0
            end as criticality : Integer
        };
    
    @(restrict: [
        { grant: ['CREATE','READ'], where: 'debtor_id = $user' },
        { grant: ['closeDebt','declineDebt'], to: 'User'}
    ])
    entity Debts as select
        from db.Debts {
            key ID,
            debtor_id,
            creditor,
            creditor_id,
            description,
            cost,
            date,
            currency,
            currency_code,
            debt_status,
            debt_status_code,
            case
                when cost >= 50 then 1
                when cost < 50 and cost > 20 then 2
                when cost <= 20 then 3
                else 0
            end as cost_criticality : Integer,
            case
                when debt_status_code = 'OPEN' then 1
                when debt_status_code = 'CLOSED' then 3
                else 0
            end as status_criticality : Integer
        }
    actions {
        action closeDebt();
        action declineDebt();
    };

    @(restrict: [
        { grant: ['CREATE','READ'], where: 'creditor_id = $user' },
        { grant: ['closeCredit','declineCredit'], to: 'User'}
    ])
    entity Credits as select
        from db.Debts {
            key ID,
            debtor_id,
            debtor,
            creditor_id,
            description,
            cost,
            date,
            currency,
            currency_code,
            debt_status,
            debt_status_code,
            case
                when cost >= 50 then 1
                when cost < 50 and cost > 20 then 2
                when cost <= 20 then 3
                else 0
            end as cost_criticality : Integer,
            case
                when debt_status_code = 'OPEN' then 1
                when debt_status_code = 'CLOSED' then 3
                else 0
            end as status_criticality : Integer
        }
    actions {
        action closeCredit();
        action declineCredit();
    };

    action checkUserExistence();
}