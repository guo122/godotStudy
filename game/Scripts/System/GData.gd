extends Node

var logMgr

var dataJson = {
	"mathScoreX": {}
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
	if data.size() == 4 && data[2] == "x":
		var num1: String = str(data[0])
		var num2: String = str(data[1])
		var mathScoreX = dataJson["mathScoreX"]
		var num1Dic: Dictionary
		var num2List: Array
		var scoreData: Array = []
		if !mathScoreX.has(num1):
			num1Dic = {}
			mathScoreX[num1] = num1Dic
		else:
			num1Dic = mathScoreX[num1]
		if !num1Dic.has(num2):
			num2List = []
			num1Dic[num2] = num2List
		else:
			num2List = num1Dic[num2]
		scoreData.append(OS.get_unix_time())
		scoreData.append(data[3])
		num2List.append(scoreData)


func _clearData():
	dataJson = {}
	dataJson["mathScoreX"] = {}
	_save()

