exports.module = function() {

    var authControllerInstance = {};
    var userDA = require('./dataAccessors/UserDataAccessor');
    authControllerInstance.registration = function(req, res) {

        var data = req.body;

        userDA.registration(data, function(err, rowsData){
            if(err)
            {
                res.send('something went wrong');
            }

            res.send(rowsData);
        });
    };

    authControllerInstance.login = function(req, res) {
        var data = req.body;

        userDA.login(data, function(err, rowsData){
            if(err)
            {
                res.send('something went wrong');
            }

            res.send(rowsData);
        });
    };
}