using {expenses as db} from '../../../db/schema';

annotate db.Debts with {
    debtor_id @title : 'Ид. дебитора';
};
  


