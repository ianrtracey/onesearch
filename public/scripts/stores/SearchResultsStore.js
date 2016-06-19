var Reflux = require ('reflux');
var React = require('react');
var SearchResultsActions = require('../actions/SearchResultsActions');
var api = require('../api/api');


var SearchResultsStore = Reflux.createStore({

	listenables: [SearchResultsActions],

	init: function() {
		this.query = null;
		this.results = {};
		console.log("searchResultsStore init");
	},

	getInitialState: function() {
		this.query = null;
		this.results = {};
		return this.results;
	},

	onFilter: function(view_type) {
		var promise = api.search(this.query, view_type)
		console.log('filtering: ' + this.query);
		promise.success(function (json) {
			this.results  = JSON.parse(json);
			this.trigger(this.results)
			console.log('got:');
			console.dir(this.results);
		}.bind(this));

		promise.error(function (err) {
			console.error('error fetching list');
		});
	},

	onSearch: function(term) {
		this.query = term;
		var promise = api.search(term, 'split');
		console.log('searching: ' + term);
		promise.success(function (json) {
			this.results  = JSON.parse(json);
			this.trigger(this.results)
			console.log('got:');
			console.dir(this.results);
		}.bind(this));

		promise.error(function (err) {
			console.error('error fetching list');
		});
	}
});

module.exports = SearchResultsStore;