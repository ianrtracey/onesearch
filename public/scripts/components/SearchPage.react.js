var React = require('react');
var Reflux = require('reflux');
var SearchBar = require('./Search.react.js')
var SearchResultsActions = require('../actions/SearchResultsActions.js');
var SearchResultsStore = require('../stores/SearchResultsStore.js');

var _ = require('underscore');

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
		<div>
		<div className="ui one column centered grid">
			<div className="row">
				<div classNameName="column">
					<h2>Search Beta2</h2>
					<SearchBar showSuggestions="false" onChangeCallback={this.handleOnChange} />
				</div>
			</div>
		</div>
		<div className="ui grid container stackable three column">
			<div className="row">
			{ _.keys(this.state.results).map(function(service_name) {
				return (
					<div className="column">

					<div className="ui segment fluid">
						<div className="ui horizontal list">
					  <div className="item">
					    <div className="content">
					      <div className="header">{service_name}</div>
					          {this.state.results[service_name].length} Results
					    </div>
					 	</div>
				 		</div>
					</div>
					<div className="ui selection list">
						{this.state.results[service_name].map(function(result) {
								return (
							<div className="item">
					    <div className="content">
					      <a className="header" href={result.url}>{result.name}</a>
					    </div>
				  		</div>
								);
						})}
					</div>
					</div>
				);
			}.bind(this))}				  
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
