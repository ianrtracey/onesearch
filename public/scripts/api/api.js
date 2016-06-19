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

	search: function(term, view_type) {
		var promise = req.get("/search?q=" + term +"&view=" + view_type);
		return promise;
	}
};