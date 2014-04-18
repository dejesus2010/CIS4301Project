module.exports = function(app, passport){

    var authController = require('./controllers/authController'),
    	userController = require('./controllers/userController');

    // render home page
    app.get('/', function(req, res) {
        res.render('index', { title: 'SprkShare - Sprk an Idea' });
        console.log(authController);
    });
    
    // render SprkUser page
    app.get('/userpage', function (req, res) {
    	res.render('userpage', { title: 'SprkUser Pge '});
    	console.log(userController);
    });

    app.post('/auth/login', authController.login);
    app.post('/auth/register', authController.registration);
    app.post('/auth/user', userController.posts);
};

// TODO: Get user's name and attach to title.
// exports.userpage = function(req, res) {
// 	res.render('userpage', { title: 'SprkUser Pge' });
// };