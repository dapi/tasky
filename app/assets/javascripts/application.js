// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require best_in_place
//= require bootstrap
//= require nprogress
//= require nprogress-turbolinks
//= require nprogress-ajax
//= require_tree .

const initialize = function() {
  console.log('Initialize')

  jQuery('.best_in_place').best_in_place()
  $('[data-toggle="tooltip"]').tooltip()


  // TODO use rails-ujs and move to webpack
  // data-remove=target
  //
  const removeTr = (el) => {
    $el = $(el.target)
    t = $el.data('remove')
    $(el.target).closest(t).fadeOut()
  }
  $('[data-remove]').on('ajax:success', removeTr)
}

// document.addEventListener('DOMContentLoaded', initialize);
document.addEventListener('turbolinks:load', initialize);
