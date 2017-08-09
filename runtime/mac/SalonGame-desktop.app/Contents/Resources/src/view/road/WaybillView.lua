local WaybillView = class("WaybillView", function()
	return cc.Layer:create();
end)

function WaybillView:ctor(tableID)
	self._size = cc.size(1116, 246)
	self:setContentSize(self._size);
	self:init();

	self:setTableID(tableID);
	self:initLobbyTableInfo();
	local function onNodeEvent(event)
		if event == "enter" then
			self:onEnter();
		else

		end
	end
	self:registerScriptHandler(onNodeEvent)
end

function WaybillView:onEnter()
	
end

function WaybillView:init()
	self:initEvent();
	self:initBg();
	self:initRoad();
end

function WaybillView:initEvent()
	local moved = false;
	local function onTouchBegan(touch, event)
        local locationInNode = self:convertToNodeSpace(touch:getLocation())
        local s = self:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        
        if cc.rectContainsPoint(rect, locationInNode) then
            return true;
        end
        return false;
    end

    local function onTouchMoved(touch, event)
    	local delta = touch:getDelta();
    	moved = true;
    end

	local function onTouchEnded()
		if moved then
			moved = false;
			return
		end
		local BaccaratGame = require "view.baccarat.BaccaratGame";
		cc.Director:getInstance():replaceScene(BaccaratGame:create());
	end

	local listener = cc.EventListenerTouchOneByOne:create();
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN );
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED );
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED );
	EventDispatcher:addEventListenerWithSceneGraphPriority(listener, self);

	local function updateLobbyTableCallback(event)
		self:updateLobbyTableInfo(event);
	end
	local updateLobyTableListener = cc.EventListenerCustom:create(Events.UPDATE_LOBBY_TABLE_INFO, updateLobbyTableCallback);
	EventDispatcher:addEventListenerWithSceneGraphPriority(updateLobyTableListener, self);
end

-- 设置桌号
function WaybillView:setTableID(tableID)
	self._tableID = tableID;
end

function WaybillView:getTableID()
	return self._tableID;
end

function WaybillView:initBg()
	local bg = cc.Sprite:create("road/baccaratHallRoadBg.png");
	bg:getTexture():setTexParameters(GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT);
	bg:setTextureRect(cc.rect(0, 0, 1116*64/45, 64));
	bg:setScaleX(45/64);
	bg:setScaleY(36/64);
	bg:setPosition(cc.p(self._size.width/2, self._size.height - bg:getBoundingBox().height/2))
	self:addChild(bg);
end

-- 初始化珠盘路，大路，小路，鸡眼路，蟑螂路
function WaybillView:initRoad()
	local x, y = 0, 0;
	local roadView = cc.Layer:create();
	roadView:setContentSize(cc.size(1116, 210));
	self:addChild(roadView);
	local width = 35;
	self._markRoadView = require "view.road.MarkRoadView":create(width, width, 12, 6);
	roadView:addChild(self._markRoadView);

	self._smallRoadView = require "view.road.SmallRoadView":create(width/2, width/2, 20, 3);
	x = self._markRoadView:getContentSize().width;
	y = 0;
	self._smallRoadView:setPosition(cc.p(x, y));
	roadView:addChild(self._smallRoadView);

	self._zlRoadView = require "view.road.SmallRoadView":create(width/2, width/2, 20, 3);
	x = self._markRoadView:getContentSize().width + self._zlRoadView:getContentSize().width;
	y = 0;
	self._zlRoadView:setPosition(cc.p(x, y));
	roadView:addChild(self._zlRoadView);

	self._jyRoadView = require "view.road.JyRoadView":create(width/2, width/2, 40, 3);
	x = self._markRoadView:getContentSize().width;
	y = self._zlRoadView:getContentSize().height;
	self._jyRoadView:setPosition(cc.p(x, y));
	roadView:addChild(self._jyRoadView);

	self._bigRoadView = require "view.road.BigRoadView":create(width/2, width/2, 40, 6);
	x = self._markRoadView:getContentSize().width;
	y = roadView:getContentSize().height - self._bigRoadView:getContentSize().height;
	self._bigRoadView:setPosition(cc.p(x, y));
	roadView:addChild(self._bigRoadView);

	
end

-- 初始化大厅路单数据
function WaybillView:initLobbyTableInfo()
	if self:getTableID() then
		local data = LobbyTableController:getLobbyCurGameTypeOneTableInfo(self:getTableID());
		self:addWays(data:getAllWays());
	end
end

-- 更新大厅路单数据
function WaybillView:updateLobbyTableInfo(event)
	local data = event._usedata;
	local tableID = data:getTableID();
	local equalGameType = data:getGameType() == LobbyTableController:getCurGameType();
	if self:getTableID() == tableID and equalGameType then
		self:addWays(data:getWays());
	end
end

-- 增加路单数据
function WaybillView:addWays(ways)
	self._markRoadView:addWithStrings(ways);
end

return WaybillView