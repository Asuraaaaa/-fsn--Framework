--client_script 'debug_kng.lua'
-- GLOBAL UTILS
client_script '@fsn_main/cl_utils.lua'
server_script '@fsn_main/sv_utils.lua'

client_script 'client.lua'
client_script 'cl_advanceddamage.lua'
client_script 'cl_carrydead.lua'
client_script 'beds/client.lua'

server_script 'server.lua'
server_script 'sv_carrydead.lua'
server_script 'beds/server.lua'

exports({
  'fsn_IsDead',
  'fsn_EMSDuty',
  'fsn_getEMSLevel',
  'fsn_Airlift',
  'ems_isBleeding',
  'isCrouching',
  'carryingWho'
})