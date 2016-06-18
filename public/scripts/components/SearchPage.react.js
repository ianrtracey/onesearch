var React = require('react');
var Reflux = require('reflux');
var SearchBar = require('./Search.react.js')
var SearchResultsActions = require('../actions/SearchResultsActions.js');
var SearchResultsStore = require('../stores/SearchResultsStore.js');

var SearchPage = React.createClass({

	mixins: [Reflux.connect(SearchResultsStore, 'results')],


	componentDidMount: function() {
		console.log("fetching ");
		// need to handle params that have already been found
		SearchResultsActions.fetch();
		console.log("STATE");
	},

	handleOnChange: function(value) {
		SearchResultsActions.search(value)
	},
/*
	  			<div classNameName="ui segments">
	  					{this.state.results.map(function(result) {
	  						return ( 
	  							<div classNameName="ui segment">
										<p>{result.name}</p>
									</div>
								);
	  					})}
  				</div>
*/
	render: function() {
		return (

		<div className="ui grid container stackable three column">
			<div className="row">
				<div classNameName="ui three wide column">
					<h2>Search Beta</h2>
					<SearchBar showSuggestions="false" onChangeCallback={this.handleOnChange} />
				</div>
			</div>
			<div className="row">
			<div className="column">
				<div className="ui segment fluid">
					<div className="ui horizontal list">
					  <div className="item">
					    <div className="content">
					      <div className="header">Google Drive</div>
					      {this.state.results.length} Files
					    </div>
					  </div>
				  </div>
			</div>
				<div className="ui selection list">
				{this.state.results.map(function(result) {
					return (
						<div className="item">
					    <div className="content">
					      <a className="header">{result.name}</a>
					    </div>
				  	</div>
						);
				})}
				  
				  
				</div>
			</div>
			<div className="column">
				<div className="ui segment">
					<p>Slack</p>
				</div>
			</div>
			<div className="column">
				<div className="ui segment">
					<p>Dropbox</p>
				</div>
			</div>
		</div>
		</div>

		);
	}
});


var ResultsContainer;

// var ResultsBlock = React.createclassName({

// 	getDefaultProps: function() {
// 		return {
// 			results: []
// 		}
// 	},

// 	componentDidMount: function() {
// 		console.log("ResultsBlock state: " + this.props.results)
// 	},

// 	render: function() {
// 		return (
			
// 		)
// 	}
// });

// var ResultsItem = React.createclassName({

// 	render: function() {
// 		return (
				
// 			);
// 	}
// });


module.exports = SearchPage;