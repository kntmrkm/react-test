tmpl = require './button.jade'
# RaisedButton = React.createFactory(MUI.RaisedButton);
RaisedButton = MUI.RaisedButton;

class Button extends React.Component
  constructor: (props) ->
    super props
  doClick: =>
    alert('Hi !')
    #console.log('Hi in console.')
  render: => tmpl(_.assign { RaisedButton: RaisedButton, doClick: @doClick }, @, @props, @state)

#ReactDOM.render React.createElement(Button, {}), document.getElementById('app')
ReactDOM.render React.createFactory(Button)({}), document.getElementById('app')

# module.exports = App