cc.exports.GameServerController = class("GameServerController");

GameServerController.heartTime = 0;

function GameServerController:connectServer()
	self._webSocket = cc.WebSocket:create("ws://192.168.11.111:5188");
	local function onOpen()
		self:onOpen();
		self:sendHeart();
	end

	local function onMessage(paramTable)
		self:onMessage(paramTable);
	end

	local function onClose()
		print("onClose");
	end

	local function onError()
		print("onError");
	end
	self._webSocket:registerScriptHandler(onOpen, cc.WEBSOCKET_OPEN);
	self._webSocket:registerScriptHandler(onMessage, cc.WEBSOCKET_MESSAGE);
	self._webSocket:registerScriptHandler(onClose, cc.WEBSOCKET_CLOSE);
	self._webSocket:registerScriptHandler(onError, cc.WEBSOCKET_ERROR);
end

function GameServerController:onOpen()
	print("onOpen");
end

function GameServerController:onMessage(paramTable)
	local length = Utils:bufToInt32(paramTable[1], paramTable[2], paramTable[3], paramTable[4]);
	print("length", length);

	local sequence = Utils:bufToInt32(paramTable[5], paramTable[6], paramTable[7], paramTable[8]);
	print("sequence", sequence);

	local command = Utils:bufToInt16(paramTable[9], paramTable[10]);
	print("command", command);

	local str = ""
	for i = 11, #paramTable, 1 do
		str  = str .. Utils:numToAscii(paramTable[i]);
	end



	local switch = {
		[ProtobufController.Command.client_heart_beat_ack] = function()
			local result = ProtobufController:unSerialize("proto.AutoID", str);
			print("ProtobufController.Command.client_heart_beat", result.id);
		end,

		[ProtobufController.Command.user_lobby_login_ack] = function()
			local result = ProtobufController:unSerialize("proto.CommonReply", str);
			EventDispatcher:sendDataEvent(Events.LOGIN_REPLY_EVENT, result);
		end,

		[ProtobufController.Command.lobby_player_push] = function()
			local lobbyUserInfo = ProtobufController:unSerialize("proto.Lobby.UserSnapshot", str);
			LobbyUserInfo:setInfo(lobbyUserInfo);
		end,

		[ProtobufController.Command.lobby_videourl_push] = function()
			print("ProtobufController.Command.lobby_videourl_push");
		end,

		[ProtobufController.Command.lobby_status_push] = function()
			local lobbyTableInfo = ProtobufController:unSerialize("proto.Lobby.TableSnapshot", str);
			LobbyTableController:setLobbyTableInfo(lobbyTableInfo);
		end,

		[ProtobufController.Command.lobby_playercount_push] = function()
			print("ProtobufController.Command.lobby_playercount_push");
		end,
	}
	local func = switch[command];
	if(func) then
		func();
	end
end

function GameServerController:setData(length, command, buffer)
	GameServerController.heartTime = GameServerController.heartTime + 1;

	local test = "";
	test = test..Utils:int32ToBufStr(length);
	test = test..Utils:int32ToBufStr(GameServerController.heartTime);
	test = test..Utils:int16ToBufStr(command);
	test = test..buffer;
	return test;
end

function GameServerController:sendData(length, command, buffer)
	local test = self:setData(length, command, buffer);
	self._webSocket:sendString(test);
end

function GameServerController:sendHeart()
	local function sendHeartCallback(dt)
		local buffer, length = ProtobufController:sendAutoID();
		self:sendData(length + 6, ProtobufController.Command.client_heart_beat, buffer);
	end
	local scheduler = cc.Director:getInstance():getScheduler();
	local sendHeartSchedule = scheduler:scheduleScriptFunc(sendHeartCallback, 1, false);
end

function GameServerController:login(userName, password)
	local buffer, length = ProtobufController:sendLogin(userName, password);
	self:sendData(length + 6, ProtobufController.Command.user_lobby_login, buffer);
end


