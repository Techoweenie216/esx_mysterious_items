ESX              = nil
local PlayerData = {}
isInMarker = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	RedCanPos = vector3(3559.558, 3672.298, 29.12189)
	BlueCanPos = vector3(3539.159, 3668.175, 28.12189)
	GreenCanPos = vector3(3560.016, 3674.444, 28.12189)
	
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(ped)
		local RedDistance = #(playerCoords - RedCanPos)
		local BlueDistance = #(playerCoords - BlueCanPos)
		local GreenDistance = #(playerCoords - GreenCanPos)
		local _source = source
		local inventory = ESX.GetPlayerData().inventory
			
			if RedDistance < 1.5 then
				ESX.Game.Utils.DrawText3D(RedCanPos, "Press ~y~[H]~w~ to take item from table.", 1, 4)
				-- press H key    
				if IsControlJustReleased(0, 74) then
					TriggerServerEvent('esx_mysterious_items:GetCan', 'unk_redcan',inventory, 1)
				end
			else 
				isInMarker = false
			end
			
			if BlueDistance < 1.5 then
				ESX.Game.Utils.DrawText3D(BlueCanPos, "Press ~y~[H]~w~ to take item from table.", 1, 4)
				-- press H key    
				if IsControlJustReleased(0, 74) then
					TriggerServerEvent('esx_mysterious_items:GetCan', 'unk_bluecan',inventory, 2)
				end
			else 
				isInMarker = false
			end
		
			if GreenDistance < 1.5 then
				ESX.Game.Utils.DrawText3D(GreenCanPos, "Press ~y~[H]~w~ to take item from table.", 1, 4)
				-- press H key    
				if IsControlJustReleased(0, 74) then
					TriggerServerEvent('esx_mysterious_items:GetCan', 'unk_greencan',inventory, 3)
				end
			else 
				isInMarker = false
			end

	end
end)
	
	

RegisterNetEvent('esx_mysterious_items:DrinkCan')
AddEventHandler('esx_mysterious_items:DrinkCan', function( source)
	local ped = GetPlayerPed(-1)
		-- get falling down animation
		RequestAnimDict("anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@drunk")
		while (not HasAnimDictLoaded("anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@drunk")) do 
		Citizen.Wait(0)
		end
		-- get laying on side animation	
		RequestAnimDict("amb@world_human_bum_slumped@male@laying_on_right_side@idle_a")
		while (not HasAnimDictLoaded("amb@world_human_bum_slumped@male@laying_on_right_side@idle_a")) do
		Citizen.Wait(0)
		end
				
		TaskPlayAnim(ped, "anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@drunk", "outro_fallover", 8.0,8.0,-1,0,1,0,0,0)
		Citizen.Wait(3750)
		SetFollowPedCamViewMode(4)
		
		DoScreenFadeOut(2000)

		Citizen.Wait(4050)
		-- sasquatch
		if source == 'unk_redcan' then
			RequestModel(0x61D4C771)
			while not HasModelLoaded(0x61D4C771) do
			Wait(500)
			end
			SetPlayerModel(PlayerId(), 0x61D4C771)
			SetPedDefaultComponentVariation(PlayerPedId())
			SetModelAsNoLongerNeeded(ped)
		end
		-- alien
		if source == 'unk_bluecan' then
			RequestModel(0x64611296)
			while not HasModelLoaded(0x64611296) do
			Wait(500)
			end
			SetPlayerModel(PlayerId(), 0x64611296)
			SetPedDefaultComponentVariation(PlayerPedId())
			SetModelAsNoLongerNeeded(ped)
		end
		-- zombie
		if source == 'unk_greencan' then
			RequestModel(0xAC4B4506 )
			while not HasModelLoaded(0xAC4B4506 ) do
			Wait(500)
			end
			SetPlayerModel(PlayerId(), 0xAC4B4506 )
			SetPedDefaultComponentVariation(PlayerPedId())
			SetModelAsNoLongerNeeded(ped)
		end
		

		SetFollowPedCamViewMode(4)				
		TaskPlayAnim(ped, "amb@world_human_bum_slumped@male@laying_on_right_side@idle_a", "idle_a", 8.0,8.0,-1,0,1,0,0,0)
		DoScreenFadeIn(5000)
		SetTimecycleModifier("spectator6")
		SetPedMotionBlur(Ped, true)
		SetPedMovementClipset(Ped, "MOVE_M@DRUNK@VERYDRUNK", true)
		SetPedIsDrunk(Ped, true)
		AnimpostfxPlay("ChopVision", 100001, true)
		ShakeGameplayCam("DRUNK_SHAKE", 1.0)
		
		Citizen.Wait(25000)
														
		SetPedIsDrunk(Ped, false)		
		SetPedMotionBlur(Ped, false)
		ResetPedMovementClipset(Ped)
		AnimpostfxStopAll()
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		SetTimecycleModifierStrength(0.0)
end)
