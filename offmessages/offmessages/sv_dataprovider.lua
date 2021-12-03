function OM.AddRecord(s64, sMessage, sTitle, cb)
	Q([[
		INSERT INTO `player_notifications` (`uid`, `title`, `message`)
		SELECT `ID`, ]] .. (sTitle and sql.SQLStr(sTitle) or "NULL") .. [[, ? FROM `player_data`
		WHERE `SteamID` = ?
	;]], sMessage, s64, cb and function(_,id)
		cb(id)
	end)
end

function OM.GetPlayerMessages(s64,cb,bIncludeReaded)
	Q([[
		SELECT `id`, `title`, `read`
		FROM `player_notifications`
		WHERE
			]] .. (bIncludeReaded and "" or "`read` = 0 AND") .. [[
			`uid` = (
				SELECT `ID`
				FROM `player_data`
				WHERE `SteamID` = ']] .. s64 .. [['
			)
	;]],cb)
end
-- OM.GetPlayerMessages(AMD():SteamID64(),prt)

function OM.GetMessageOwner(iMsgID, cb)
	Q([[
		SELECT `uid`
		FROM `player_notifications`
		WHERE `id` = ]] .. iMsgID .. [[
	]],function(d)
		cb(d[1].uid)
	end)
end

function OM.GetMessageText(iMsgID,cb)
	Q([[
		SELECT `message`
		FROM `player_notifications`
		WHERE `id` = ]] .. iMsgID .. [[
	;]],function(d)
		cb(d[1].message)
	end)
end

function OM.MarkRead(MsgID,bRead,cb) -- после этого сообщение больше не отобразится игроку
	Q([[
		UPDATE `player_notifications`
		SET `read` = ]] .. (bRead and 1 or 0) .. [[
		WHERE `id` = ]] .. MsgID .. [[
	]],cb and function(_,_,aff)
		cb(aff > 0)
	end)
end





--[[-------------------------------------------------------------------------
	Дополнительные. Для спец. целей
---------------------------------------------------------------------------]]
function OM.PlayerHasMessage(s64,sMessage,sTitle,fCallback)
	local res = ta.concatenateQueryParams({
		title   = sTitle,
		message = sMessage
	},true)

	Q([[
		SELECT `read`
		FROM `player_notifications`
		WHERE `uid` = (
				SELECT `ID`
				FROM `player_data`
				WHERE `SteamID` = ]] .. s64 .. [[
			)

		AND
	]] .. res,function(d)
		fCallback(d[1] and true, d)
	end)
end



Q([[
CREATE TABLE IF NOT EXISTS `player_notifications` (
	`id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
	`uid` mediumint(8) UNSIGNED NOT NULL,
	`title` varchar(128) DEFAULT NULL,
	`message` varchar(1024) NOT NULL,
	`read` bit(1) DEFAULT NULL,
	`date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (`id`),
	KEY `uid` (`uid`),
	KEY `read` (`read`)
) DEFAULT CHARSET=utf8;
]])