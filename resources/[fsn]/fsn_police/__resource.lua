resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 'client.lua'
client_script 'dispatch.lua'
server_script 'server.lua'

client_script 'radar/client.lua'
client_script 'pedmanagement/client.lua'

client_script 'MDT/mdt_client.lua'
server_script 'MDT/mdt_server.lua'
ui_page 'MDT/gui/index.html'
files({
  'MDT/gui/index.html',
  'MDT/gui/index.css',
  'MDT/gui/index.js',
  'MDT/gui/images/base_pc.png',
  'MDT/gui/images/win_icon.png',
  'MDT/gui/images/background.png',
  'MDT/gui/images/icons/booking.png',
  'MDT/gui/images/icons/cpic.png',
  'MDT/gui/images/icons/dmv.png',
  'MDT/gui/images/icons/warrants.png',
  'MDT/gui/images/pwr_icon.png'
})

-- Server scripts
server_script '@mysql-async/lib/MySQL.lua'

exports({
  'fsn_PDDuty',
  'fsn_getPDLevel',
  'fsn_getCopAmt'
})
