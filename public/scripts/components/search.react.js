var React = require('react');


var content = [
  { title: 'Andorra' },
  { title: 'United Arab Emirates' },
  { title: 'Afghanistan' },
  { title: 'Antigua' },
  { title: 'Anguilla' },
  { title: 'Albania' },
  { title: 'Armenia' },
  { title: 'Netherlands Antilles' },
  { title: 'Angola' },
  { title: 'Argentina' },
  { title: 'American Samoa' },
  { title: 'Austria' },
  { title: 'Australia' },
  { title: 'Aruba' },
  { title: 'Aland Islands' },
  { title: 'Azerbaijan' },
  { title: 'Bosnia' },
  { title: 'Barbados' },
  { title: 'Bangladesh' },
  { title: 'Belgium' },
  { title: 'Burkina Faso' },
  { title: 'Bulgaria' },
  { title: 'Bahrain' },
  { title: 'Burundi' }
  // etc
];


var SearchBar = React.createClass({

	getInitialState: function() {
		return {
			value: null
		};
	},

	componentDidMount: function() {
		console.log('localhost:4567/search/{query}');
		$('.ui.search')
		  .search({
		    apiSettings: {
		      url: '//localhost:4567/search/{query}'
		    },
		    type: 'category',
		    fields: {
		      results : 'matches',
		      title   : 'metadata',
		      url     : 'metadata'
		    },
		    minCharacters : 3
		  });
	},

	render: function() {
		return (
			 <div className="four wide column" id="test_search">
				<div className="ui fluid search large ">
				  <div className="ui icon input">
				    <input className="prompt" type="text" placeholder="search..."></input>
				    <i className="search icon"></i>
				  </div>
				  <div className="results"></div>
				</div>
			</div>
		);
	},

});

module.exports = SearchBar;
