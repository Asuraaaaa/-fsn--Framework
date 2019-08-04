-- carry dead people not escort

carrying = false
carrying_id = 0

function carryingWho()
	return carrying_id
end

carried = false
carried_id = false

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('fsn_ems:carried:start')
AddEventHandler('fsn_ems:carried:start', function(carrier)
	carried = true
	carried_id = carrier
	ClearPedTasksImmediately(GetPlayerPed(-1))
	if IsPedRagdoll(GetPlayerPed(-1)) then
		SetPedCanRagdoll(GetPlayerPed(-1), false)
	end
	TriggerEvent('fsn_vehiclecontrol:trunk:forceOut')
end)

RegisterNetEvent('fsn_ems:carry:start')
AddEventHandler('fsn_ems:carry:start', function(carryingid)
	carrying = true
	carrying_id = carryingid
end)

RegisterNetEvent('fsn_ems:carried:end')
AddEventHandler('fsn_ems:carried:end', function(carrier)
	carried = false
	carried_id = 0 
	DetachEntity(GetPlayerPed(-1))
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('fsn_ems:carry:end')
AddEventHandler('fsn_ems:carry:end', function(carryingid)
	carrying = false
	carrying_id = 0
	SetPedCanRagdoll(GetPlayerPed(-1), true)
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		if carried then 
			local ped = GetPlayerPed(GetPlayerFromServerId(carried_id))
			loadAnim( "amb@world_human_bum_slumped@male@laying_on_left_side@base" ) 
			if not IsEntityPlayingAnim(GetPlayerPed(-1), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
				TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
			if not IsEntityAttached(GetPlayerPed(-1)) then
				AttachEntityToEntity(GetPlayerPed(-1), ped, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
			end
		end
		--if carrying then
			
		--end
	end
end)

DecorRegister("fsn_ems:dead")
DecorSetBool(GetPlayerPed(-1), "fsn_ems:dead", false)
Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		if fsn_IsDead() then
			DecorSetBool(GetPlayerPed(-1), "fsn_ems:dead", true)
		else
			DecorSetBool(GetPlayerPed(-1), "fsn_ems:dead", false)
		end
		for id = 0, 64 do
			local ped = GetPlayerPed(id)
			if DecorGetBool(ped, "fsn_ems:dead") and ped ~= GetPlayerPed(-1) then
				if GetDistanceBetweenCoords(GetEntityCoords(ped, false), GetEntityCoords(GetPlayerPed(-1),false), true) < 2 then
					if not carrying then
						Util.DrawText3D(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, '~r~Knocked Out~w~\n[LALT + E] Carry\n[LALT + A] Attend', {255,255,255,200}, 0.25)
						if IsControlPressed(0, 19) then
							if IsControlJustPressed(0, 38) then
								-- carry (C)
								TriggerServerEvent('fsn_ems:carry:start', GetPlayerServerId(id))
							end
							
							if IsControlJustPressed(0, 34) then
								-- attend (A)
								TaskLookAtCoord(GetPlayerPed(-1), GetEntityCoords(ped), 1000, 0, 2)
								ExecuteCommand('e kneel2')
							end
						end
					else
						Util.DrawText3D(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, '~r~Knocked Out~w~\n[LALT + E] Drop', {255,255,255,200}, 0.25)
						if IsControlPressed(0, 19) then
							if IsControlJustPressed(0, 38) then
								-- carry (C)
								TriggerServerEvent('fsn_ems:carry:end', GetPlayerServerId(id))
							end
						end
					end
				end
			end
		end 
	end
end)

-- other shit
DetachEntity(GetPlayerPed(-1))