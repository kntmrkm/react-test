// post for lvh.me:3000/posts/
(function(){
  "use strict";
  var url, params;
  url = '//lvh.me:3000/posts/';
  params = { _method: 'post' };
  params['post'] = {
    title: 'title',
    body:  'body'
  };

  $.ajax({
    type: 'POST',
    url: url,
    data: params
  }).done(function (data, status, xhr) {

  }).fail(function (data, status, xhr, error) {

  });

})();
