var constructor = function() {

    var userDAInstance = {};
    var pg = require('pg');

    userDAInstance.registration = function(data, sendData) {

        var preparedStatement = 'INSERT INTO sparkUsers(Username, UserEmail, UserPassword) VALUES ($1, $2, $3) RETURNING UserId';
        var inserts = [ data.username, data.email, data.password ];

        // for local dev change to process.env.DATABASE_URL
        pg.connect(process.env.DATABASE_URL, function(err, client, done) {
            client.query(preparedStatement, inserts, function(err, result) {
                done();

                if(err) {
                    sendData(err)
                }
                else {
                    sendData(err, result.rows);

                }
            });
        });
    };

    userDAInstance.login = function(req, res) {

        var preparedStatement = 'SELECT * FROM sparkUsers';
        var inserts = [];

        // for local dev change to process.env.DATABASE_URL
        pg.connect(process.env.DATABASE_URL, function(err, client, done) {
            client.query(preparedStatement, inserts, function(err, result) {
                done();

                if(err)
                    sendData(err)
                else
                    sendData(err, result.rows);
            });
        });
    };

    return userDAInstance;
};

module.exports = constructor();