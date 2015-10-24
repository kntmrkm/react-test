Counter = require './counter'
tmpl = require './app.jade'

class App extends React.Component
  constructor: (props) ->
    super props
  render: => tmpl(_.assign {Counter: React.createFactory Counter}, @, @props, @state)

ReactDOM.render React.createElement(App, {}), document.getElementById('app')

# module.exports = App