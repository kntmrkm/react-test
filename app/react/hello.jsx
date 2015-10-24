//var jade = require('react-jade');
var template = require('./hello.jade');
var HelloWorld = React.createClass({
  
  // <HelloWorld />をレンダリング（表示）
  render: function() {
    //return (<p>Hello!World!</p>);
    return template(_.assign({}, this.props, this.state));
    //return template();
  }
});

//ReactDOM.render(<HelloWorld />, document.getElementById('app'));
ReactDOM.render(React.createElement(HelloWorld, {}), document.getElementById('app'));
//ReactDOM.render(React.createFactory(HelloWorld)({}), document.getElementById('app'));
//module.exports = HelloWorld;