var constructor = function() {

    var authControllerInstance = {};
    var userDA = require('../dataAccessors/UserDataAccessor');
    authControllerInstance.registration = function(req, res) {

        var data = req.body;

        userDA.registration(data, function(err, rowsData){
            console.log(err);
            if(err.code = 23505) {
                res.send('That username is already taken');
            } else {
                res.send(rowsData);
            }
        });
    };

    authControllerInstance.login = function(req, res) {
        var data = req.body;

        userDA.login(data, function(err, rowsData){
            if(err.code = 23505) {

                res.send('something went wrong');
            } else {
                res.send(rowsData);
            }
        });
    };

    return authControllerInstance;
};

module.exports = constructor();