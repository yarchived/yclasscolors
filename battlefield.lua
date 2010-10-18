if(1) then return end

if(enable_bgscoreboard) then
    hooksecurefunc('WorldStateScoreFrame_Update', function()
        local inArena = IsActiveBattlefieldArena()
        for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
            local index = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) + i
            local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class, classToken, damageDone, healingDone = GetBattlefieldScore(index)
            -- faction: Battlegrounds: Horde = 0, Alliance = 1 / Arenas: Green Team = 0, Yellow Team = 1
            if name then
                local n, r = strsplit('-', name, 2)
                n = classColorHex[classToken] .. n .. '|r'
                if n == myName then
                    n = '> ' .. n .. ' <'
                end
                
                if r then
                    local color
                    if inArena then
                        if faction == 1 then
                            color = '|cffffd100'
                        else
                            color = '|cff19ff19'
                        end
                    else
                        if faction == 1 then
                            color = '|cff00adf0'
                        else
                            color = '|cffff1919'
                        end
                    end
                    r = color .. r .. '|r'
                    n = n .. '|cffffffff-|r' .. r
                end
                
                local buttonNameText = getglobal('WorldStateScoreButton' .. i .. 'NameText')
                buttonNameText:SetText(n)
            end
        end
    end)
end

