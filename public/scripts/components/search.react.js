var React = require('react');
var _     = require('underscore');
var Handlebars = require('handlebars');


var SearchBar = React.createClass({

	getInitialState: function() {
		return {
			value: null
		};
	},

	componentDidMount: function() {
		var images = {
			"Dropbox": "http://www.icreatemagazine.com/wp-content/uploads/2013/12/Dropbox.png",
			"Google Drive": "http://www.google.com/drive/images/drive/logo-drive.png"
		}
		// Instantiate the Bloodhound suggestion engine
		var movies = new Bloodhound({
		    datumTokenizer: function (datum) {
		        return Bloodhound.tokenizers.whitespace(datum.value);
		    },
		    queryTokenizer: Bloodhound.tokenizers.whitespace,
		    remote: {
		        url: 'http://localhost:9292/search/%QUERY',
		        wildcard: '%QUERY',
		        filter: function (results) {
		        	console.log(results);

		         	return _.map(results.items, function (item) {
		         				return {
		            				name: item['name'],
		                    		icon: item['icon'],
		                    		url:  item['url']
		                    	}
		            		});
		        }
		    }
		});

		// Initialize the Bloodhound suggestion engine
		movies.initialize();
		// Instantiate the Typeahead UI
		$('#search-bar').typeahead(null, {
		    displayKey: 'value',
		    source: movies.ttAdapter(),
		    templates: {
		    	
		        suggestion: Handlebars.compile("<div style='width: 500px' class='ui attached compact raised segment' style='padding:1px'><img class='ui avatar image' src={{icon}}><span><a href='{{url}}'>{{name}}</a></span></div>"),
		        footer: Handlebars.compile("<b>Searched for '{{query}}'</b>")
		    }
		});
	},

	render: function() {
		var searchStyle = {
			width: '500px'
		};
		return (

			 <div className="twelve wide column" id="test_search">
				<div className="ui twelve wide search large">
				  <div id="search" className="ui icon input">
				    <input style={searchStyle} id="search-bar" className="ui search fluid" type="text" placeholder="search..."></input>
				    <i className="search icon"></i>
				  </div>
				</div>
			</div>
		);
	},

});

module.exports = SearchBar;
