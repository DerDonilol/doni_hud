ESX = exports["es_extended"]:getSharedObject()

-- Player list

function Players()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			local xPlayers = ESX.GetPlayers()
			--PlayersOnline = 0
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			end
			Citizen.Wait(5000)
		end
		Citizen.Wait(1000)
	end)
end

Players()

---------- JOBANZEIGE TEST-----------

ESX.RegisterServerCallback('doni_hud:getJobAndRank', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.job.label, xPlayer.job.grade_label)
    else
        cb(nil, nil)
    end
end)


----------------- SCHWARZGELD ----------------

ESX.RegisterServerCallback('doni_hud:getBlackMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local blackMoney = xPlayer.getAccount('black_money').money
        cb(blackMoney)
    else
        cb(0)
    end
end)

RegisterServerEvent('getWalletMoney')
AddEventHandler('getWalletMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local money = xPlayer.getMoney()
        TriggerClientEvent('displayWalletMoney', _source, money)
    end
end)

RegisterServerEvent('getBankMoney')
AddEventHandler('getBankMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local bankMoney = xPlayer.getAccount('bank').money
        TriggerClientEvent('displayBankMoney', _source, bankMoney)
    end
end)


ESX.RegisterServerCallback('getOnlinePlayerCount', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    cb(#xPlayers)
end)
