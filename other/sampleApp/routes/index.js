var Client = require('pg').Client;

var userName = 'jorgep';

var client = new Client({
    user: userName,
    password: 'password',
    database: 'test',
    host: 'localhost',
    port: 5432
});

exports.index = function(req, res){
  res.render('index', { title: 'Express' });
};

// for this work you need to create this table
// CREATE TABLE stuff (key, value
exports.dbPutTest = function(req, res) {

    console.log("trying to put");
    client.query(
        'INSERT INTO stuff(value) VALUES ($1) RETURNING key;',
        [ Math.floor( Math.random() * 100 ) ],
        function(err, result) {
            if (err) {
                console.log(err);
            }

            console.log('row inserted with id: ' + result.rows[0].key);
            res.send(result.rows);

            client.end();
        });
};

exports.dbGetTest = function(req, res) {
    client.connect(function(err) {
        if(err) {
            return console.error('could not connect to postgres', err);
        }
        client.query('SELECT * FROM stuff', function(err, result) {
            if(err) {
                return console.error('error running query', err);
            }

            client.end();

            console.log(result.rows);
            res.send(result.rows);
        })
    });
};