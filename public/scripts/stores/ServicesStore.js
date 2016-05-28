var Reflux = require ('reflux');
var React = require('react');
var ServicesAction = require('../actions/ServicesActions');
var api = require('../api/api');


var ServicesStore = Reflux.createStore({

	listenables: [ServicesAction],

	init: function() {
		this.serviceList = [];
		this.listenTo(ServicesAction.fetch, this.fetch);
		console.log("service store init");

	},

	getInitialState: function() {
		this.serviceList = [];
		return this.serviceList;
	},

	fetch: function() {
		var promise = api.getServices();
		promise.success(function (json) {
			var data = JSON.parse(json);
			this.serviceList = data['services'];
			console.log(data);
			this.trigger(this.serviceList);
		}.bind(this));

		promise.error(function (err) {
			console.error('error fetching list');
		});
	}
});

module.exports = ServicesStore;