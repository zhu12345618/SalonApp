local MarkRoad = class("MarkRoad");

function MarkRoad:ctor()
	self._currentX = 0;
	self._currentY = 0
	self._lastType = 0;
end

function MarkRoad:addOne()
	if self._lastType == 0 then
		self._currentX = 0;
		self._currentY = 0;
		self._lastType = 1;
	elseif self._currentY == 5 then
        self._currentX = self._currentX + 1;
        self._currentY = 0;
    else
        self._currentY = self._currentY + 1;
    end
end

function MarkRoad:clearRoad()
    self._currentX = 0;
    self._currentY = 0;
	self._lastType = 0;
end

return MarkRoad