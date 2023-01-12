namespace expenses;

using {managed, cuid} from '@sap/cds/common';
using { sap } from '@sap/cds/common';

entity Currencies : sap.common.Currencies {};

entity Users {
    key ID : String;

    firstName : String default null;
    secondName : String default null;

    avatar : LargeBinary @Core.MediaType: avatarType;
    avatarType : String  @Core.IsMediaType;
};

entity Categories {
    key code : String;
    name : String not null;
    icon : String default null;
};

entity Types {
    key code : String;
    name : String not null;
    icon : String default null;
};

entity Status {
    key code : String;
    name : String not null;
    icon : String default null;
};

entity UtilityTypes {
    key code : String;
    name : String not null;
    icon : String default null;
};

entity Expenses : cuid, managed {
    cost : Decimal(16,3) not null;
    description : String default null;
    date : Date not null;

    currency_code : String default 'EUR';
    currency : Association to one Currencies on currency.code = currency_code;

    category_code : String not null;
    category : Association to one Categories on category.code = category_code;
};

entity Debts : cuid, managed {
    debtor_id : String;
    debtor : Association to one Users on debtor.ID = debtor_id;

    creditor_id : String;
    creditor : Association to one Users on creditor.ID = creditor_id;

    description : String not null;
    cost : Decimal(16,3) not null;
    date : Date not null;

    currency_code : String default 'EUR';
    currency : Association to one Currencies on currency.code = currency_code;

    debt_status_code : String default 'OPEN';
    debt_status : Association to one Status on debt_status.code = debt_status_code;
};

entity Utilities : cuid, managed {
    payer_id : String default $user;
    description : String not null;
    cost : Decimal(16,3) not null;

    currency_code : String default 'EUR';
    currency : Association to one Currencies on currency.code = currency_code;

    utility_type_code : String not null;
    utility_type : Association to one UtilityTypes on utility_type.code = utility_type_code;
};