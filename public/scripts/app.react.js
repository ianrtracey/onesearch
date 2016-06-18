var React = require('react');
var ReactDOM = require('react-dom');
var SearchBar = require('./components/Search.react.js');
var Menu = require('./components/Menu.react.js');
var Router = require('react-router').Router;
var Route  = require('react-router').Route;
var Link   = require('react-router').Link;
var IndexRoute = require('react-router').IndexRoute;
var hashHistory = require('react-router').hashHistory;

var Services = require('./components/Services.react.js');
var SearchPage = require('./components/SearchPage.react.js');
var api = require('./api/api.js') 
var req = require('./shared/ajax.js');


var App = React.createClass({
	render: function() {
		return (
			<div>
			<div className="ui medium menu">
        <Link to="/" className="item">
          Home 
        </Link>
        <Link to="/services" className="item">
          Services 
        </Link>
        <div className="right menu">
          <div className="ui dropdown item">
            Language <i className="dropdown icon"></i>
            <div className="menu">
              <a className="item">English</a>
              <a className="item">Russian</a>
              <a className="item">Spanish</a>
            </div>
          </div>
          <div className="item">
              <div className="ui primary button">Sign Up</div>
          </div>
        </div>
     </div>
				<div className="ui center aligned grid container">
					{this.props.children}	
				</div>
			</div>	
		);
	}
});



ReactDOM.render((
		<Router history={hashHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={SearchBar} />
      <Route path="services" component={Services} />
      <Route path="search"   component={SearchPage} />
    </Route>
  </Router>), document.getElementById('app'));
