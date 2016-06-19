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
		console.log("view is" + this.state.results['view_type']);
		resultsView = null;
		if (this.state.results['view_type'] == 'card') {
			resultsView = <CardView results={this.state.results['results']} />
		}
		if (this.state.results['view_type'] == 'split') {
			resultsView = <SplitView results={this.state.results['results']} />
		}

		return (
		<div>
		<div className="ui one column centered grid">
			<div className="row">
				<div classNameName="column">
					<h2>Search Beta2</h2>
					<FilterControls />
					<SearchBar showSuggestions="false" onChangeCallback={this.handleOnChange} />
					{resultsView}
				</div>
			</div>
		</div>

		</div>

		);
	}
});

var SplitView = React.createClass({


	render: function() {
		return (
		<div className="ui grid container stackable three column">
			<div className="row">
			{ _.keys(this.props.results).map(function(service_name) {
				return (
					<div className="column">

					<div className="ui segment fluid">
						<div className="ui horizontal list">
					  <div className="item">
					    <div className="content">
					      <div className="header">{service_name}</div>
					          {this.props.results[service_name].length} Results
					    </div>
					 	</div>
				 		</div>
					</div>
					<div className="ui selection list">
						{this.props.results[service_name].map(function(result) {
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
			)
	}
});

var CardView = React.createClass({


	render: function() {			  
		return (
		<div className="ui grid container stackable five column">
			<div className="row">
					{this.props.results.map(function(result) {
						return (
								<div className="column">
									<div className="ui link card">
								  <div className="content">
								    <div className="header"></div>
								    <div className="meta">
								      <span className="category">{result.name}</span>
								    </div>
								    <div className="description">
								      <p></p>
								    </div>
								  </div>
								  <div className="extra content">
								    <div className="right floated author">
								      <div><img className="ui avatar image" src="/images/avatar/small/matt.jpg"></img>{result.source}</div>
								    </div>
								  </div>
									</div>
								</div>
							);
					})}
			</div>
		</div>
		);
	}
});

var FilterControls = React.createClass({


	handleSplitAction: function() {
		console.log("calling splitify()");
		SearchResultsActions.filter('split');
	},

	handleCardAction: function() {
		console.log("calling cardify()");
		SearchResultsActions.filter('card');
	},

	render: function() {
		return (
			<div className="ui large buttons">
  			<button onClick={this.handleSplitAction} className="ui button active">Split</button>
  			<div className="or"></div>
  			<button onClick={this.handleCardAction} className="ui button">Card</button>
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
