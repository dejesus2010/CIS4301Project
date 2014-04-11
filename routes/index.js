module.exports = function(app, passport){

    // render home page
    app.get('/', function(req, res) {
        res.render('index');
    });
}

// middleware for blocking pages that require to be logged in
function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();

    res.redirect('/');
};
