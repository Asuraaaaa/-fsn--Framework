
-------------------
-- Instance stuff
-- _seriously idk why this is here_
-------------------
local instanced = false
local myinstance = {}
function instanceMe(state)
	instanced = state
	TriggerEvent('tokovoip_extras:muteall', state)
end
function inInstance()
	return instanced	
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for _, id in ipairs(GetActivePlayers()) do
			if instanced then
				SetVehicleDensityMultiplierThisFrame(0.0)
				SetRandomVehicleDensityMultiplierThisFrame(0.0)
				local ped = GetPlayerPed(id)
				if ped ~= GetPlayerPed(-1) then
					SetEntityVisible(ped, false, 0)
					SetEntityCollision(ped, false, false)
				end
			else
				SetVehicleDensityMultiplierThisFrame(0.2)
				SetRandomVehicleDensityMultiplierThisFrame(0.2)
				local ped = GetPlayerPed(id)
				if ped ~= GetPlayerPed(-1) then
					SetEntityVisible(ped, true, 0)
					SetEntityCollision(ped, true, true)
				end
			end
		end
	end
end)

------------------------------------------------------------------------------------ actual system
local menuEnabled = false
local init = true
function fsn_drawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 140)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local myRoomNumber = 32
local building = false
local inappt = false
local inWardrobe = false
local apptdetails = {}

RegisterNetEvent('fsn_apartments:stash:add')
AddEventHandler('fsn_apartments:stash:add', function(amt)
	if inappt then
		if amt > 0 and amt < 150000 then
			if exports["fsn_main"]:fsn_CanAfford(amt) then
				if apptdetails.apt_cash + amt <= 150000 then
					apptdetails.apt_cash = apptdetails.apt_cash + amt
					TriggerEvent('fsn_bank:change:walletMinus', amt)
					TriggerServerEvent('fsn_apartments:saveApartment', apptdetails)
				else
					TriggerEvent('fsn_notify:displayNotification', 'You cannot store this amount.', 'centerRight', 4000, 'error')
				end
			else
				TriggerEvent('fsn_notify:displayNotification', 'You cannot afford this.', 'centerRight', 4000, 'error')
			end	
		end
	else
		TriggerEvent('fsn_notify:displayNotification', 'You need to be in your appartment.', 'centerRight', 4000, 'error')
	end
end)

RegisterNetEvent('fsn_apartments:stash:take')
AddEventHandler('fsn_apartments:stash:take', function(amt)
	if inappt then
		if amt > 0 and amt < 150000 then
			if apptdetails.apt_cash >= amt then
				apptdetails.apt_cash = apptdetails.apt_cash - amt
				TriggerEvent('fsn_bank:change:walletAdd', amt)
				TriggerServerEvent('fsn_apartments:saveApartment', apptdetails)
			else
				TriggerEvent('fsn_notify:displayNotification', 'Your stash does not have that much.', 'centerRight', 4000, 'error')
			end
		end
	else
		TriggerEvent('fsn_notify:displayNotification', 'You need to be in your appartment.', 'centerRight', 4000, 'error')
	end
end)

RegisterNetEvent('fsn_apartments:sendApartment')
AddEventHandler('fsn_apartments:sendApartment', function(tbl)
	if tbl.number then
		EnterRoom(tbl.number)
		myRoomNumber = tbl.number
		apptdetails = tbl.apptinfo
		apptdetails["apt_outfits"] = json.decode(tbl.apptinfo.apt_outfits)
		apptdetails["apt_inventory"] = json.decode(tbl.apptinfo.apt_inventory)
		apptdetails["apt_utils"] = json.decode(tbl.apptinfo.apt_utils)
		init = true
		TriggerEvent('fsn_notify:displayNotification', 'Your apartment number is: '..tbl.number, 'centerRight', 6000, 'info')
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r IT LOOKS LIKE YOU ARE BROKE I DO NOT HAVE AN APPT NUMBER FOR YOU')
		EnterRoom(1)
		myRoomNumber = 1
		apptdetails = {}
		apptdetails["apt_outfits"] = {}
		apptdetails["apt_inventory"] = {}
		apptdetails["apt_utils"] = {}
		init = true
		TriggerEvent('fsn_notify:displayNotification', 'Your apartments is number: 1', 'centerRight', 6000, 'info')
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You can still play, but this apartment will not save.')
	end
end)

RegisterNetEvent('fsn_apartments:outfit:add')
AddEventHandler('fsn_apartments:outfit:add', function(key)
	if inWardrobe then
		apptdetails.apt_outfits[key] = exports["fsn_clothing"]:GetOutfit()
		
		TriggerServerEvent('fsn_apartments:saveApartment', apptdetails)
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You need to be at your wardrobe to add an outfit.')
	end
end)
RegisterNetEvent('fsn_apartments:outfit:use')
AddEventHandler('fsn_apartments:outfit:use', function(key)
	if inWardrobe then
		if apptdetails.apt_outfits[key] then
			TriggerEvent("clothes:spawn", apptdetails.apt_outfits[key])
			TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r Outfit used.')
		else
			TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r There does not look to be an outfit with the name: '..key)
		end	
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You need to be at your wardrobe to change outfits.')
	end
end)

RegisterNetEvent('fsn_apartments:outfit:remove')
AddEventHandler('fsn_apartments:outfit:remove', function(key)
	if inWardrobe then
		if apptdetails.apt_outfits[key] then
			apptdetails.apt_outfits[key] = nil
			TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r Outfit removed.')
		else
			TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r There does not look to be an outfit with the name: '..key)
		end
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You need to be at your wardrobe to remove an outfit.')
	end
end)
RegisterNetEvent('fsn_apartments:outfit:list')
AddEventHandler('fsn_apartments:outfit:list', function()
	if inWardrobe then
		if apptdetails.apt_outfits then
			local keys = {}
			for k, v in pairs(apptdetails.apt_outfits) do
				table.insert(keys, #keys+1, k)
			end
			local str = table.concat(keys, ", ")
			if #keys > 0 then
				TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r Saved outfits: '..str)
			else
				TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You do not have any outfits saved.')
			end
		else
			TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You do not have any outfits saved.')
		end
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^1^*:FSN:^0^r You need to be at your wardrobe to use this command.')
	end
end)

apartments = {
	[1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115},
	[2] = { ["x"] = 311.27377319336,["y"] = -217.74626159668, ["z"] = 54.221797943115},
	[3] = { ["x"] = 307.63830566406,["y"] = -216.43359375, ["z"] = 54.221797943115}, 
	[4] = { ["x"] = 307.71112060547,["y"] = -213.40884399414, ["z"] = 54.221797943115}, 
	[5] = { ["x"] = 309.95989990234,["y"] = -208.48258972168, ["z"] = 54.221797943115},
	[6] = { ["x"] = 311.78106689453,["y"] = -203.50025939941, ["z"] = 54.221797943115}, 
	[7] = { ["x"] = 313.72155761719,["y"] = -198.6107635498, ["z"] = 54.221797943115},
	[8] = { ["x"] = 315.5329284668,["y"] = -195.24925231934, ["z"] = 54.226440429688},
	[9] = { ["x"] = 319.23147583008,["y"] = -196.4300994873, ["z"] = 54.226451873779},
	[10] = { ["x"] = 321.08117675781,["y"] = -197.23593139648, ["z"] = 54.226451873779},
	[11] = { ["x"] = 312.98037719727,["y"] = -218.36080932617, ["z"] = 58.019248962402},
	[12] = { ["x"] = 311.10736083984,["y"] = -217.64399719238, ["z"] = 58.019248962402},
	[13] = { ["x"] = 307.37707519531,["y"] = -216.34501647949, ["z"] = 58.019248962402},
	[14] = { ["x"] = 307.76007080078,["y"] = -213.59916687012, ["z"] = 58.019248962402},
	[15] = { ["x"] = 309.76248168945,["y"] = -208.25439453125, ["z"] = 58.019248962402},
	[16] = { ["x"] = 311.48220825195,["y"] = -203.75033569336, ["z"] = 58.019248962402},
	[17] = { ["x"] = 313.65570068359,["y"] = -198.22790527344, ["z"] = 58.019248962402},
	[18] = { ["x"] = 315.47378540039,["y"] = -195.19331359863, ["z"] = 58.019248962402},
	[19] = { ["x"] = 319.39694213867,["y"] = -196.58866882324, ["z"] = 58.019248962402},
	[20] = { ["x"] = 321.19458007813,["y"] = -197.31185913086, ["z"] = 58.019248962402},
	[21] = { ["x"] = 329.49240112305,["y"] = -224.92803955078, ["z"] = 54.221771240234},
	[22] = { ["x"] = 331.33309936523,["y"] = -225.56880187988, ["z"] = 54.221771240234},
	[23] = { ["x"] = 335.18447875977,["y"] = -227.14477539063, ["z"] = 54.221771240234},
	[24] = { ["x"] = 336.71957397461,["y"] = -224.66767883301, ["z"] = 54.221771240234},
	[25] = { ["x"] = 338.79501342773,["y"] = -219.11264038086, ["z"] = 54.221771240234},
	[26] = { ["x"] = 340.43829345703,["y"] = -214.78857421875, ["z"] = 54.221771240234},
	[27] = { ["x"] = 342.28509521484,["y"] = -209.32579040527, ["z"] = 54.221771240234},
	[28] = { ["x"] = 344.39224243164,["y"] = -204.4561920166, ["z"] = 54.221881866455},
	[29] =  { ['x'] = 346.75,['y'] = -197.52,['z'] = 54.23 },
	[30] = { ["x"] = 329.7096862793,["y"] = -224.65902709961, ["z"] = 58.019248962402}, 
	[31] = { ["x"] = 331.52966308594,["y"] = -225.52110290527, ["z"] = 58.019248962402}, 
	[32] = { ["x"] = 335.16506958008,["y"] = -227.07464599609, ["z"] = 58.019248962402},
	--[33] = { ["x"] = 336.35406494141,["y"] = -224.58212280273, ["z"] = 58.019245147705}, 
	--[34] = { ["x"] = 338.56127929688,["y"] = -219.3408203125, ["z"] = 58.019245147705},
	--[35] = { ["x"] = 340.5012512207,["y"] = -214.33885192871, ["z"] = 58.019245147705},
	--[36] = { ["x"] = 342.41970825195,["y"] = -209.25254821777, ["z"] = 58.019245147705},
	--[37] = { ["x"] = 344.03280639648,["y"] = -204.98118591309, ["z"] = 58.019245147705},
	--[38] = { ["x"] = 346.08560180664,["y"] = -199.59660339355, ["z"] = 58.019245147705},
	[33] = {x = -120.01621246338, y = -1477.9357910156, z = 33.822704315186},
	[34] = {x = -125.4533996582, y = -1473.5347900391, z = 33.822700500488},
	[35] = {x = -132.37168884277, y = -1462.9610595703, z = 33.822708129883},
	[36] = {x = -122.81175994873, y = -1460.0072021484, z = 33.822723388672},
	[37] = {x = -113.4861831665, y = -1467.9312744141, z = 33.822696685791},
	[38] = {x = -107.9939956665, y = -1473.0483398438, z = 33.822673797607},
	[39] = {x = -112.86763763428, y = -1478.9178466797, z = 33.822696685791},
	[40] = {x = -119.18539428711, y = -1486.1198730469, z = 36.982070922852},
	[41] = {x = -112.61432647705, y = -1479.3171386719, z = 36.992156982422},
	[42] = {x = -107.64716339111, y = -1473.2631835938, z = 36.992156982422},
	[43] = {x = -113.49381256104, y = -1467.82421875, z = 36.992134094238},
	[44] = {x = -122.68350219727, y = -1459.9815673828, z = 36.992134094238},
	[45] = {x = -127.70810699463, y = -1457.0584716797, z = 37.791881561279},
	[46] = {x = -132.34898376465, y = -1462.6154785156, z = 36.992137908936},
	[47] = {x = -138.16300964355, y = -1470.6784667969, z = 36.992130279541},
	[48] = {x = -125.84031677246, y = -1473.7208251953, z = 36.992092132568},
	[49] = {x = -119.94772338867, y = -1478.3133544922, z = 36.992092132568},
	[50] = {x = -65.10823059082, y = -1512.9466552734, z = 33.436138153076},
	[51] = {x = -59.951992034912, y = -1517.1645507813, z = 33.436096191406}	
}

local storage = {x = 151.31591796875, y = -1003.1566772461, z = -99.000007629395}
local cash = {x = 154.14666748047, y = -1006.1190185547, z = -99.0}
local outfits = {x = 151.8991394043, y = -1001.5586547852, z = -99.0}
local leave = {x = 151.31465148926, y = -1007.9354858398, z = -98.999969482422}

function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if not apptdetails["apt_utils"]["weapons"] then
		apptdetails["apt_utils"]["weapons"] = {}
	end
	if not apptdetails["apt_utils"]["inventory"] then
		apptdetails["apt_utils"]["inventory"] = {}
	end
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showmenu = true,
			weapons = json.encode(apptdetails["apt_utils"]["weapons"]),
			inventory = json.encode(apptdetails["apt_utils"]["inventory"])
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			hidemenu = true
		})
	end
end

local last_click = 0

RegisterNetEvent('fsn_apartments:store:item')
AddEventHandler('fsn_apartments:store:item', function(item, amt)
	if not apptdetails["apt_utils"]["inventory"] then apptdetails["apt_utils"]["inventory"] = {} end
	
	if not apptdetails["apt_utils"]["inventory"][item] then
		apptdetails["apt_utils"]["inventory"][item] = amt
		print('stored '..apptdetails["apt_utils"]["inventory"][item]..' '..item)
	else
		local newAMT = apptdetails["apt_utils"]["inventory"][item] + amt
		print('you already have '..apptdetails["apt_utils"]["inventory"][item]..' stored, changing to '..newAMT)
		apptdetails["apt_utils"]["inventory"][item] = newAMT
	end
	--if not apptdetails["apt_utils"]["inventory"] then
	--	if not apptdetails["apt_utils"]["inventory"][item] then
	--		apptdetails["apt_utils"]["inventory"][item] = amt
	--	else
	--		apptdetails["apt_utils"]["inventory"][item] = apptdetails["apt_utils"]["inventory"][item] + amt	
	--	end
	--end	
	saveApartment()
	ExecuteCommand('save')
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end
RegisterNUICallback( "inventoryTake", function( data, cb )
	if last_click + 5000 > GetNetworkTime() then print('toosoon') return end
	ToggleActionMenu()
	Citizen.CreateThread(function()
		DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "#ID NUMBER", "", "", "", "", 10)
		local editOpen = true
		while UpdateOnscreenKeyboard() == 0 or editOpen do
			Wait(0)
			drawTxt('How many '..data..' would you like to take?',4,1,0.5,0.35,0.6,255,255,255,255)
			drawTxt('~r~Enter a number value or "all"',4,1,0.5,0.49,0.4,255,255,255,255)
			if UpdateOnscreenKeyboard() ~= 0 then
				editOpen = false
				if UpdateOnscreenKeyboard() == 1 then
					res = GetOnscreenKeyboardResult()
					if res == 'all' then
						--TriggerEvent('fsn_apartments:store:item', data.item, exports["fsn_inventory"]:fsn_GetItemAmount())
						TriggerEvent('fsn_inventory:item:add', data, apptdetails["apt_utils"]["inventory"][data])
						--table.remove(apptdetails["apt_utils"]["inventory"], data)
						apptdetails["apt_utils"]["inventory"][data] = nil
					else
						if tonumber(res) then
							res = tonumber(res)
							if res > 0 and res < 500 then
								--TriggerEvent('fsn_apartments:store:item', data.item, res)
								--print('trying to store '..res..' x '..data.item)
								if res <= apptdetails["apt_utils"]["inventory"][data] then
									if exports["fsn_inventory"]:fsn_CanCarry(data, res) then
										if apptdetails["apt_utils"]["inventory"][data] == res then
											TriggerEvent('fsn_inventory:item:add', data, res)
											--table.remove(apptdetails["apt_utils"]["inventory"], data)
											apptdetails["apt_utils"]["inventory"][data] = nil
										else
											TriggerEvent('fsn_inventory:item:add', data, res)
											apptdetails["apt_utils"]["inventory"][data] = apptdetails["apt_utils"]["inventory"][data] - res
										end
									else
										TriggerEvent('fsn_notify:displayNotification', 'You cannot carry this, you are not a gym lad.', 'centerLeft', 3000, 'error')
									end
								else
									TriggerEvent('fsn_notify:displayNotification', 'There is not this many stored.', 'centerLeft', 3000, 'error')
								end
							else
								TriggerEvent('fsn_notify:displayNotification', 'Looks to be an issue with the number you entered.', 'centerLeft', 3000, 'error')
							end
						else
							TriggerEvent('fsn_notify:displayNotification', 'You didn\'t enter \'all\' or a number.', 'centerLeft', 3000, 'error')
						end
					end
					saveApartment()
					ExecuteCommand('save')
					break
				end
			end
		end
	end)
end)

RegisterNUICallback( "weaponInfo", function( data, cb )
	if last_click + 5000 > GetNetworkTime() then print('toosoon') return end
	v = data
	TriggerEvent('chatMessage', '', {255,255,255}, '^1^*WeaponInfo |^0^r '..v.name..' | Registered to: '..v.owner.name..' | Serial: '..v.owner.serial)
end)

RegisterNUICallback( "weaponEquip", function( data, cb )
	if last_click + 5000 > GetNetworkTime() then print('toosoon') return end
	
	for key, wep in pairs(apptdetails["apt_utils"]["weapons"]) do
		if wep.name == data.name then
			TriggerEvent('fsn_criminalmisc:weapons:add:tbl', apptdetails["apt_utils"]["weapons"][key])
			TriggerEvent('fsn_notify:displayNotification', 'You equipped '..wep.name, 'centerRight', 6000, 'success')
			table.remove(apptdetails["apt_utils"]["weapons"], key)
			ToggleActionMenu()
			ExecuteCommand('save')
			saveApartment()
			break
		end
	end
end)
RegisterNUICallback( "ButtonClick", function( data, cb )
	if last_click + 1000 > GetNetworkTime() then print('toosoon') return end
	last_click = GetNetworkTime()
	if data == 'weapon-putaway' then
		print 'attempting to put away weapon'
		ToggleActionMenu()
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == -1569615261 then
			TriggerEvent('fsn_notify:displayNotification', 'You cannot store your fists.', 'centerRight', 10000, 'error')
			return
		end
		local weapon = exports["fsn_criminalmisc"]:weaponInfo(GetSelectedPedWeapon(GetPlayerPed(-1)))
		print(json.encode(weapon))
		table.insert(apptdetails["apt_utils"]["weapons"],#apptdetails["apt_utils"]["weapons"]+1, weapon)
		TriggerEvent('fsn_criminalmisc:weapons:destroy')
		saveApartment()
		ExecuteCommand('save')
	elseif( data == "exit" ) then
		ToggleActionMenu()
		return
	end
end)
local instorage = false 
function isNearStorage()
	return instorage 
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if init then
			if inappt then
				-- storage
				DrawMarker(25, storage.x, storage.y, storage.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(storage.x, storage.y, storage.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(storage.x, storage.y, storage.z, "[E] access storage")--\n~r~Not available yet")
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
					instorage = true
				else
					instorage = false
				end
				
				-- money
				DrawMarker(25, cash.x, cash.y, cash.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(cash.x, cash.y, cash.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(cash.x, cash.y, cash.z, "$"..apptdetails.apt_cash.." / $150,000\n\n/stash add {amt}\n/stash take {amt}")
				end
				
				-- outfits
				DrawMarker(25, outfits.x, outfits.y, outfits.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(outfits.x, outfits.y, outfits.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(outfits.x, outfits.y, outfits.z, "/outfit add {name}\n/outfit use {name}\n/outfit remove {name}\n/outfit list")
					inWardrobe = true
				else
					inWardrobe = false
				end
				
				-- leaving
				DrawMarker(25, leave.x, leave.y, leave.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(leave.x, leave.y, leave.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(leave.x, leave.y, leave.z, "[E] Leave Apartment")
					if IsControlJustPressed(0,38) then
						SetEntityCoords(GetPlayerPed(-1), apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z)
						FreezeEntityPosition(GetPlayerPed(-1), true)
						DoScreenFadeOut(0)
						Citizen.Wait(3000)
						inappt = false
						DoScreenFadeIn(3000)
						FreezeEntityPosition(GetPlayerPed(-1), false)
						instanceMe(false)
					end
				end
					
				-- spawn outside of appt
				if GetDistanceBetweenCoords(leave.x, leave.y, leave.z, GetEntityCoords(GetPlayerPed(-1)), true) > 30 then
					if inInstance() then
						SetEntityCoords(GetPlayerPed(-1), apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z)
						FreezeEntityPosition(GetPlayerPed(-1), true)
						DoScreenFadeOut(0)
						Citizen.Wait(3000)
						inappt = false
						DoScreenFadeIn(3000)
						FreezeEntityPosition(GetPlayerPed(-1), false)
						instanceMe(false)		
					end
				end
			else
				if GetDistanceBetweenCoords(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, GetEntityCoords(GetPlayerPed(-1))) < 20 then
					DrawMarker(25, apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
					DrawMarker(0, apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
						fsn_drawText3D(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z+1, "[E] Enter Apartment")
						if IsControlJustPressed(0,38) then
							EnterRoom(myRoomNumber)
						end
					end
				end
			end
		end
	end
end)
function EnterRoom(id)
	DoScreenFadeOut(0)
	SetEntityCoords(GetPlayerPed(-1), 152.09986877441 , -1004.7946166992, -98.999984741211)
	DoScreenFadeIn(3000)
	instanceMe(true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	Citizen.Wait(1000)
	inappt = true
end

----------------------------------------------- character creation
-- if user does not have a 4
local creating = false
RegisterNetEvent('fsn_apartments:characterCreation')
AddEventHandler('fsn_apartments:characterCreation', function()
	local xyz = {x = 223.19703674316, y = -967.322265625, z = -99.002616882324, h = 230.43223571777}
	local campos = {x = 225.67114257813, y = -969.71331787109, z = -98.999954223633, h = 39.208980560303}
	SetEntityCoords(GetPlayerPed(-1), xyz.x, xyz.y, xyz.z)
	SetEntityHeading(GetPlayerPed(-1), xyz.h)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TriggerEvent('fsn_clothing:menu')
	creating = true
	instanceMe(true)
	
	
	Citizen.CreateThread(function()
		while creating do
			Citizen.Wait(20)
			if not exports["fsn_clothing"]:isClothingOpen() then
				creating = false
				DoScreenFadeOut(1000)
				TriggerServerEvent('fsn_apartments:createApartment', exports["fsn_main"]:fsn_CharID())
			end
			if GetDistanceBetweenCoords(xyz.x, xyz.y, xyz.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 then
				SetEntityCoords(GetPlayerPed(-1), xyz.x, xyz.y, xyz.z)
				FreezeEntityPosition(GetPlayerPed(-1), true)
				SetEntityHeading(GetPlayerPed(-1), xyz.h)
			end
		end
	end)
end)

function saveApartment()
	TriggerServerEvent('fsn_apartments:saveApartment', apptdetails)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		saveApartment()
	end
end)

RegisterNUICallback('escape', function(data, cb) -- NUI to close menu on ESCAPE key pressed.
	ToggleActionMenu()
end)
