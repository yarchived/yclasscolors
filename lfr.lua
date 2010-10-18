
local parent, ns = ...
local myName = UnitName'player'

hooksecurefunc('LFRBrowseFrameListButton_SetData', function(button, index)
    local name, level, areaName, className, comment, partyMembers, status, class, encountersTotal, encountersComplete, isLeader, isTank, isHealer, isDamage = SearchLFGGetResults(index)

    if(index and class and name and level and (name~=myName)) then
        button.name:SetText(ns.classColor[class] .. name)
        button.class:SetText(ns.classColor[class] .. className)
        button.level:SetText(ns.diffColor[level] .. level)
    end
end)


