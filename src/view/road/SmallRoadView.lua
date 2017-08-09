local RoadView = require "view.road.RoadView";
local SmallRoadView = class("SmallRoadView", RoadView);

function SmallRoadView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self:setData(gridWidth, gridHeight, lineNum, columnNum);
	self:setMask();
	self:init();
end

return SmallRoadView;