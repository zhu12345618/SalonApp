
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"

require "RequireGlobal"

local function main()
    local LoginScene = require("view.loginScene.LoginScene");
    cc.Director:getInstance():runWithScene(LoginScene:create());
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
