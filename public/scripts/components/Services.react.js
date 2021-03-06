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
				return <ServiceCard name={service.name} status={service.status}
				 count={service.count} photo_path={service.logo} />;
			})}
			</div>
		</div>
		);
	}
});


var ServiceCard = React.createClass({


	render: function() {
		var actionButton;

	if (this.props.status != "Enabled") {
		actionButton = <button onClick={() => this.handleSync(this.props.name)} className="ui success small button">
		        	Connect
		        </button>;
	} else {
		actionButton = <button onClick={() => this.handleSync(this.props.name)} className="ui red small button">
		        	Disconnect
		        </button>;
	}

		return (
		<div className="column">
		<div className="ui fluid link card tiny">
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
		        {actionButton}
		      </span>
		      <span>
		        <i className="file icon"></i>
		        {this.props.count} files
		      </span>
		    </div>
	  	</div>
	  	</div>
	  	);
	},

	handleSync: function(name) {
		ServiceActions.sync(name);
	}

});

module.exports = Services;