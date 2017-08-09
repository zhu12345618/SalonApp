local RoadView = require "view.road.RoadView";
local BigRoadView = class("BigRoadView", RoadView)

function BigRoadView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self:setData(gridWidth, gridHeight, lineNum, columnNum);
	self:setMask();
	self:init();
end

return BigRoadView