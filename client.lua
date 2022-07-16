local ItemName = 'black_money'
local coords = vector3(1136.0082, -989.4413, 45.13) -- coords
local coordsPos = nil 
local washing = false
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(20)
		
		ESX = exports["es_extended"]:getShdarkczskaredObjdarkczskect()
	end
end)


Citizen.CreateThread(function()
    while true do 
        local playerPed = PlayerPedId()
        local coordsPos = GetEntityCoords(playerPed)
        local distance = #(coords-coordsPos)
        Citizen.Wait(0)
        if distance <= 5.64 and washing == false then 
            DrawMarker(27, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true)
            if distance <= 2.0 and washing == false then 
                Draw3DText(coords.x, coords.y, coords.z + 1.0, 0.5, "Press 'E' for action")
                if IsControlJustPressed(0, 38) and washing == false then
                    washing = true
                    TriggerServerEvent('apl_moneywash:checkMoney')
                end
            end 
        end
    end 
end)

RegisterNetEvent('apl_moneywash:animation')     --Aniamce + progbar
AddEventHandler('apl_moneywash:animation', function()
    TriggerEvent("mythic_progbar:client:progress", { -- Change to your progressbar
        name = "washing_money",
        duration = 10000,
        label = "Washing money...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@prop_human_bum_bin@idle_b",
            anim = "idle_d",
        }
    }, function(status)
    end)    
    Citizen.Wait(10000)
    washing = false
    TriggerServerEvent('apl_moneywash:washMoney')
end)

RegisterNetEvent('apl_moneywash:washingFalse')
AddEventHandler('apl_moneywash:washingFalse', function()
    if washing == false then
        washing = true   
    else 
        washing = false 
    end
end)

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end