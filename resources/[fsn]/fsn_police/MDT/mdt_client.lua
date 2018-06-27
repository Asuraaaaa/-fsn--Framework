MDTOpen = false
local MDTStations = {
  {x = 441.93865966797, y = -978.95092773438, z = 30.689603805542, h = 175.85954284668},
  {x = 459.79113769531, y = -989.19287109375, z = 24.91487121582, h = 281.77645874023},
  {x = 437.12780761719, y = -996.26257324219, z = 30.689580917358, h = 0.048350848257542},
  {x = 1853.0747070313, y = 3690.072265625, z = 34.267036437988, h = 302.24133300781},
  {x = -449.43377685547, y = 6012.5087890625, z = 31.71639251709, h = 49.228729248047}
}

RegisterNetEvent('fsn_police:MDT:toggle')
AddEventHandler('fsn_police:MDT:toggle', function()
  if MDTOpen then
    SendNUIMessage({
			displayMDT = false
		})
    MDTOpen = false
    SetNuiFocus(false)
  else
    SendNUIMessage({
      displayMDT = true
    })
    MDTOpen = true
    SetNuiFocus(true,true)
  end
end)

RegisterNUICallback("booking-submit-now", function(data, cb)
  TriggerEvent('fsn_police:MDT:toggle')
  --TriggerServerEvent('fsn_police:database:CPIC', data)
  TriggerServerEvent('fsn_police:chat:ticket', data.suspectID, data.jailFine, data.jailTime, data.charges)
  -- TICKET
  if tonumber(data.jailFine) > 0 then
    TriggerServerEvent('fsn_police:ticket', tonumber(data.suspectID), tonumber(data.jailFine))
  end
  -- JAIL TIME
  if tonumber(data.jailTime) > 0 then
    if tonumber(data.jailTime) <= 300 then
      local jailtime = tonumber(data.jailTime)*60
      TriggerServerEvent('fsn_jail:sendsuspect', GetPlayerServerId(PlayerId()), data.suspectID, jailtime)
    else
      TriggerEvent('fsn_notify:displayNotification', 'You cannot jail someone for more than 300 minutes.', 'centerLeft', 5000, 'error')
    end
  end
end)

RegisterNUICallback("closeMDT", function(data, cb)
	TriggerEvent('fsn_police:MDT:toggle')
end)

RegisterNUICallback("setWaypoint", function(data, cb)
  SetNewWaypoint(data.x, data.y)
  TriggerEvent('fsn_notify:displayNotification', '<b>Waypoint added</b><br>Call: <span style="color:#f9aa43">'..data.tencode..'</span><br>Location: <span style="color:#4286f4">'..data.loc, 'centerRight', 8000, 'info')
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) and amicop then
      if IsControlJustPressed(0,244) and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1))) == 18 and IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1))) then
        TriggerEvent('fsn_police:MDT:toggle')
        TriggerEvent('fsn_commands:me', 'uses the onboard computer...')
      end
    end
    for k, stn in pairs(MDTStations) do
      if GetDistanceBetweenCoords(stn.x,stn.y,stn.z,GetEntityCoords(GetPlayerPed(-1)), true) < 10 and amicop then
        DrawMarker(1,stn.x,stn.y,stn.z-1,0,0,0,0,0,0,1.001,1.0001,0.4001,0,155,255,175,0,0,0,0)
        if GetDistanceBetweenCoords(stn.x,stn.y,stn.z,GetEntityCoords(GetPlayerPed(-1)), true) < 1 then
          SetTextComponentFormat("STRING")
          AddTextComponentString("Press ~INPUT_INTERACTION_MENU~ to access the ~p~MDT")
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)
          if IsControlJustPressed(0,244) then
            SetEntityCoords(GetPlayerPed(-1), stn.x,stn.y,stn.z-1)
            SetEntityHeading(GetPlayerPed(-1),stn.h)
            TriggerEvent('fsn_police:MDT:toggle')
          end
        end
      end
    end
  end
end)
