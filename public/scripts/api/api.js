var source = "http://localhost:9292";
var req = require('../shared/ajax.js');
module.exports = {

	getServices: function() {
		var promise = req.get(source+'/services');
		return promise;
	}
};