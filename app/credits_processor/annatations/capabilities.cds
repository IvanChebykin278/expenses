using { Controller as service } from '../../../srv/Controller';

annotate service.Credits with @odata.draft.enabled;
annotate service.Credits with @Common.SemanticKey: [ ID ];



