using { Controller as service } from '../../../srv/Controller';

annotate service.Credits {

    currency_code @Common : { 

        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currencies',
            Label: 'Валюта',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: currency_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
    };

    debtor_id @Common : {

        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Users',
            Label: 'Кредитор',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: debtor_id,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'firstName'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'secondName'
                }
            ]
        },
    };

    debt_status_code @Common : { 

        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Label : 'Статус',
            Parameters : [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: debt_status_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },

    }
}
