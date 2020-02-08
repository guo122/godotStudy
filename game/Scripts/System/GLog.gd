extends Node

signal glog_update

var b_debug: bool = false
var log_data: String

func _ready():
	_log("[Log] ready")
	

func _log(content):
	print(content)
	log_data += "[color=#ff0000]|[/color] " + str(content) + "\n"
	emit_signal("glog_update", log_data)


func _debug(content):
	if b_debug:
		print(content)
		log_data += "[color=#ffc600]|[/color] " + str(content) + "\n"
		emit_signal("glog_update", log_data)


func _warning(content):
	push_warning(content)
	log_data += "[color=#ff0000]|[/color] [color=#ffc600]" + str(content) + "[/color]\n"
	emit_signal("glog_update", log_data)
	

func _error(content):
	push_error(content)
	log_data += "[color=#ffc600]|[/color] [color=#ff0000]" + str(content) + "[/color]\n"
	emit_signal("glog_update", log_data)
