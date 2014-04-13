module.exports = function(app, passport){

    var authController = require('./controllers/authController');

    // render home page
    app.get('/', function(req, res) {
        res.render('index');
        console.log(authController);
    });

    app.post('/auth/login', authController.login);
    app.post('/auth/register', authController.registration);
}

exports.index = function(req, res) {
  res.render('index', { title: 'SprkShare - Spark an Idea' });
};
