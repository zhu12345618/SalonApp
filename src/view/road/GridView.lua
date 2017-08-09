local GridView = class("GridView", function()
	return cc.Layer:create();
end)

function GridView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self._gridWidth = gridWidth;
    self._gridHeight = gridHeight;
    self._lineNum = lineNum;
    self._columnNum = columnNum;

    self:drawLine();
end

function GridView:drawLine()
	-- 画横线
	for i = 1, self._columnNum+1, 1 do
		local line = cc.DrawNode:create();
		local origin = cc.p(0, self._gridHeight*(i-1));
		local destination = cc.p(self._gridWidth*self._lineNum, self._gridHeight*(i-1));
		line:drawLine(origin, destination, cc.c4f(170, 170, 170, 1));
		self:addChild(line);
	end

	-- 画竖线
	for i = 1, self._lineNum+1, 1 do
		local line = cc.DrawNode:create();
		local origin = cc.p(self._gridWidth*(i-1), 0);
		local destination = cc.p(self._gridWidth*(i-1), self._gridHeight*self._columnNum);
		line:drawLine(origin, destination, cc.c4f(170, 170, 170, 1));
		self:addChild(line);
	end
end

return GridView