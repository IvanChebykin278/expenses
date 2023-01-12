using { Controller as service } from '../../../srv/Controller';

annotate service.Expenses {
    currency_code @Common : { 

        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currencies',
            Label: 'Категории',
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

    category_code @Common : {

        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Label: 'Категории',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: category_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
    };
}
