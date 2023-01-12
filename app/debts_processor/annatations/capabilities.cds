using { Controller as service } from '../../../srv/Controller';

annotate service.Debts with @odata.draft.enabled;
annotate service.Debts with @Common.SemanticKey: [ ID ];



