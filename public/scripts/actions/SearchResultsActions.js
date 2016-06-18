'use strict';

var Reflux = require('reflux');

var ServicesAction = Reflux.createActions([
	'fetch',
	'sync',
	'search'
]);

module.exports = ServicesAction;