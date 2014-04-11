if (!global.hasOwnProperty('db')) {
    var Sequelize = require('sequelize')
        , sequelize = null

    // TODO for local development change to process.env.DATABASE_URL
    if (process.env.HEROKU_POSTGRESQL_COBALT_URL) {
        var match = process.env.HEROKU_POSTGRESQL_COBALT_URL.match(/postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/)

        sequelize = new Sequelize(match[5], match[1], match[2], {
            dialect:  'postgres',
            protocol: 'postgres',
            port:     match[4],
            host:     match[3],
            logging:  true
        })
    }

    global.db = {
        Sequelize: Sequelize,
        sequelize: sequelize,
        User:      sequelize.import(__dirname + '/user')
        // TODO add models here
    }
}

module.exports = global.db;