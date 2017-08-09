local RoadView = require "view.road.RoadView";
local MarkRoadView = class("MarkRoadView", RoadView)

function MarkRoadView:ctor(gridWidth, gridHeight, lineNum, columnNum)
	self:initRoadData()
	self:setData(gridWidth, gridHeight, lineNum, columnNum);
	self:setMask();
	self:init();
	self:initRoadView();
end

-- 初始化数据
function MarkRoadView:initRoadData()
	self._markRoad = require "model.road.MarkRoad":create();
end

-- 根据字符串增加路单
function MarkRoadView:addWithStrings(ways)
	for i = 1, string.len(ways), 1 do
		local oneChar = string.char(string.byte(ways, i));
		if oneChar == "q" then
			self:clearRoad();
		else
			self:addOneRoad(oneChar)
		end
	end
end

-- 增加一个路单
function MarkRoadView:addOneRoad(oneChar)
	self._markRoad:addOne();
	self:showOneRoad(oneChar, self._markRoad._currentX, self._markRoad._currentY);
end

-- 增加一个路单显示对象
function MarkRoadView:showOneRoad(way, currentX, currentY)
	local layer = cc.Layer:create();
	layer:setPosition(cc.p(currentX*self._gridWidth, (self._columnNum - currentY  - 1)*self._gridHeight));
	layer:setContentSize(cc.size(self._gridWidth, self._gridHeight));
	local result = string.char(string.byte(way) - 32);
	local roadImage = ccui.ImageView:create("road/Bead_" .. result .. ".png");
	roadImage:setPosition(cc.p(layer:getContentSize().width/2, layer:getContentSize().height/2));
	layer:addChild(roadImage);

	local text = self:getTextByResult(result);
	local label = cc.Label:createWithSystemFont(text, "arial", 20);
	label:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER);
	label:setPosition(cc.p(roadImage:getContentSize().width/2, roadImage:getContentSize().height/2));
	roadImage:addChild(label);
	self._roadView:addChild(layer);
end

function MarkRoadView:getTextByResult(result)
	local num = string.byte(result) - 65;
    local function baccarat()
        if num <= 3 then
        	return "庄";
            -- return "TEXT_BANKER_ICON";
        elseif num > 3 and num <= 7 then
        	return "闲";
            -- return "TEXT_PLAYER_ICON";
        else
        	return "和";
            -- return "TEXT_TIE_ICON";
        end
    end

    local function longhu()
        if num <= 3 then
        	return "虎";
            -- return "TEXT_TIGER_ICON";
        elseif num > 3 and num <= 7 then
        	return "龙";
            -- return "TEXT_DRAGON_ICON";
        else
        	return "和";
            -- return "TEXT_TIE_ICON";
        end
    end
    local switch = {
        [ProtobufController.GameType.Baccarat] = baccarat(),

        [ProtobufController.GameType.LongHu] = longhu(),
    };

    return switch[LobbyTableController:getCurGameType()];
end

-- 清除路单，包括显示对象和数据
function MarkRoadView:clearRoad()
	self._markRoad:clearRoad();
	self._roadView:removeAllChildren();
end

return MarkRoadView