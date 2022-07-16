ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(20)
		
		ESX = exports["es_extended"]:getShdarkczskaredObjdarkczskect()
	end
end)

RegisterServerEvent('apl_moneywash:checkMoney')
AddEventHandler('apl_moneywash:checkMoney', function()
    local _source = source 
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
    local black_money = xPlayer.getInventoryItem('black_money').count
    if black_money >= 1 then 
        TriggerClientEvent('apl_moneywash:animation', source)
    else 
        TriggerClientEvent('okokNotify:Alert', source, "ERROR", "You dont have black money!", 5000, 'error') -- Change to your notify
        TriggerClientEvent('apl_moneywash:washingFalse', source)
    end
end)


RegisterServerEvent('apl_moneywash:washMoney')
AddEventHandler('apl_moneywash:washMoney', function()
    local _source = source 
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
    local black_money = xPlayer.getInventoryItem('black_money').count
	xPlayer.removeAccountMoney('black_money', black_money)
	xPlayer.addAccountMoney('money', black_money)
end)