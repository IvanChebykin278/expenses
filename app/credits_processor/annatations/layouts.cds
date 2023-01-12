using { Controller as service } from '../../../srv/Controller';

annotate service.Credits with {
    cost_criticality @UI.Hidden;
    status_criticality @UI.Hidden;
    creditor_id @UI.Hidden;
};


annotate service.Credits with @UI : {
    
    Identification : [
        { $Type  : 'UI.DataFieldForAction', Action : 'Controller.closeCredit',   Label  : 'Закрыть задолжность'   },
        { $Type  : 'UI.DataFieldForAction', Action : 'Controller.declineCredit',   Label  : 'Отменить задолжность'   },
        { $Type: 'UI.DataField', Label: 'Дата операции', Value: date },
        { $Type: 'UI.DataField', Label: 'Дебитор', Value: debtor_id },
        { $Type: 'UI.DataField', Label: 'Статус', Value: debt_status.name, Criticality: status_criticality }
    ],

    HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Задолжность',
        TypeNamePlural : 'Задолжности',
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
        GroupBy: [debt_status_code],
        SortOrder: [
            {
                $Type: 'Common.SortOrderType',
                Property: debt_status_code,
                Descending: true
            },
            {
                $Type: 'Common.SortOrderType',
                Property: date,
                Descending: true
            }
        ]
    },

    SelectionFields : [
        debt_status_code,
        debtor_id,
        cost,
        currency_code,
        date
    ],

    LineItem : [
        { $Type  : 'UI.DataFieldForAction', Action : 'Controller.closeCredit',   Label  : 'Закрыть задолжность'   },
        { $Type  : 'UI.DataFieldForAction', Action : 'Controller.declineCredit',   Label  : 'Отменить задолжность'   },
        {
            Value: ID,
            @UI.Importance: #High
        },
        {
            Value: debt_status_code,
            Criticality: status_criticality,
            @UI.Importance: #High,
            @HTML5.CssDefaults: {width:'10em'},
            Label: 'Статус'
        },
        {
            Value: debtor.fullName,
            @UI.Importance: #High,
            @HTML5.CssDefaults: {width:'12em'},
            Label: 'Дебитор'
        },
        {
            Value: cost,
            Criticality: cost_criticality,
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
                Value: debtor_id
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
