// includes
var express  = require('express'),
    passport = require('passport'),
    flash = require('connect-flash'),
    http = require('http'),
    db = require('./models');

var app = express();
// require('./config/passport')(passport);

app.configure(function() {

    app.set('port', process.env.PORT || 5000);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');

    app.use(express.favicon());
    app.use(express.logger('dev'));
    app.use(express.cookieParser());
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(express.session({ secret: 'mahSecret' }));
    app.use(passport.initialize());
    app.use(passport.session());
    app.use(flash());
    app.use(app.router);
    app.use(express.static(__dirname + '/public' ) );

});

// setup the routes
require('./routes/index.js')(app, passport);

// sync the database models
db.sequelize.sync().complete(function(err){

    if(err) {
        throw err
    } else {
        http.createServer(app).listen(app.get('port'), function(){
            console.log("Listening on port " + app.get('port'));
        });
    }
});
