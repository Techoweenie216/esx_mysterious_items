ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('unk_redcan', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('unk_redcan', 1)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	Citizen.Wait(4050)
	TriggerClientEvent('esx_mysterious_items:DrinkCan', source, 'unk_redcan')
end)

ESX.RegisterUsableItem('unk_bluecan', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('unk_bluecan', 1)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	Citizen.Wait(4050)
	TriggerClientEvent('esx_mysterious_items:DrinkCan', source, 'unk_bluecan')
end)

ESX.RegisterUsableItem('unk_greencan', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('unk_greencan', 1)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	Citizen.Wait(4050)
	TriggerClientEvent('esx_mysterious_items:DrinkCan', source, 'unk_greencan')
end)


RegisterServerEvent('esx_mysterious_items:GetCan')
AddEventHandler('esx_mysterious_items:GetCan', function(item, inventory, section)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		for i=1, #inventory, 1 do
			if section == 1 then 
				-- if the player already has a can, you can only have 1
				if inventory[i].name == item then
					if inventory[i].count > 0 then	
						TriggerClientEvent("esx:showNotification", _source, "You can only have 1 red can")
					else
						xPlayer.addInventoryItem(item, 1)
						TriggerClientEvent("esx:showNotification", _source, "You have taken the red can")
					end
				end
			end
			
			if section == 2 then
			-- if the player already has a can, you can only have 1
				if inventory[i].name == item then
					if inventory[i].count > 0 then	
						TriggerClientEvent("esx:showNotification", _source, "You can only have 1 blue can")
					else
						xPlayer.addInventoryItem(item, 1)
						TriggerClientEvent("esx:showNotification", _source, "You have taken the blue can")
					end
				end	
			end
			
			
			if section == 3 then
			-- if the player already has a can, you can only have 1
				if inventory[i].name == item then
					if inventory[i].count > 0 then	
						TriggerClientEvent("esx:showNotification", _source, "You can only have 1 green can")
					else
						xPlayer.addInventoryItem(item, 1)
						TriggerClientEvent("esx:showNotification", _source, "You have taken the green can")
					end
				end
			end	
		end	

end)

