/*
"use strict";
return function() {
var Hello = require("./react/test");
var React = require('react');
var ReactDOM = require('react-dom');
*/

$((function(_this) {
  return function() {
    //return console.log('initialized!', new Date);
    //console.log('initialize!', new Date);
    
    //var $ = require('jquery');
    
    is = require('is_js');
    cssua = require('cssuseragent');
    
    MUI = require('material-ui');
    React = require('react');
    // http://qiita.com/koba04/items/9709510cc68256557f2e
    //React = require('react/addons'); # require('react-addons-{addon}');
    ReactDOM = require('react-dom');
    //import * as React from 'react';
    //require("./react/hello");
    //require("./react/app");
    require("./react/button");
    
    var injectTapEventPlugin = require("react-tap-event-plugin");
    injectTapEventPlugin();

    //console.log(is.null(null));
    //var Hello = require('./scripts/hello');
    //var hello = new Hello();
    //console.log(hello.message);

    //require("./vanilla");
    //require("./scripts/require_test");
    //require("./scripts/post");
    
    console.log('initialized.');
  };
})(this));

/*
(function(){
  console.log('intermediate.');
})();
(function(){
  console.log('no name.');
});
*/