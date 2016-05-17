var React = require('react');




var SearchBar = React.createClass({

	render: function() {
		return (
			 <div className="four wide column" id="test_search">
				<div className="ui fluid category search large ">
				  <div className="ui icon input">
				    <input className="prompt" type="text" placeholder="search..."></input>
				    <i className="search icon"></i>
				  </div>
				  <div className="results"></div>
				</div>
			</div>
		);
	}
});

module.exports = SearchBar;
