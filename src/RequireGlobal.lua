require "Utils"

require "controller.EventDispatcher"

require "controller.LobbyTableController"
LobbyTableController:init();

require "model.lobbyInfo.LobbyUserInfo"

require "controller.protobuf.ProtobufController"
ProtobufController:loadProto();

require "controller.gameServer.GameServerController"
GameServerController:connectServer();

require "model.Events"