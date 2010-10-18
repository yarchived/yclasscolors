if(1) then return end

if(enable_lfrlist) then
    hooksecurefunc('LFRBrowseFrameListButton_SetData', function(button, index)
        local name, level, areaName, className, comment, partyMembers, status, class, encountersTotal, encountersComplete, isLeader, isTank, isHealer, isDamage = SearchLFGGetResults(index)
        
        local c = class and classColors[class]
        if c then
            button.name:SetTextColor(unpack(c))
            button.class:SetTextColor(unpack(c))
        end
        if level then
            button.level:SetText(diffColor[level] .. level)
        end
    end)
end


