if(1) then return end

if(enable_wholist) then
    hooksecurefunc('WhoList_Update', function()
        local whoIndex
        local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
        
        local playerZone = GetRealZoneText()
        local playerGuild = GetGuildInfo'player'
        local playerRace = UnitRace'player'
        
        for i=1, WHOS_TO_DISPLAY, 1 do
            whoIndex = whoOffset + i
            local nameText = getglobal('WhoFrameButton'..i..'Name')
            local levelText = getglobal('WhoFrameButton'..i..'Level')
            local classText = getglobal('WhoFrameButton'..i..'Class')
            local variableText = getglobal('WhoFrameButton'..i..'Variable')
            
            local name, guild, level, race, class, zone, classFileName = GetWhoInfo(whoIndex)
            if not name then return end
            if zone == playerZone then
                zone = '|cff00ff00' .. zone
            end
            if guild == playerGuild then
                guild = '|cff00ff00' .. guild
            end
            if race == playerRace then
                race = '|cff00ff00' .. race
            end
            local columnTable = { zone, guild, race }
            
            nameText:SetVertexColor(unpack(classColors[class]))
            levelText:SetText(diffColor[level] .. level)
            variableText:SetText(columnTable[UIDropDownMenu_GetSelectedID(WhoFrameDropDown)])
        end
    end)
end

