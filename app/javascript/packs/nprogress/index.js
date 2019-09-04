import NProgress from 'nprogress/nprogress.js'
import 'nprogress/nprogress.css'
import './nprogress-bootstrap.css'
import './nprogress-turbolinks5.css'


NProgress.configure({ showSpinner: false })

// nprogress-turbolinks from
// https://github.com/caarlos0-graveyard/nprogress-rails/blob/master/app/assets/javascripts/nprogress-turbolinks.js
jQuery(function() {
  jQuery(document).on('page:fetch turbolinks:request-start', function() {
    NProgress.start();
  });
  jQuery(document).on('page:receive turbolinks:request-end', function() {
    NProgress.set(0.7);
  });
  jQuery(document).on('page:change turbolinks:load', function() {
    NProgress.done();
  });
  jQuery(document).on('page:restore turbolinks:request-end turbolinks:before-cache', function() {
    NProgress.remove();
  });
});

// nprogress-ajax from
// https://raw.githubusercontent.com/caarlos0-graveyard/nprogress-rails/master/app/assets/javascripts/nprogress-ajax.js

jQuery(function() {
  jQuery(document).on('ajaxStart', function() { NProgress.start(); });
  jQuery(document).on('ajaxStop',  function() { NProgress.done();  });
});
