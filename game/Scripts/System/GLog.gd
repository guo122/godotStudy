extends Node

signal glog_update

var log_data: String

func _ready():
	_log("log ready")
	

func _log(content):
	print(content)
	log_data = str(content) + "\n" + log_data
	emit_signal("glog_update", log_data)


func _warning(content):
	push_warning(content)
	log_data = "[color=#ffc600]" + str(content) + "[/color]\n" + log_data
	emit_signal("glog_update", log_data)
	

func _error(content):
	push_error(content)
	log_data = "[color=#ff0000]" + str(content) + "[/color]\n" + log_data
	emit_signal("glog_update", log_data)
