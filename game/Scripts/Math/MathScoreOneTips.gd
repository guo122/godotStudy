extends Label

var logMgr

func _ready():
	pass

func _set_data(data: Array):
	logMgr = get_node("/root/GLog")
	logMgr._log("[MathScoreOneTips] set data:")
	logMgr._log(data)
	if data.size() == 3:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": --"
	elif data.size() == 4:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": " + str(data[3]).left(4) + "s"
