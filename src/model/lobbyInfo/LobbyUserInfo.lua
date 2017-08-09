cc.exports.LobbyUserInfo = class("LobbyUserInfo");

function LobbyUserInfo:ctor()

end

function LobbyUserInfo:setName(name)
	self._name = name;
end

function LobbyUserInfo:getName()
    return self._name;
end

 function LobbyUserInfo:getNick()
    return self._nick;
end

function LobbyUserInfo:getBalance()
    return self._balance;
end

function LobbyUserInfo:getOtherMinBetLimit()
    return self._otherMinBetLimit;
end

function LobbyUserInfo:getOtherMaxBetLimit()
    return self._otherMaxBetLimit;
end

function LobbyUserInfo:getOtherChipTable()
    return self._otherChipTable;
end

function LobbyUserInfo:getOtherAllChipTable()
    return self._otherAllChipTable;
end

function LobbyUserInfo:getRouletteMinBetLimit()
    return self._rouletteMinBetLimit;
end

function LobbyUserInfo:getRouletteMaxBetLimit()
    return self._rouletteMaxBetLimit;
end

function LobbyUserInfo:getRouletteChipTable()
    return self._rouletteChipTable;
end

function LobbyUserInfo:getRouletteAllChipTable()
    return self._rouletteAllChipTable;
end

function LobbyUserInfo:getMoneysort()
    return self._moneysort;
end

function LobbyUserInfo:getTip()
    return self._isTip;
end

function LobbyUserInfo:getChat()
    return self._isChat;
end

function LobbyUserInfo:getUid()
    return self._uid;
end

function LobbyUserInfo:setInfo(lobbyUserInfo)
	self._name = lobbyUserInfo.name;
	self._nick = lobbyUserInfo.nick;
	self._balance = lobbyUserInfo.balance;

	local otherLimitChipsObject =  self:parseBetlimitAndChip(lobbyUserInfo.videoChips);
    self._otherMinBetLimit = otherLimitChipsObject.minBetLimit;
    self._otherMaxBetLimit = otherLimitChipsObject.maxBetLimit;
    self._otherChipTable = otherLimitChipsObject.chipTable;
    self._otherAllChipTable = otherLimitChipsObject.allChipTable;

    local rouletteLimitChipsObject =  self:parseBetlimitAndChip(lobbyUserInfo.rouletteChips);
    self._rouletteMinBetLimit = rouletteLimitChipsObject.minBetLimit;
    self._rouletteMaxBetLimit = rouletteLimitChipsObject.maxBetLimit;
    self._rouletteChipTable = rouletteLimitChipsObject.chipTable;
    self._rouletteAllChipTable = rouletteLimitChipsObject.allChipTable;

	self._limits = lobbyUserInfo.limits;
	self._moneysort = lobbyUserInfo.moneysort;
	self._parentID = lobbyUserInfo.parentID;
	self._isTip = lobbyUserInfo.isTip;
	self._isChat = lobbyUserInfo.isChat;
	self._uid = lobbyUserInfo.uid;
end

function LobbyUserInfo:parseBetlimitAndChip(betLimitAndChip)
	local betLimitAndChipArr = string.split(betLimitAndChip, ":");
	local minBetLimit = tonumber(betLimitAndChipArr[1]);
	local maxBetLimit = tonumber(betLimitAndChipArr[2]);

	local strChipTable = string.split(betLimitAndChipArr[3], ",");
	local chipTable = self:strChipToNumChipTable(strChipTable);

	local allStrChipTable = string.split(betLimitAndChipArr[4], ",");
	local allChipTable = self:strChipToNumChipTable(allStrChipTable);
	
	return {minBetLimit = minBetLimit, maxBetLimit = maxBetLimit, chipTable = chipTable, allChipTable = allChipTable};
end

function LobbyUserInfo:strChipToNumChipTable(strChipTable)
	local chipTable = {};
	for i = 1, #strChipTable, 1 do
		chipTable[i] = tonumber(strChipTable[i]);
	end
	return chipTable;
end