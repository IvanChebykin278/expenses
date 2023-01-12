using {expenses as db} from '../../../db/schema';

annotate db.Debts with {
    ID                  @title : 'Ид. задолжности' @Common.Text: description @Common.TextArrangement: #TextOnly;
    creditor_id         @title : 'Ид. кредитора';
    description         @title : 'Описание';
    cost                @title : 'Сумма' @Measures.ISOCurrency: currency_code;
    date                @title : 'Дата операции';
    currency_code       @title : 'Код валюты';
    debt_status_code    @title : 'Код статуса';
};
  


