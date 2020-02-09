extends Node

signal glog_update

enum LogType {LOG, DEBUG, WARNING, ERROR}

var b_debug: bool = false
var b_warning: bool = true
var b_error: bool = true

var array_type: Array = []
var array_log: Array = []
var log_data: String = ""

func _ready():
	_log("[Log] ready")


func _log(content):
	print(content)
	var data = "[color=#ff0000]|[/color] " + str(content)
	array_type.append(LogType.LOG)
	array_log.append(data)
	log_data += data + "\n"
	emit_signal("glog_update", log_data)


func _debug(content):
	var data = "[color=#ffc600]|[/color] " + str(content)
	array_type.append(LogType.DEBUG)
	array_log.append(data)
	if b_debug:
		print(content)
		log_data += data + "\n"
		emit_signal("glog_update", log_data)


func _warning(content):
	var data = "[color=#ff0000]|[/color] [color=#ffc600]" + str(content) + "[/color]"
	array_type.append(LogType.WARNING)
	array_log.append(data)
	if b_warning:
		push_warning(content)
		log_data += data + "\n"
		emit_signal("glog_update", log_data)
	

func _error(content):
	var data = "[color=#ffc600]|[/color] [color=#ff0000]" + str(content) + "[/color]"
	array_type.append(LogType.ERROR)
	array_log.append(data)
	if b_error:
		push_error(content)
		log_data += data + "\n"
		emit_signal("glog_update", log_data)


func _set_debug(enable: bool):
	b_debug = enable
	_refresh_log_data()


func _set_warning(enable: bool):
	b_warning = enable
	_refresh_log_data()


func _set_error(enable: bool):
	b_error = enable
	_refresh_log_data()


func _clear():
	array_type.clear()
	array_log.clear()
	_refresh_log_data()


func _refresh_log_data():
	log_data = ""
	var i: int = -1
	for data in array_log:
		i += 1
		if array_type[i] == LogType.LOG || array_type[i] == LogType.DEBUG && b_debug || array_type[i] == LogType.WARNING && b_warning || array_type[i] == LogType.ERROR && b_error:
			log_data += data + "\n"
	emit_signal("glog_update", log_data)











