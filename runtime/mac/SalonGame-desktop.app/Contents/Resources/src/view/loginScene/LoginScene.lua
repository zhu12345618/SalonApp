local LoginScene = class("LoginScene", function ()
	return cc.Scene:create();
end)

function LoginScene:ctor()
	self:init();
	local function onNodeEvent(event) 
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			print("exit");
		end
	end
	self:registerScriptHandler(onNodeEvent);
end

function LoginScene:init()
	local contentSize = cc.Director:getInstance():getWinSize();
	self._width = contentSize.width;
	self._height= contentSize.height;
	self:initCsbNode();
	self:initEditBox();
	self:initBtn();
	self:initLiveVideoView();
end

function LoginScene:onEnter()
	local function loginReplyCallback(event)
		local data = event._usedata;
 		self:switchLoginCode(data.code, data.desc);
	end
	self._loginReplyListener = cc.EventListenerCustom:create(Events.LOGIN_REPLY_EVENT, loginReplyCallback);
	EventDispatcher:addEventListenerWithSceneGraphPriority(self._loginReplyListener, self);
end

-- 初始化csb文件
function LoginScene:initCsbNode()
	self._csbNode = cc.CSLoader:createNode("loginScene/LoginScene.csb");
	self:addChild(self._csbNode);
end

-- 初始化编辑框，因为csb中没有editBox
function LoginScene:initEditBox()
	local editBoxSize = cc.size(450, 60);
	self._loginEditBox = cc.EditBox:create(editBoxSize, cc.Scale9Sprite:create("whiteBg.png"));
	self._loginEditBox:setFontColor(cc.c3b(0, 0, 0));
	self._loginEditBox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE);
	self._loginEditBox:setPlaceHolder("用户名");
	self._loginEditBox:setPosition(cc.p(self._width/2, self._height/2+80));
	self:addChild(self._loginEditBox);

	self._pwdEditBox = cc.EditBox:create(editBoxSize, cc.Scale9Sprite:create("whiteBg.png"));
	self._pwdEditBox:setFontColor(cc.c3b(0, 0, 0));
	self._pwdEditBox:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD);
	self._pwdEditBox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE);
	self._pwdEditBox:setPlaceHolder("密码");
	self._pwdEditBox:setPosition(cc.p(self._width/2, self._height/2));
	self:addChild(self._pwdEditBox);
end

function LoginScene:initBtn()
	local box = self._csbNode:getChildByName("box");
	if box ~= nil then
		local loginBtn = box:getChildByName("loginBtn");
		local function onClickLoginBtn(sender)
			self:onClickLoginBtn();
		end
		loginBtn:addClickEventListener(onClickLoginBtn);

		local resetBtn = box:getChildByName("resetBtn");
	end
	
end

function LoginScene:onClickLoginBtn(sender)
	local userName = self._loginEditBox:getText();
	local password = self._pwdEditBox:getText();
	GameServerController:login(userName, password);
end

-- 判断登录返回的登录码
function LoginScene:switchLoginCode(code, desc)
	local switch = {
		[ProtobufController.Code.SUCCESS] = function()
			self:enterHallScene();
		end,
		[ProtobufController.Code.ERR_INVALID_PROTOCOL] = function()
			print("ERR_INVALID_PROTOCOL");
		end,
		[ProtobufController.Code.ERR_INVALID_DATA] = function()
			print("ERR_INVALID_DATA");
		end,
		[ProtobufController.Code.ERR_INVALID_OPERATION] = function()
			print("ERR_INVALID_OPERATION");
		end,
		[ProtobufController.Code.ERR_USER_UNUSABLE] = function()
			print("ERR_USER_UNUSABLE");
		end,
		[ProtobufController.Code.ERR_ACCOUT_LOCK] = function()
			print("ERR_ACCOUT_LOCK");
		end,
		[ProtobufController.Code.ERR_AUTHFAIL] = function()
			print("ERR_AUTHFAIL");
		end,
		[ProtobufController.Code.ERR_SERVER_INTERNAL_ERROR] = function()
			print("ERR_SERVER_INTERNAL_ERROR");
		end,
	};
	local func = switch[ProtobufController.Code[code]];
	if(func) then
		func();
	else
		print("ERROR!");
	end
end

function LoginScene:enterHallScene()
	local HallScene = require "view.HallScene";
	local hallScene = HallScene:create();
	cc.Director:getInstance():replaceScene(hallScene);
end

-- 初始化测试用的直播，如果在没有连接服务器的时候也可以打开直播
function LoginScene:initLiveVideoView()
	local button = ccui.Button:create("whiteBg.png");
	button:setPosition(cc.p(self._width - 40, 40));
	local function showLiveVideo()
		self:removeAllChildren();
		self:addChild(cc.LiveVideo:create());
	end
	button:addClickEventListener(showLiveVideo);
	button:ignoreContentAdaptWithSize(false);
	button:setContentSize(cc.size(20, 20))
	self:addChild(button);
end

return LoginScene