var authController = require('./authController');

module.exports = function(app, passport){

    // render home page
    app.get('/', function(req, res) {
        res.render('index');
        console.log(authController);
    });

    app.post('/api/user/register', authController.registration);
    app.post('/auth/login', authController.login);
}
