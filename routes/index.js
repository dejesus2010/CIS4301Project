var authController = require('./authController');

module.exports = function(app, passport){

    // render home page
    app.get('/', function(req, res) {
        res.render('index');
    });

    app.post('/auth/login', authController.login);

    app.get('auth/login/success', authController.loginSuccess);

    app.get('/auth/login/failure', authController.loginFailure);

}

// middleware for blocking pages that require to be logged in
function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();

    res.redirect('/');
};
