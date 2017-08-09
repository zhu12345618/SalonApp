local LobbyScene = class("LobbyScene", function()
	return cc.Scene:create();
end)

function LobbyScene:ctor()
	self._size = self:getContentSize();
	self:initBgImage();
	self:initTop();
	self:initListView();
	local function onAddLobbyTable()
		self:onAddLobbyTable();
	end
	local function onNodeEvent(event)
		if event == "enter" then
			local listener = cc.EventListenerCustom:create(Events.ADD_LOBBY_TABLE_INFO, onAddLobbyTable);
			EventDispatcher:addEventListenerWithSceneGraphPriority(listener, self);
		elseif event == "exit" then
			
		end
	end
	self:registerScriptHandler(onNodeEvent);
end

function LobbyScene:onAddLobbyTable()
	
end

function LobbyScene:initBgImage()
	local bg = cc.Sprite:create("baccarat/lobbyScene/lobbySceneBg.png");
	bg:getTexture():setTexParameters(GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT);
	bg:setTextureRect(cc.rect(0, 0, 1136, 1024));
	bg:setScaleY(640/1024);
	bg:setPosition(cc.p(self._size.width/2, self._size.height/2));
	self:addChild(bg);
end

function LobbyScene:initTop()
	local topScene = require "view.common.TopScene":create();
	topScene:setPosition(cc.p(20, self._size.height - topScene:getContentSize().height));
	self:addChild(topScene);
end

-- 初始化列表
function LobbyScene:initListView()
	self._listView = ccui.ListView:create();
	self._listView:setPosition(cc.p(10, 10));
	self._listView:setContentSize(cc.size(1116, 550));
	self._listView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
	self._listView:setBounceEnabled(true);
	self._listView:setItemsMargin(20);
	self:initTables();
	self:addChild(self._listView);
end

-- 往列表中添加项
function LobbyScene:addItem(tableID)
	local layout = ccui.Layout:create();
	layout:setContentSize(cc.size(1116, 245));
	local waybillView = require "view.road.WaybillView":create(tableID);
	layout:addChild(waybillView);

	self._listView:pushBackCustomItem(layout);
end

-- 初始化路单表
function LobbyScene:initTables()
	local allRooms = LobbyTableController:getLobbyCurGameTypeInfo();
	for k,v in pairs(allRooms) do
		local tableID = allRooms[k]:getTableID();
		self:addItem(tableID);
	end
	
end

return LobbyScene;