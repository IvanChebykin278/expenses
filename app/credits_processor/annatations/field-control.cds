using { Controller as service } from '../../../srv/Controller';

annotate service.Credits with @(
    UI.DeleteHidden
){
    description     @Common.FieldControl : #Mandatory;
    debtor_id       @Common.FieldControl : #Mandatory;
    cost            @Common.FieldControl : #Mandatory;
    currency_code   @Common.FieldControl : #Mandatory;
    date            @Common.FieldControl : #Mandatory;
} actions {
    closeCredit @(
        Core.OperationAvailable : { $edmJson: { $Eq: [{ $Path: 'in/debt_status_code' }, 'OPEN'] } },
        Common.SideEffects.TargetProperties: ['in/debt_status_code']
    );

    declineCredit @(
        Core.OperationAvailable : { $edmJson: { $Eq: [{ $Path: 'in/debt_status_code' }, 'OPEN'] } },
        Common.SideEffects.TargetProperties: ['in/debt_status_code']
    );
};