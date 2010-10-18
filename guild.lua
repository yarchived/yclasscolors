
local parent, ns = ...

local _VIEW = 'playerStatus' -- default

local function viewChanged(view)
    _VIEW = view
end

local function update()
    if(_VIEW == 'tradeskil') then return end

    local playerArea = GetRealZoneText()
    local buttons = GuildRosterContainer.buttons

    for i, button in ipairs(buttons) do
        -- why the fuck no continue?
        if(button:IsShown() and button.online and button.guildIndex) then
            local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName, achievementPnts, achievementRank, isMobile = GetGuildRosterInfo(button.guildIndex)
            --print(button.guildIndex, name, time())
            if(_VIEW == 'playerStatus') then
                button.string1:SetText(ns.diffColor[level] .. level)
                if(not isMobile) then
                    button.string2:SetText(ns.classColorHex[classFileName] .. name)
                end
                if(zone == playerArea) then
                    button.string3:SetText('|cff00ff00' .. zone)
                end
            elseif(_VIEW == 'guildStatus') then
                button.string1:SetText(ns.classColorHex[classFileName] .. name)
                if(rankIndex and rank) then
                    button.string2:SetText(ns.guildRankColor[rankIndex] .. rank)
                end
            elseif(_VIEW == 'achievement') then
                button.string1:SetText(ns.diffColor[level] .. level)
                if(classFileName and name) then
                    button.string2:SetText(ns.classColors[classFileName] .. name)
                end
            end
        end
    end
end

local function tradeupdate()
    local myZone = GetRealZoneText()
    for i, button in ipairs(GuildRosterContainer.buttons) do
        if(button:IsShown() and button.online and button.guildIndex) then
			local skillID, isCollapsed, iconTexture, headerName, numOnline, numPlayers, playerName, class, online, zone, skill, classFileName = GetGuildTradeSkillInfo(button.guildIndex)
            if(not headerName) then
                button.string1:SetText(ns.classColorHex[classFileName] .. playerName)
                if(zone == myZone) then
                    button.string2:SetText('|cff00ff00' .. zone)
                end
            end
        end
    end
end

local loaded = true
hooksecurefunc('GuildFrame_LoadUI', function()
    if(loaded) then return end
    loaded = true

    hooksecurefunc('GuildRoster_SetView', viewChanged)
    hooksecurefunc('GuildRoster_Update', update)
    hooksecurefunc(GuildRosterContainer, 'update', update)
    hooksecurefunc('GuildRoster_UpdateTradeSkills', tradeupdate)
end)


