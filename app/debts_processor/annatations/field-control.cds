using { Controller as service } from '../../../srv/Controller';

annotate service.Debts with @(
    UI.DeleteHidden
){
    description     @Common.FieldControl : #Mandatory;
    creditor_id     @Common.FieldControl : #Mandatory;
    cost            @Common.FieldControl : #Mandatory;
    currency_code   @Common.FieldControl : #Mandatory;
    date            @Common.FieldControl : #Mandatory;
} actions {
    closeDebt @(
        Core.OperationAvailable : { $edmJson: { $Eq: [{ $Path: 'in/debt_status_code' }, 'OPEN'] } },
        Common.SideEffects.TargetProperties: ['in/debt_status_code']
    );

    declineDebt @(
        Core.OperationAvailable : { $edmJson: { $Eq: [{ $Path: 'in/debt_status_code' }, 'OPEN'] } },
        Common.SideEffects.TargetProperties: ['in/debt_status_code']
    );
};