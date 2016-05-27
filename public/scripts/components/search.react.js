var React = require('react');
var _     = require('underscore');
var Handlebars = require('handlebars');


var country_list = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];


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
