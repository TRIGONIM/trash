

/*******************************************
	Заметка о каллбэках:
	res,lastid,affected_rows,time_wasted
********************************************/

-- from -- STEAMID того, КТО оставил отзыв(репу)
-- to   -- STEAMID того, КОМУ оставили отзыв
-- Одно из значений может отсутствовать
function REP.getData(by,to,callback)
	local q = "SELECT * FROM reputation_actions WHERE "

	if by then
		q = q .. "`by` = " .. sql.SQLStr(by) .. (to and " AND " or ";")
	end

	if to then
		q = q .. "`for` = " .. sql.SQLStr(to) .. ";"
	end

	Q(q,callback)
end

function REP.addRecord(from,to,category,message,onsuccess)
	message = message or ""
	Q(
		"INSERT INTO reputation_actions(`by`,`for`,`value`,`message`,`date`) VALUES(?,?,?,?,?)",
		from,to,category,message,getDatetime(),onsuccess
	)
end

-- Редактирование
/*
REP.modRecord(228,{
	["message"] = "Новое сообщение"
},function()
	print("Отредактировано")
end)
*/
function REP.modRecord(id,keyvalues,onsuccess)
	Q([[
		UPDATE `reputation_actions`
		SET ]] .. TL.concatenateQueryParams(keyvalues) .. [[
		WHERE `id` = ?
	]],id,onsuccess)
end

function REP.delRecord(id,author,onsuccess)
	Q(
		"DELETE FROM `reputation_actions` WHERE `id` = " .. sql.SQLStr(id) ..
		(author and (" AND `by` = " .. sql.SQLStr(author)) or ";"),
		onsuccess
	)
end

function REP.createDatabases()
	Q([[
	CREATE TABLE IF NOT EXISTS `reputation_actions` (
		`id`      int(10)    unsigned NOT NULL AUTO_INCREMENT,
		`by`      varchar(30)         NOT NULL,
		`for`     varchar(30)         NOT NULL,
		`value`   tinyint(3) unsigned NOT NULL,
		`message` varchar(255)        NOT NULL,
		`date`    datetime            NOT NULL,

		PRIMARY KEY (`id`),
		KEY `by` (`by`),
		KEY `for` (`for`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	]])
end

REP.createDatabases()
