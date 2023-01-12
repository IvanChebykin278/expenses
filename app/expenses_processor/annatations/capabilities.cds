using { Controller as service } from '../../../srv/Controller';

annotate service.Expenses with @odata.draft.enabled;
annotate service.Expenses with @Common.SemanticKey: [ ID ];
annotate service.Users with @Common.SemanticKey: [ ID ];



