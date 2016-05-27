var Reflux = require ('reflux');
var api = require('../api/api.js');
var React = require('react');

var ServicesStore = Reflux.createStore({

	listenables: [ServicesAction],

	init: function() {
		this.listenTo(ServicesAction.fetch, this.fetch);
	},

	getInitialState: function() {
		this.list = [];
		return this.list;
	},

	fetch: function() {
		var promise = api.getServices();
		promise.success(function (data) {
			this.list = data;
			this.trigger(this.list);
		}.bind(this));

		promise.error(function (err) {
			console.log('error fetching list');
		});
	}
});

module.exports = ServicesStores;