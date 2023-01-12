using { Controller as service } from '../../../srv/Controller';

annotate service.Expenses with {
    criticality @UI.Hidden;
};


annotate service.Expenses with @UI : {
    Identification : [
        { $Type: 'UI.DataField', Label: 'Дата операции', Value: date }
    ],

    HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Затрата',
        TypeNamePlural : 'Затраты',
        Title : {
            $Type: 'UI.DataField',
            Value: description
        },
        Description : {
            $Type: 'UI.DataField',
            Value: ID
        }
    },

    PresentationVariant : {
        Text: 'Default',
        $Type : 'UI.PresentationVariantType',
        Visualizations: ['@UI.LineItem'],
        GroupBy: [date],
        SortOrder: [
            {
                $Type: 'Common.SortOrderType',
                Property: date,
                Descending: true
            }
        ]
    },

    SelectionFields : [
        category_code,
        currency_code,
        cost,
        date
    ],

    LineItem : [
        {
            Value: ID,
            @UI.Importance: #High
        },
        {
            Value: category.name,
            @UI.Importance: #High,
            @HTML5.CssDefaults: {width:'12em'},
            Label: 'Категория'
        },
        {
            Value: cost,
            Criticality: criticality,
            @UI.Importance: #High,
            @HTML5.CssDefaults: {width:'15em'}
        },
        {
            Value: date,
            @UI.Importance: #High,
            @HTML5.CssDefaults: {width:'15em'}
        }
    ],

    Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CommonData',
            Target : '@UI.FieldGroup#CommonData',
            Label : 'Основные данные'
        }
    ],

    FieldGroup #CommonData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: description
            },
            {
                $Type: 'UI.DataField',
                Value: category_code
            },
            {
                $Type: 'UI.DataField',
                Value: cost
            },
            {
                $Type: 'UI.DataField',
                Value: date
            }
        ]
    },
};
