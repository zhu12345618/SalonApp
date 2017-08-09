local BaccaratGame = class("BaccaratGame", function()
	return cc.Scene:create();
end)

function BaccaratGame:ctor()
	self:init();
end

function BaccaratGame:init()
	self:initVideoView();
end

function BaccaratGame:initVideoView()
	self:addChild(cc.LiveVideo:create());
end

return BaccaratGame