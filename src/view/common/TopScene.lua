local TopScene = class("Top", function()
	return cc.Layer:create();
end)

function TopScene:ctor()
	self._size = cc.size(1096, 58);
	self:setContentSize(self._size);
	self:init();
end

function TopScene:init()
	self:initCsbNode();
	self:initUserNameLabel();
	self:initBalanceLabel();
end

function TopScene:initCsbNode()
	self._csbNode = cc.CSLoader:createNode("common/top/TopScene.csb");
	self:addChild(self._csbNode);
end

function TopScene:initUserNameLabel()
	self._userNameLabel = self._csbNode:getChildByName("userNameLabel");
	self._userNameLabel:setString(LobbyUserInfo:getName());
end

function TopScene:initBalanceLabel()
	self._balanceLabel = self._csbNode:getChildByName("balanceLabel");
	self._balanceLabel:setString(LobbyUserInfo:getBalance());
end

return TopScene