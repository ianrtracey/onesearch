var Reflux = require ('reflux');
var React = require('react');
var SearchResultsActions = require('../actions/SearchResultsActions');
var api = require('../api/api');


var SearchResultsStore = Reflux.createStore({

	listenables: [SearchResultsActions],

	init: function() {
		this.results = [];
		console.log("searchResultsStore init");
	},

	getInitialState: function() {
		this.results = [];
		return this.results;
	},

	onSearch: function(term) {
		var promise = api.search(term);
		console.log('searching: ' + term);
		promise.success(function (json) {
			var data = JSON.parse(json);
			this.results = data["items"];
			this.trigger(this.results)
			console.log('got:');
			console.log(this.results);
		}.bind(this));

		promise.error(function (err) {
			console.error('error fetching list');
		});
	}
});

module.exports = SearchResultsStore;