extends Node

const FILE_NAME = "user://game-data.json"
const COLOR_IMAGE_NAME = "user://color-image.png"

const COLOR_IMAGE_X = 658
const COLOR_IMAGE_Y = 658
const COLOR_IMAGE_SIZE = 1298892
const COLOR_IMAGE_FORMAT = Image.FORMAT_RGB8
const COLOR_DEFAULT_COLOR = Color(1, 1, 1)
const COLOR_LINE_COLOR = Color(0.8, 0.8, 0.8)

var logMgr

var _data_color_map = {
	"5": Color(0, 1, 1),
	"10": Color(0, 1, 0.5),
	"15": Color(0, 1, 0),
	"20": Color(0.5, 1, 0),
	"25": Color(0.8, 0.8, 0),
	"30": Color(1, 0.8, 0),
	"35": Color(1, 0.65, 0),
	"40": Color(1, 0.5, 0),
	"45": Color(1, 0.35, 0),
	"50": Color(1, 0.2, 0),
	"55": Color(1, 0.1, 0),
	"60": Color(1, 0, 0)
}

var _data_hightlight_map: Image = null
var _data_color_image: Image = null
var _data = {}

func _ready():
	logMgr = get_node("/root/GLog")
	_load()
	logMgr._log("[Data] ready")
	

func _save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(_data))
	file.close()
	
	file.open(COLOR_IMAGE_NAME, File.WRITE)
	var data = _data_color_image.get_data()
	file.store_buffer(data)
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
	if file.file_exists(COLOR_IMAGE_NAME):
		file.open(COLOR_IMAGE_NAME, File.READ)
		var data = file.get_buffer(COLOR_IMAGE_SIZE)
		file.close()
		_data_color_image = Image.new()
		_data_color_image.create_from_data(COLOR_IMAGE_X, COLOR_IMAGE_Y, false, COLOR_IMAGE_FORMAT, data)
	_initData()


func _addScore(data: Array):
	if data.size() == 4 && data[2] == "x":
		var idxX: int = data[0] - 11
		var idxY: int = data[1] - 11
		var dataList = []
		dataList.append(OS.get_unix_time())
		dataList.append(data[3])
		_data["mathMatrixX"][idxX][idxY].append(dataList)
		_data_color_image.lock()
		_set_map_color(idxX, idxY, _data["mathMatrixX"][idxX][idxY])
		_data_color_image.unlock()


func _clearData():
	_data = {}
	_data_color_image = null
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
	if !_data_color_image:
		_init_color_map()
	_clear_hightlight_color()
	_save()


func _set_map_color(idxX, idxY, dataList: Array):
	var score_sum: float = 0
	var score_num: int = 0
	for data in dataList:
		score_sum += data[1]
		score_num += 1
	var cc = _get_color(score_sum / score_num)
	var ii = int((idxX + 11) / 10)
	var jj = int((idxY + 11) / 10)
	var ix = idxX - ii + 1
	var iy = idxY - jj + 1
	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
		for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
			_data_color_image.set_pixel(i, j, cc)


func _set_highlight_color(idxX, idxY):
	var cc = Color(1, 1, 1, 1)
	_data_hightlight_map.lock()
	var ii = int((idxX + 11) / 10)
	var jj = int((idxY + 11) / 10)
	var ix = idxX - ii + 1
	var iy = idxY - jj + 1
	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
		for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
			_data_hightlight_map.set_pixel(i, j, cc)
			
#	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
#		_data_hightlight_map.set_pixel(i, iy * 8 + jj, cc)
#		_data_hightlight_map.set_pixel(i, iy * 8 + 7 + jj, cc)
#	for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
#		_data_hightlight_map.set_pixel(ix * 8 + ii, j, cc)
#	for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
#		_data_hightlight_map.set_pixel(ix * 8 + 7 + ii, j, cc)
	
	_data_hightlight_map.unlock()


func _clear_hightlight_color():
	_data_hightlight_map = null
	_data_hightlight_map = Image.new()
	_data_hightlight_map.create(COLOR_IMAGE_X, COLOR_IMAGE_Y, false, Image.FORMAT_RGBA8)


func _get_color(sec: float) -> Color:
	var idx = str((int(sec / 5) + 1) * 5)
	if _data_color_map.has(idx):
		return _data_color_map[idx]
	else:
		logMgr._error("[GData] get color error.")
		return COLOR_DEFAULT_COLOR


func _init_color_map():
	_data_color_image = null
	_data_color_image = Image.new()
	_data_color_image.create(COLOR_IMAGE_X, COLOR_IMAGE_Y, false, COLOR_IMAGE_FORMAT)
	_data_color_image.lock()
	for i in range(0, COLOR_IMAGE_X):
		for j in range(0, COLOR_IMAGE_Y):
			if i % 73 == 0 || j % 73 == 0:
				_data_color_image.set_pixel(i, j, COLOR_LINE_COLOR)
			else:
				_data_color_image.set_pixel(i, j, COLOR_DEFAULT_COLOR)
	var ii: int = -1
	var jj: int = -1
	for i in _data["mathMatrixX"]:
		ii += 1
		jj = -1
		for j in i:
			jj += 1
			if !j.empty():
				_set_map_color(ii, jj, j)
	_data_color_image.unlock()
	logMgr._log("[GData] init math map.")


func _printMetaData():
	logMgr._log(_data)














