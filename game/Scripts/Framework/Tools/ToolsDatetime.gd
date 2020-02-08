extends Object

class_name ToolsDatetime

static func _time_zone_offset(time_stamp: int) -> int:
	var time_zone_offset = 28800
	return time_stamp + time_zone_offset

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


static func _Timestamp2Date(time_stamp: int) -> String:
	var ret: String = ""
	var dic = OS.get_datetime_from_unix_time(_time_zone_offset(time_stamp))
	ret = str(dic["year"]) + "-" + str(dic["month"]) + "-" + str(dic["day"])
	return ret


static func _Timestamp2Datetime(time_stamp: int) -> String:
	var ret: String = ""
	var dic = OS.get_datetime_from_unix_time(_time_zone_offset(time_stamp))
	ret = str(dic["year"]) + "-" + str(dic["month"]) + "-" + str(dic["day"]) + " " + str(dic["hour"]) + ":" + str(dic["minute"]) + ":" + str(dic["second"])
	return ret


static func _is_same_day(time_stamp1: int, time_stamp2: int = 0) -> bool:
	var time1 = time_stamp1
	var time2 = time_stamp2
	if time2 == 0:
		time2 = OS.get_unix_time()
	
	var dic1 = OS.get_datetime_from_unix_time(_time_zone_offset(time1))
	var dic2 = OS.get_datetime_from_unix_time(_time_zone_offset(time2))
	if dic1["day"] != dic2["day"] || dic1["month"] != dic2["month"] || dic1["year"] != dic2["year"]:
		return false
	else:
		return true


static func _get_hour(time_stamp: int) -> int:
	var dic = OS.get_datetime_from_unix_time(_time_zone_offset(time_stamp))
	return dic["hour"]
















