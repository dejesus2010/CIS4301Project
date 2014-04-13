// includes
var express  = require('express'),
    http = require('http');

var app = express();

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
    app.use(app.router);
    app.use(express.static(__dirname + '/public' ) );

    /// catch 404 and forwarding to error handler
    app.use(function(req, res, next) {
        var err = new Error('Not Found');
        err.status = 404;
        next(err);
    });

});

// setup the routes
require('./routes/index.js')(app);
app.get('/', routes.index);
app.get('/users', user.list);

// TODO:
// app.get('/post', routes.post);
// app.get('/user', routes.user);

// sync the database models
http.createServer(app).listen(app.get('port'), function(){
    console.log("Listening on port " + app.get('port'));
});