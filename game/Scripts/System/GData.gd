extends Node

var logMgr

var _data = {}

func _ready():
	logMgr = get_node("/root/GLog")
	_load()
	logMgr._log("[Data] ready")

const FILE_NAME = "user://game-data.json"

func _save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(_data))
	file.close()

func _load():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			_data = data
		else:
			logMgr._error("Corrupted data!")
	else:
		logMgr._error("No saved data!")
	_initData()


func _addScore(data: Array):
	if data.size() == 4 && data[2] == "x":
		var dataList = []
		dataList.append(OS.get_unix_time())
		dataList.append(data[3])
		_data["mathMatrixX"][data[0] - 11][data[1] - 11].append(dataList)	


func _clearData():
	_data = {}
	_initData()
	_save()
		

func _initData():
	if !_data.has("mathMatrixX"):
		var mathMatrixX = []
		_data["mathMatrixX"] = mathMatrixX
		for i in range(11, 100):
			var num1Array = []
			mathMatrixX.append(num1Array)
			for j in range(11, 100):
				var num2Array = []
				num1Array.append(num2Array)
	if _data.has("mathScoreX") && _data["mathScoreX"].size() > 0:
		var mathScoreX = _data["mathScoreX"]
		for num1 in mathScoreX:
			for num2 in mathScoreX[num1]:
				var scoreDataList = mathScoreX[num1][num2]
				for i in scoreDataList:
					var dataList = []
					dataList.append(i[0])
					dataList.append(i[1])
					_data["mathMatrixX"][int(num1) - 11][int(num2) - 11].append(dataList)
		_data.erase("mathScoreX")
		_save()


func _printMetaData():
	logMgr._log(_data)














