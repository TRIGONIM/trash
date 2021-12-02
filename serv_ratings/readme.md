# Визуализация истории онлайна сервера

Больше не требуется, так как может быть заменен на metabase

Для модуля требуется auth_log таблица, где каждый вход игрока логировался

---

### Какие-то заметки

-- iGroupBy
-- MINS   = 1
-- HOURS  = 2
-- DAYS   = 3
-- MONTHS = 4
-- YEARS  = 5

local iFrom = dateToStamp("2017-07-03 21:47:24") -- getDatetime()
POP.RequestData(cb, iFrom,iTo,iGroupBy)

POP.UI(dateToStamp("2017-07-02 21:47:24"),nil,2)