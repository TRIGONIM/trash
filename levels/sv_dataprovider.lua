-- Получает опыт оффлайн игрока
-- в каллбэке будет nil, если у чела нет записи в БД
function LVL.getOfflineData(callback,sid)
	Q(
		"SELECT `exp` FROM `leveling_system` WHERE steamid = ?",
		sid,function(dat)
			callback(dat[1])
		end
	)
end

-- Сохраняет опыт в базу, как в даркрп деньги
function LVL.storeXP(sid,amount,onfinish)
	Q(
		"REPLACE INTO `leveling_system`(`steamid`,`exp`) VALUES (?,?)",
		sid,amount,onfinish
	)
end



Q([[

CREATE TABLE IF NOT EXISTS `leveling_system` (
	`steamid` varchar(30) NOT NULL,
	`exp`     int(10) unsigned NOT NULL,

	UNIQUE KEY `steamid` (`steamid`)
) DEFAULT CHARSET=utf8;

]])
