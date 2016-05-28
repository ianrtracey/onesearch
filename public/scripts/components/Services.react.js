var React = require('react');
var ServiceStore = require('../stores/ServicesStore');
var ServiceActions = require('../actions/ServicesActions.js');
var Reflux = require('reflux');

var Services = React.createClass({

	mixins: [Reflux.connect(ServiceStore, 'serviceList')],


	componentDidMount: function() {
		console.log("fetching services...");
		ServiceActions.fetch();
		console.log(this.state);
	},

	render: function() {
		return (
		<div className="twelve wide column">
			<h2>Services</h2>
			<div className="ui three column grid">
			{this.state.serviceList.map(function(service) {
				return <ServiceCard name={service.name} status={service.status} photo_path={service.url} />;
			})}
			</div>
		</div>
		);
	}
});


var ServiceCard = React.createClass({

	render: function() {
		return (
		<div className="column">
		<div className="ui fluid link card">
		    <div className="image">
		      <img src={this.props.photo_path}></img>
		    </div>
		    <div className="content">
		      <div className="header">{this.props.name}</div>
		      <div className="meta">
		        <p>{this.props.status}</p>
		      </div>
		      <div className="description">
		        Matthew is an interior designer living in New York.
		      </div>
		    </div>
		    <div className="extra content">
		      <span className="right floated">
		        Joined in 2013
		      </span>
		      <span>
		        <i className="user icon"></i>
		        75 Friends
		      </span>
		    </div>
	  	</div>
	  	</div>
	  	);
	}

});

module.exports = Services;