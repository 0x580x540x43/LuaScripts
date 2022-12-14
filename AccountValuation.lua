-- Lua 5.1 (WIP)

local Settings = {
    userId = 0, -- Roblox user Id
    Valuation = {
        InventoryValue = true -- Calculate account's inventory value
    }
}

-- Variables

local Endpoints = { -- Uses %s for string.format
    Inventory = {
        CanView = "https://inventory.roblox.com/v1/users/%s/can-view-inventory/",
        Categories = "https://inventory.roblox.com/v1/users/%s/categories/",
        Collectibles = "https://inventory.roblox.com/v1/users/%s/assets/collectibles?sortOrder=Asc&limit=100&cursor=%s",
        GetAssets = "https://inventory.roblox.com/v2/users/%s/inventory/%s?sortOrder=Asc&limit=100&cursor=%s", -- Badges and Game passes excluded
        GetPasses = "https://www.roproxy.com/users/inventory/list-json?assetTypeId=34&itemsPerPage=100&userId=%s&cursor=%s",
    },
    Marketplace = {
        ProductInfo = "https://api.roblox.com/marketplace/productinfo?assetId=%s",
        GamePassInfo = "https://api.roblox.com/marketplace/game-pass-product-info?gamePassId=%s"
    }
}

-- Functions

local req = function(url, method, data)
    local response
    if method == "GET" then
        response = request({
            Url = url,
            Method = method
        })
    elseif method == "POST" then
        response = request({
            Url = url,
            Method = method,
            Body = data
        })
    end
    return response
end

GetInventory = function()
    local CanView = JSON.Decode(request(string.format(Endpoints.Inventory.CanView, Settings.userId), "GET"))
    if CanView.canView == false then
        return error("Please set your inventory privacy to public")
    end
    
    local Categories = req(string.format(Endpoints.Inventory.Categories, Settings.userId), "GET")

    print(Categories)
end
 
-- Switches

if Settings.Valuation.InventoryValue == true then
    GetInventory()
end
