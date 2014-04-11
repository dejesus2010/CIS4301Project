var passport = require('passport');
var authController = {

    login: passport.authenticate('local', {
        successRedirect: '/auth/login/success',
        failureRedirect: '/auth/login/failure'
    }),

    loginSuccess: function(req, res){
        res.json({
            success: true,
            user: req.session.passport.user
        });
    },

    loginFailure: function(req, res){
        res.json({
            success:false,
            message: 'Invalid username or password.'
        });
    },

    logout: function(req, res){
        req.logout();
        res.end();
    }
};

exports.module = authController;