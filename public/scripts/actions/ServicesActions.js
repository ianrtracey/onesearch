'use strict';

var Reflux = require('reflux');

var ServicesAction = Reflux.createActions([
	'fetch',
	'sync'
]);

module.exports = ServicesAction;