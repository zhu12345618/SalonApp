local RoadView = require "view.road.RoadView";
local ZlRoadView = class("ZlRoadView", RoadView);

function ZlRoadView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self:setData(gridWidth, gridHeight, lineNum, columnNum);
	self:setMask();
	self:init();
end

return ZlRoadView;