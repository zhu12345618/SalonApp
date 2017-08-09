local LobbyTableInfo = class("LobbyTableInfo");

function LobbyTableInfo:ctor()
	self:init();
end

function LobbyTableInfo:init()
	self._allWays = "";
end

function LobbyTableInfo:setGameType(gameType)
    self._gameType = gameType;
end

function LobbyTableInfo:getGameType()
    return self._gameType;
end

function LobbyTableInfo:setTableID(tableID)
    self._tableID = tableID;
end

function LobbyTableInfo:getTableID()
    return self._tableID;
end

function LobbyTableInfo:setStage(stage)
    self._stage = stage;
end

function LobbyTableInfo:getStage()
    return self._stage;
end

function LobbyTableInfo:setInning(inning)
    self._inning = inning;
end

function LobbyTableInfo:getInning()
    return self._inning;
end

function LobbyTableInfo:setStatus(status)
    self._status = status;
end

function LobbyTableInfo:getStatus()
    return self._status;
end

function LobbyTableInfo:setTime(time)
    self._time = time;
end

function LobbyTableInfo:getTime()
    return self._time;
end

function LobbyTableInfo:setWays(ways)
    self._ways = ways;
    if string.sub(ways, 1, 1) == "q" then
        self._allWays = "";
    else
        self._allWays = self._allWays..ways;
    end
end

function LobbyTableInfo:getWays()
    return self._ways;
end

function LobbyTableInfo:getAllWays()
    return self._allWays;
end

function LobbyTableInfo:setCounts(counts)
    self._counts = counts;
end

function LobbyTableInfo:getCounts()
    return self._counts;
end

function LobbyTableInfo:setIssOpen(isopen)
    self._isopen = isopen;
end

function LobbyTableInfo:getIsOpen()
    return self._isopen;
end

function LobbyTableInfo:setDealer(dealer)
    self._dealer = dealer;
end

function LobbyTableInfo:getDealer()
    return self._dealer;
end

function LobbyTableInfo:setLimit(limit)
    self._limit = limit;
end

function LobbyTableInfo:getLimit()
    return self._limit;
end

function LobbyTableInfo:updateInfo(lobbyTableInfo)
    self._gameType = lobbyTableInfo.gameType;
    self._tableID = lobbyTableInfo.tableID;
    self._stage = lobbyTableInfo.stage;
    self._inning = lobbyTableInfo.inning;
    self._status = lobbyTableInfo.status;
    self._time = lobbyTableInfo.time;
    self._ways = lobbyTableInfo.ways;
    self:setWays(lobbyTableInfo.ways);
    
    self._counts = lobbyTableInfo.counts;
    self._isopen = lobbyTableInfo.isopen;
    self._dealer = lobbyTableInfo.dealer;
    self._limit = lobbyTableInfo.limit;
    self._platform = lobbyTableInfo.platform;
end

return LobbyTableInfo;