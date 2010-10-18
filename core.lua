
local parent, ns = ...

local GUILD_INDEX_MAX = 12
local SMOOTH = {
	1, 0, 0,
	1, 1, 0,
	0, 1, 0,
}
ns.myName = UnitName'player'

local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	BC[v] = k
end
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	BC[v] = k
end

local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

local function Hex(r, g, b)
	if(type(r) == 'table') then
		if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end
	
	if(not r or not g or not b) then
		r, g, b = 1, 1, 1
	end
	
	return format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

-- http://www.wowwiki.com/ColorGradient
local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end
	
	local num = select('#', ...) / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

--GuildControlGetNumRanks()
--GuildControlGetRankName(index)
ns.guildRankColor = setmetatable({}, {
	__index = function(t, i)
		if i then
			local c = Hex(ColorGradient(i/GUILD_INDEX_MAX, unpack(SMOOTH)))
            if(c) then
                t[i] = c
                return c
            else
                t[i] = t[0]
            end
		end
	end
})
ns.guildRankColor[0] = '|cffffffff'

ns.diffColor = setmetatable({}, {
	__index = function(t,i)
		local c = i and GetQuestDifficultyColor(i)
		if not c then return '|cffffffff' end
		t[i] = Hex(c)
		return t[i]
	end
})

ns.classColor = setmetatable({}, {
	__index = function(t,i)
		local c = i and RAID_CLASS_COLORS[BC[i] or i]
		if not c then return '|cffffffff' end
		t[i] = Hex(c)
		return t[i]
	end
})


if CUSTOM_CLASS_COLORS then
	local function callBack()
		wipe(classColorHex)
		wipe(classColor)
	end
	CUSTOM_CLASS_COLORS:RegisterCallback(callBack)
end

