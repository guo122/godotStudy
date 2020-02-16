extends Label

var _g: Globals

func _ready():
	pass

func set_data(data: Array):
	_g = get_node("/root/Globals")
#	log_mgr.debug("[MathScoreOneTips] set data:")
#	log_mgr.debug(data)
	if data.size() == 3:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": --"
	elif data.size() == 4:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": " + ("%.2f" % [data[3]]) + "s"
		if data[3] <= 60:
			_g.data_mgr.add_score(data)
