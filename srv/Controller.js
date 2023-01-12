const cds = require('@sap/cds');

module.exports = (srv) => {
    const { Users } = srv.entities;
    const updateDebtStatus = (status) => (req) => UPDATE(req.target).with({ debt_status_code: status }).where({ ID: req.params[0].ID });
    const updateDebtUser = (fieldName) => (req) => req.data[fieldName] = req.data[fieldName] || req.user.id;
    const checkUserExistence = () => (req) => { debugger; };

    // global actions
    srv.on('checkUserExistence', async (req) => {
        const { id, attr } = req.user;
        const tx = cds.transaction();
        const query = SELECT.one(Users).where({ id });
        const user = await tx.run(query);

        if(!user) {
            const [ fullname, domen ] = id.split('@');
            const [ firstName, secondName ] = fullname.split('.');

            const data = { ID: id, firstName: attr.firstName || firstName, secondName: attr.secondName || secondName };
            const query = INSERT.into(Users).entries(data);

            const user = await tx.run(query);
        }

        await tx.commit();
    });

    // Debts
    srv.before('CREATE', 'Debts', updateDebtUser('debtor_id'));
    srv.before('NEW', 'Debts', updateDebtUser('debtor_id'));
    srv.before('SAVE', 'Debts', updateDebtUser('debtor_id'));

    srv.on('closeDebt', updateDebtStatus('CLOSED'));
    srv.on('declineDebt', updateDebtStatus('DECLINED'));

    // Credits
    srv.before('CREATE', 'Credits', updateDebtUser('creditor_id'));
    srv.before('NEW', 'Credits', updateDebtUser('creditor_id'));
    srv.before('SAVE', 'Credits', updateDebtUser('creditor_id'));

    srv.on('closeCredit', updateDebtStatus('CLOSED'));
    srv.on('declineCredit', updateDebtStatus('DECLINED'));
};