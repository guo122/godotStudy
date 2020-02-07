extends Object

class_name ToolsDatetime


static func _DurationSecond2Datetime(second: float) -> String:
	var tmp_hour: int = int(second) / 3600
	var tmp_minute: int = (int(second) - (tmp_hour * 3600)) / 60
	var tmp_second: int = int(second) - (tmp_hour * 3600) - (tmp_minute * 60)
	var str_h: String = ""
	var str_m: String = ""
	var str_s: String = ""
	if tmp_hour > 0:
		str_h = str(tmp_hour) + "h "
	if tmp_hour > 0 || tmp_minute > 0:
		str_m = str(tmp_minute) + "m "
	if tmp_hour > 0 || tmp_minute > 0 || tmp_second > 0:
		str_s = str(tmp_second) + "s "
	return str_h + str_m + str_s


static func _Timestamp2Date(second: int) -> String:
	var ret: String = ""
	var dic = OS.get_datetime_from_unix_time(second)
	ret = str(dic["year"]) + "-" + str(dic["month"]) + "-" + str(dic["day"])
	return ret



















