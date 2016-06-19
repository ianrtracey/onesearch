'use strict';

var Reflux = require('reflux');

var ServicesAction = Reflux.createActions([
	'fetch',
	'sync',
	'search',
	'filter'
]);

module.exports = ServicesAction;