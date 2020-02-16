extends Node

signal signal_log_update

enum {_INFO, _DEBUG, _WARNING, _ERROR}

var _b_debug: bool = false
var _b_warning: bool = true
var _b_error: bool = true

var _array_type: Array = []
var _array_log: Array = []
var _log_data: String = ""

func _ready():
	info("[Log] ready")


func info(content):
	print(content)
	var data = "[color=#ff0000]|[/color] " + str(content)
	_array_type.append(_INFO)
	_array_log.append(data)
	_log_data += data + "\n"
	emit_signal("signal_log_update", _log_data)


func debug(content):
	var data = "[color=#ffc600]|[/color] " + str(content)
	_array_type.append(_DEBUG)
	_array_log.append(data)
	if _b_debug:
		print(content)
		_log_data += data + "\n"
		emit_signal("signal_log_update", _log_data)


func warning(content):
	var data = "[color=#ff0000]|[/color] [color=#ffc600]" + str(content) + "[/color]"
	_array_type.append(_WARNING)
	_array_log.append(data)
	if _b_warning:
		push_warning(content)
		_log_data += data + "\n"
		emit_signal("signal_log_update", _log_data)
	

func error(content):
	var data = "[color=#ffc600]|[/color] [color=#ff0000]" + str(content) + "[/color]"
	_array_type.append(_ERROR)
	_array_log.append(data)
	if _b_error:
		push_error(content)
		_log_data += data + "\n"
		emit_signal("signal_log_update", _log_data)


func set_debug(enable: bool):
	_b_debug = enable
	_refresh_log_data()


func set_warning(enable: bool):
	_b_warning = enable
	_refresh_log_data()


func set_error(enable: bool):
	_b_error = enable
	_refresh_log_data()


func log_data() -> String:
	return _log_data


func clear():
	_array_type.clear()
	_array_log.clear()
	_refresh_log_data()


func _refresh_log_data():
	_log_data = ""
	var i: int = -1
	for data in _array_log:
		i += 1
		if _array_type[i] == _INFO || _array_type[i] == _DEBUG && _b_debug || _array_type[i] == _WARNING && _b_warning || _array_type[i] == _ERROR && _b_error:
			_log_data += data + "\n"
	emit_signal("signal_log_update", _log_data)










