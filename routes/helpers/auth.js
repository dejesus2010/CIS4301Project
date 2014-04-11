var pg = require('pg').native;
var PassportLocalStrategy = require('passport-local').Strategy;

var auth = {};
auth.localStrategy = new PassportLocalStrategy({
        username: 'username',
        password: 'password'
    },

    function (username, password, done){
        var User = require('../../models/User').User;
        User.find({username: username}).success(function(user){
            if (!user){
                return done(null, false, { message: 'Nobody here by that name'} );
            }
            if (user.password !== password){
                return done(null, false, { message: 'Wrong password'} );
            }
            return done(null, { username: user.username });
        });
    }
);

auth.validPassword = function(password){
    return this.password === password;
}

auth.serializeUser = function(user, done){
    done(null, user);
};

auth.deserializeUser = function(obj, done){
    done(null, obj);
};