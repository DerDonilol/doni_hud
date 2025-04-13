ESX = exports["es_extended"]:getSharedObject()

local annoucement_queue = {}
local OnlinePlayers = 0
local bank
local money
local plyPed = PlayerPedId()


RegisterNetEvent("doni_hud:getPlayers")
AddEventHandler('doni_hud:getPlayers', function(players)
    OnlinePlayers = players
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

    ESX.PlayerData = ESX.GetPlayerData()

    SendNUIMessage({
        id = GetPlayerServerId(PlayerId()),
        playersonline = OnlinePlayers
    })
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPauseMenuActive() then
            SendNUIMessage({
                type = "pause";
                status = true
            })
        else
            SendNUIMessage({
                type = "pause";
                status = false
            })
        end
        Citizen.Wait(1000)
    end
    Citizen.Wait(10000)
end)


----------- JOBANZEIGE TEST -------------

local currentJobLabel = "Unbekannt"
local currentRank = ""

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        ESX.TriggerServerCallback('doni_hud:getJobAndRank', function(jobLabel, rank)
            if jobLabel ~= currentJobLabel or rank ~= currentRank then
                currentJobLabel = jobLabel
                currentRank = rank
                SendNUIMessage({
                    action = 'showJob',
                    job = currentJobLabel .. " - " .. currentRank
                })
            end
        end)
    end
end)


---------- SCHWARZGELD ------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        ESX.TriggerServerCallback('doni_hud:getBlackMoney', function(blackMoney)
            if blackMoney > 0 then
                SendNUIMessage({
                    action = 'showBlackMoney',
                    amount = blackMoney
                })
            else
                SendNUIMessage({
                    action = 'hideBlackMoney'
                })
            end
        end)
    end
end)

RegisterNetEvent('esx:characterLoaded')
AddEventHandler('esx:characterLoaded', function()
    UpdateHUDData()
end)

function UpdateHUDData()
    local player = PlayerId()
    local playerPed = GetPlayerPed(-1)

    local annoucement_queue = {}
    local OnlinePlayers = 0
    local bank
    local money
    local plyPed = PlayerPedId()
    
    SendNUIMessage({
        action = 'updateStats',
        values = {
            myMoney = money,
            bank = bank,
            id = GetPlayerServerId(PlayerId()),
            playersonline = OnlinePlayers,
            plyPed = plyPed
        }
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent('getWalletMoney')
    end
end)

RegisterNetEvent('displayWalletMoney')
AddEventHandler('displayWalletMoney', function(money)
    SendNUIMessage({
        action = 'updateWalletMoney',
        wallet = money
    })
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent('getBankMoney')
    end
end)

RegisterNetEvent('displayBankMoney')
AddEventHandler('displayBankMoney', function(bankMoney)
    SendNUIMessage({
        action = 'updateBankMoney',
        bank = bankMoney
    })
end)

Citizen.CreateThread(function()
    while true do
        ESX.TriggerServerCallback('getOnlinePlayerCount', function(count)
            SendNUIMessage({
                action = 'updatePlayerCount',
                count = count
            })
        end)
        Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerId = GetPlayerServerId(PlayerId())

        SendNUIMessage({
            action = 'updatePlayerId',
            playerId = playerId
        })
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local player = PlayerPedId()

        if IsPedInAnyVehicle(player, false) then
            local veh = GetVehiclePedIsIn(player, false)

            if GetPedInVehicleSeat(veh, -1) == player then
                local speedKMH = math.floor(GetEntitySpeed(veh) * 3.6)
                local fuelLevel = math.floor(GetVehicleFuelLevel(veh))
                local engineHealth = math.floor(GetVehicleEngineHealth(veh))

                SendNUIMessage({
                    action = "updateSpeedo",
                    show = true,
                    speed = speedKMH,
                    fuel = fuelLevel,
                    engineHealth = engineHealth
                })
            else
                SendNUIMessage({ action = "updateSpeedo", show = false })
            end
        else
            SendNUIMessage({ action = "updateSpeedo", show = false })
        end
    end
end)
