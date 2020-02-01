extends Node

var log_data: String

func _ready():
	print("log ready")
	

func _log(content: String):
	print(content)
	log_data = content + "\n" + log_data


func _warning(content: String):
	push_warning(content)
	log_data = "[color=#ffc600]" + content + "[/color]\n" + log_data
	

func _error(content: String):
	push_error(content)
	log_data = "[color=#ff0000]" + content + "[/color]\n" + log_data
