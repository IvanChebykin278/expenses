using {expenses as db} from '../../../db/schema';

annotate db.Users with @title: '{i18n>set_title_users}' {
    ID              @title : 'Ид. пользователя'                @Common.Text: '{firstName} {secondName}';
    firstName       @title : 'Имя';
    secondName      @title : 'Фамилия';
};

annotate db.Categories with {
    name            @title : 'Название';
    code            @title : 'Код';
    icon            @UI.Hidden;
};

annotate db.Types with {
    name            @title : 'Название';
    code            @title : 'Код';
    icon            @UI.Hidden;
};

annotate db.Expenses with {
    ID              @title : 'Ид. затраты'               @Common.Text: description @Common.TextArrangement: #TextOnly;
    description     @title : 'Описание';
    cost            @title : 'Сумма'           @Measures.ISOCurrency: currency_code;
    currency_code   @title : 'Код валюты';
    category_code   @title : 'Код категории';
    date            @title : 'Дата операции';
};  


