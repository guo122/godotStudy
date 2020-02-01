extends Node

var logMgr
var NinePadPositiveLayoutStyle: bool

func _ready():
	logMgr = get_node("/root/GLog")
	logMgr._log("globals ready")
	NinePadPositiveLayoutStyle = false
	

