cc.exports.ProtobufController = class("ProtobufController");
function ProtobufController:loadProto()
	local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("proto/client.pb");
	local buffer = read_protobuf_file_c(pbFilePath);
	protobuf.register(buffer);	--注：protobuf是因为在protobuf.lua里面使用module(protobuf)来修改全局名字
end

function ProtobufController:sendLogin(userName, password)
	local login = {
		name = userName,
		passwd = password,
		way = "-1",
		ip = "",
		platform = 1,
	};
	return self:serialize("proto.UserRequest.LobbyLogin", login)
end

function ProtobufController:sendAutoID()
	local autoID = {
		id = 2017,
	};
	return self:serialize("proto.AutoID", autoID)
end

function ProtobufController:unSerialize(objStr, bufStr)
	return protobuf.decode(objStr, bufStr);
end

function ProtobufController:serialize(proto, protoObj)
	local buffer = protobuf.encode(proto, protoObj);
	local bufferLen = string.len(buffer);
	return buffer, bufferLen;
end

ProtobufController.Code = {
    SUCCESS                   = 0;
    ERR_INVALID_PROTOCOL      = 1;
    ERR_INVALID_DATA          = 2; --客户端数据错误
    ERR_INVALID_OPERATION     = 3; --无效操作
    ERR_USER_UNUSABLE         = 6; --用户未激活
    ERR_ACCOUT_LOCK           = 7; --账户被锁定，禁止下注
    ERR_AUTHFAIL              = 401; --登录认证失败
    ERR_SERVER_INTERNAL_ERROR = 500; --服务端内部错误
}

ProtobufController.Command = {
    -- 主命令 (0 ~ 99)
    client_heart_beat     = 0;   -- 心跳包..    -> AutoID  
    client_heart_beat_ack = 1;   -- 心跳响应     -> AutoID   
    user_lobby_login      = 10;  -- 登陆        -> UserRequest.LobbyLogin
    user_lobby_login_ack  = 11;  -- 登录响应    -> CommonReply 
    user_game_login       = 50;  -- 进入游戏    -> UserRequest.GameLogin
    user_game_login_ack   = 51;  -- 进入游戏响应  -> CommonReply
    user_game_exit        = 60;  -- 退出游戏     -> UserRequest.GameExit
    user_game_exit_ack    = 61;  --             -> CommonReply
    user_lobby_logout     = 400; -- 登出请求     -> UserRequest.NilBody
    user_lobby_logout_ack = 401; --             -> CommonReply
    server_message_push   = 110; -- 服务端通知 踢出提示,以及各种文字提示等 -> CommonReply


    -- 大厅命令 (500 ~ 999)
    lobby_change_avatar     = 510;   -- 修改头像     -> AutoID
    lobby_change_avatar_ack = 511;   --               -> CommonReply     
    lobby_change_nick       = 520;   -- 修改昵称      -> String
    lobby_change_nick_ack   = 521;    --               -> CommonReply 
    lobby_player_push       = 600; -- 大厅个人信息推送   -> Lobby.UserSnapshot
    lobby_videourl_push     = 601; -- 游戏直播拉流地址   -> String
    lobby_status_push       = 602; -- 大厅状态消息推送   -> Lobby.TableSnapshot
    lobby_playercount_push  = 603; -- 游戏人数推送       -> AutoID

    
    -- 游戏命令 (1000 ~ 1999)
    game_leave_table         = 1000; -- 离开桌面            -> Game.JoinTable 
    game_leave_table_ack     = 1001; -- ack                -> CommonReply
    game_join_table          = 1010; -- 进入牌桌            -> Game.LeaveTable 
    game_join_table_ack      = 1011; -- ack                -> CommonReply
    game_bet                 = 1020; -- 下注                -> Game.Bet
    game_bet_ack             = 1021; --                    -> CommonReply
    game_tip                 = 1030; -- 小费                -> Game.Tip
    game_tip_ack             = 1031; --                    -> CommonReply
    game_table_snapshot_push = 1901; -- 桌面快照,发送给大厅  客户端忽略此命令   
    game_table_status_push   = 1902; -- 桌面状态 发送给客户端  ->Game.TableStatus 
    game_table_config_push   = 1903; -- 桌面配置 发送给客户端  ->Game.TableConfig
    game_table_history_push  = 1904; -- 桌面历史 发送给客户端  ->Game.TableHistory
    game_player_push         = 1905; -- 个人信息             ->Game.UserSnapshot
    game_virtual_table_push  = 1906; -- 包间信息             ->Game.VirtaulTable.Table

    -- 管理命令
    dealer_command           = 2000;

    -- 测试命令 (10000 ~)
    --test_any = 10001;
    test_oneof = 10002;
    test_map   = 10003;
    
}

ProtobufController.GameType = {
    UnKnow     = 0;
    Baccarat   = 11;
    LongHu     = 12;
    Roulette   = 13;
    SicBo      = 14;
    FanTan     = 15;
    TexasPoker = 16;
}