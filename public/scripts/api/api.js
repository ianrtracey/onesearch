var source = "http://localhost:9292";
var req = require('../shared/ajax.js');
module.exports = {

	getServices: function() {
		var promise = req.get(source+'/services');
		return promise;
	},

	syncService: function(name) {
		var promise = req.get("/services/"+name+"/auth");
		return promise;
	},

	search: function(term) {
		var promise = req.get("/search/" + term);
		return promise;
	}
};