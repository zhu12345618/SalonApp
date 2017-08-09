local HallScene = class("HallScene", function()
	return cc.Scene:create();
end)

function HallScene:ctor()
	self:init();
	local function onNodeEvent(event) 
		if event == "enter" then
			print("enter");
		elseif event == "exit" then
			print("exit");
		end
	end
	self:registerScriptHandler(onNodeEvent);
end

function HallScene:init()
	self:initCsbNode();
	self:initBtnEvents();
end

function HallScene:initCsbNode()
	self._csbNode = cc.CSLoader:createNode("hallScene/HallScene.csb")
	self:addChild(self._csbNode);
end

function HallScene:initBtnEvents()
	local function onClickBjl()
		LobbyTableController:setCurGameType(ProtobufController.GameType.Baccarat);
		local baccaratLobbyScene = require "view.baccarat.LobbyScene":create();
		cc.Director:getInstance():replaceScene(baccaratLobbyScene);
	end

	local function onClickLh()

	end

	local function onClickFantan()

	end

	local function onClickRoulette()

	end

	local function onClickSaibao()

	end

	local bjlBtn = self._csbNode:getChildByName("BjlBtn");
	bjlBtn:addClickEventListener(onClickBjl);
end

return HallScene