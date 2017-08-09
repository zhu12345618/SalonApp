local RoadView = class("RoadView", function()
	return ccui.Layout:create();
end)

function RoadView:ctor()
	print("RoadView:ctor");
end

function RoadView:setData(gridWidth, gridHeight, lineNum, columnNum)
	self._gridWidth = gridWidth;
	self._gridHeight = gridHeight;
	self._lineNum = lineNum;
	self._columnNum = columnNum;
	self._size = cc.size(gridWidth*lineNum, gridHeight*columnNum);
	self:setContentSize(self._size);
end

function RoadView:init()
	self:drawBg();
	self:initGridView();
end

function RoadView:setMask()
	self:setClippingEnabled(true);
end

-- 画背影色
function RoadView:drawBg()
	local bg = cc.DrawNode:create();
	bg:drawSolidRect(cc.p(0, 0), cc.p(self._size.width, self._size.height), cc.c4f(1, 1, 1, 1));
	self:addChild(bg);
end

-- 初始化框框
function RoadView:initGridView()
	local GridView = require "view.road.GridView";
	local gridView = GridView:create(self._gridWidth, self._gridHeight, self._lineNum, self._columnNum);
	self:addChild(gridView);
end

-- 初始化放路单的层
function RoadView:initRoadView()
	self._roadView = cc.Layer:create();
	local size = self._roadView:getContentSize();

	self:addChild(self._roadView);
end

return RoadView