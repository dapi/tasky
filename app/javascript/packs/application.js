/* eslint no-console:0 */

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'styles/application'
import 'jquery'
import 'bootstrap/dist/js/bootstrap'
import './nprogress'
import 'noty_flash'
import 'helpers/data-href'
import dataRemove from 'helpers/data-remove'
import 'helpers/autosize'
import 'helpers/i18n'
import 'helpers/remoteModal'
import 'channels/web_notifications_channel'
import './best_in_place'

import ewcInitialHandler from 'helpers/enableWhenChanged'

import RailsUJS from '@rails/ujs'
import Turbolinks from "turbolinks"
window.Turbolinks = Turbolinks

RailsUJS.start()
Turbolinks.start()

const initialHandler = () => {
  console.log('turbolinks:load Initialize')

  $(document). // TODO bind on modal content only
    on('shown.bs.modal', (e) => $('[autofocus]', e.target).focus() )
  $('.best_in_place').best_in_place()
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-remove]').on('ajax:success', dataRemove)

  ewcInitialHandler($(document))
}

$.ajaxSetup({
  xhrFields: {
    withCredentials: true
  }
})

document.addEventListener('turbolinks:load', initialHandler)

// Support component names relative to this directory:
var componentRequireContext = require.context('components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
