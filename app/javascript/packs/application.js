/* eslint no-console:0 */

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'noty_flash'
import 'helpers/data-href'
import ewcInitialHandler from 'helpers/enableWhenChanged'
import 'helpers/autosize'
import 'helpers/i18n'
import 'helpers/remoteModal'

import 'channels/web_notifications_channel'

const initialHandler = () => {
  console.log('initialHandler')
  ewcInitialHandler($(document))
}

document.addEventListener('turbolinks:load', initialHandler)
// $(document).ready(handler)

$(document). // TODO bind on modal content only
  on('shown.bs.modal', (e) => $('[autofocus]', e.target).focus() )

// Support component names relative to this directory:
var componentRequireContext = require.context('components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
