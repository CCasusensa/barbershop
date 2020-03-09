ESX = nil
postion = {}

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)



RegisterServerEvent("barbershop:pay")
AddEventHandler("barbershop:pay", function(source, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if (price > 0) then
        xPlayer.removeMoney(price)
        xPlayer.showNotification('您支付了' .. price .. '$')
    end
end)


ESX.RegisterServerCallback('barbershop:checkpostion', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #postion > 0 then
        cb(false)
    else
        table.insert(postion, identifier)
        cb(true)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #postion > 0 then
        if identifier == #postion[1] then
            table.remove(postion, 1)
        end
    end
end)

RegisterServerEvent('barbershop:removepostion')
AddEventHandler('barbershop:removepostion', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #postion > 0 then
        if identifier == postion[1] then
            table.remove(postion, 1)
        end
    end
end)