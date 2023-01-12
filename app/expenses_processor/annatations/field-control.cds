using { Controller as service } from '../../../srv/Controller';

annotate service.Expenses with {
    description     @Common.FieldControl : #Mandatory;
    category_code   @Common.FieldControl : #Mandatory;
    cost            @Common.FieldControl : #Mandatory;
    currency_code   @Common.FieldControl : #Mandatory;
    date            @Common.FieldControl : #Mandatory;
};