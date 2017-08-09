-- 封装一下自己的事件分发器
cc.exports.EventDispatcher = cc.Director:getInstance():getEventDispatcher();

-- 发送无数据事件
function EventDispatcher:sendNormalEvent(eventType)
	local event = cc.EventCustom:new(eventType);
	self:dispatchEvent(event);
	return event;
end

-- 发送sdef数据事件
function EventDispatcher:sendDataEvent(eventType, data)
	local event = cc.EventCustom:new(eventType);
	event._usedata = data;
	self:dispatchEvent(event);
	return event;
end