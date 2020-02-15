extends Label

var _g: Globals

func _ready():
	pass

func _set_data(data: Array):
	_g = get_node("/root/Globals")
#	logMgr._debug("[MathScoreOneTips] set data:")
#	logMgr._debug(data)
	if data.size() == 3:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": --"
	elif data.size() == 4:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": " + ("%.2f" % [data[3]]) + "s"
		if data[3] <= 60:
			_g.dataMgr._addScore(data)
