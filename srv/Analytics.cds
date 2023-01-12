using { expenses as db } from '../db/schema';

@path : 'service/Analytics'
service Analytics @(requires: 'User') {

    @(restrict: [{ grant: ['READ'], where: 'createdBy = $user' }])
    entity Expenses as projection on db.Expenses;

    @readonly
    entity Categories as projection on db.Categories;

    @readonly
    entity Types as projection on db.Types;

    
}