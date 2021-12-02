local function datetime(iTimeStamp)
	return os.date("%Y-%m-%d %H:%M:%S", iTimeStamp)
end

function POP.GetData(cb, iFrom, iTo)
	local q = [[
		SELECT `sid`, MIN(UNIX_TIMESTAMP(`date`)) AS `date`
		FROM `trigon_authlog`
		]] .. (iFrom and "WHERE `date` BETWEEN '{from}' AND {to}" or "") .. [[
		GROUP BY `sid`
		ORDER BY `date`
	]]

	q = iFrom and
		q:gsub( "{from}",datetime(iFrom) )
		 :gsub( "{to}",iTo and ("'" .. datetime(iTo) .. "'") or "CURRENT_TIMESTAMP" )
	or q

	QS(q, cb)
end

-- POP.GetData(cb, os.time(), nil)