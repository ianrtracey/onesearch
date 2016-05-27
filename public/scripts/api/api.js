var req = require('./shared/ajax.js');
var source = "http://localhost:9292";

module.exports = {

	getServices: function() {
		var promise = req.get(source+'/services/');
		return promise;
	}
};