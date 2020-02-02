extends Node

var logMgr

var dataJson = {
	"mathScore": []
}

func _ready():
	logMgr = get_node("/root/GLog")
	logMgr._log("data ready")
	_load()
	logMgr._log("[GData] load data:")
	logMgr._log(dataJson)

const FILE_NAME = "user://game-data.json"

func _save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(dataJson))
	file.close()

func _load():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			dataJson = data
		else:
			logMgr._error("Corrupted data!")
	else:
		logMgr._error("No saved data!")


func _addScore(data: Array):
	var mathScore = dataJson["mathScore"]
	var scoreData: Array = []
	if data.size() == 3:
		scoreData.append(data[0])
		scoreData.append(data[1])
		scoreData.append(data[2])
		scoreData.append("--")
		mathScore.append(scoreData)
	elif data.size() == 4:
		scoreData.append(data[0])
		scoreData.append(data[1])
		scoreData.append(data[2])
		scoreData.append(data[3])
		mathScore.append(scoreData)


