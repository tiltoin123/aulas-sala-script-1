const sql = require("mssql");

const config = {
    user: 'sa',
    password: 'Leo123!*',
    server: 'localhost',
    port: 1433,
    database: 'ProgSCRIPT',
    options: { encrypt: false }
}

async function connect() {
    try {
        await sql.connect(config)
        console.log('O banco se conectou!');

    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    sql,
    connect
}