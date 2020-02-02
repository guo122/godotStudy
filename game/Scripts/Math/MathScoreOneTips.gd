extends Label

var logMgr
var dataMgr

func _ready():
	pass

func _set_data(data: Array):
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")
#	logMgr._log("[MathScoreOneTips] set data:")
#	logMgr._log(data)
	if data.size() == 3:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": --"
	elif data.size() == 4:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": " + ("%.2f" % [data[3]]) + "s"
		if data[3] <= 60:
			dataMgr._addScore(data)
