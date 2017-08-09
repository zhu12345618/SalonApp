cc.exports.LobbyTableController = class("LobbyTableController");

function LobbyTableController:init()
	self._lobbyTablesInfoes = {};
end

-- 增加大厅数据
function LobbyTableController:setLobbyTableInfo(tempLobbyInfo)
	local gameType = tempLobbyInfo.gameType;
	local tableID = tempLobbyInfo.tableID;
	if nil == self._lobbyTablesInfoes[gameType] then
		self._lobbyTablesInfoes[gameType] = {};
	end
	if nil == self._lobbyTablesInfoes[gameType][tableID] then
		local lobbyTableInfo = require "model.lobbyInfo.LobbyTableInfo":create();
		lobbyTableInfo:updateInfo(tempLobbyInfo);
		self._lobbyTablesInfoes[gameType][tableID] = lobbyTableInfo;
		EventDispatcher:sendDataEvent(Events.ADD_LOBBY_TABLE_INFO, lobbyTableInfo);
	else
		local lobbyTableInfo = self._lobbyTablesInfoes[gameType][tableID];
		lobbyTableInfo:updateInfo(tempLobbyInfo);
		EventDispatcher:sendDataEvent(Events.UPDATE_LOBBY_TABLE_INFO, lobbyTableInfo);
	end
end

-- 获取一个游戏类型的大厅数据
function LobbyTableController:getLobbyTableInfo(gameType)
	return self._lobbyTablesInfoes[gameType];
end

-- 获取当前游戏类型的大厅数据
function LobbyTableController:getLobbyCurGameTypeInfo()
	return self._lobbyTablesInfoes[self:getCurGameType()];
end

-- 获取游戏类型的一桌数据
function LobbyTableController:getLobbyOneTableInfo(gameType, tableID)
	return self._lobbyTablesInfoes[gameType][tableID];
end

-- 获取当前游戏类型的一桌数据
function LobbyTableController:getLobbyCurGameTypeOneTableInfo(tableID)
	return self._lobbyTablesInfoes[self:getCurGameType()][tableID];
end

-- 设置当前游戏类型
function LobbyTableController:setCurGameType(gameType)
	self._curGameType = gameType;
end

-- 获取当前游戏类型
function LobbyTableController:getCurGameType()
	return self._curGameType;
end