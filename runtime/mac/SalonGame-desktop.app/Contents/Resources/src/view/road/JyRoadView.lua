local RoadView = require "view.road.RoadView";
local JyRoadView = class("JyRoadView", RoadView);

function JyRoadView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self:setData(gridWidth, gridHeight, lineNum, columnNum);
	self:setMask();
	self:init();
end

function JyRoadView:init()
	RoadView.init(self);
end

return JyRoadView;