var constructor = function () {
	var userControllerInstance = {};
	var userDA = require('../dataAccessors/UserDataAccessor');

	// User's Posts Tab
	userControllerInstance.posts = function(req, res) {
		var data = req.body;

		userDA.posts(data, function(err, rowsData) {
			if (err.code = 23505) {
				res.send('Something went wrong.');
			}
			else {
				res.send(rowsData);
			}
		});
	};

	// TODO: Other User's Tabs
	

	return userControllerInstance;
};

module.exports = constructor();