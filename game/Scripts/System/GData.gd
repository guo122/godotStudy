extends Node

const FILE_NAME = "user://game-data.json"
const SCORE_MAP_CACHE_IMAGE_NAME = "user://score_map_cache.png"

const SCORE_MAP_IMAGE_X = 658
const SCORE_MAP_IMAGE_Y = 658
const SCORE_MAP_IMAGE_FORMAT = Image.FORMAT_RGB8
const SCORE_MAP_DEFAULT_COLOR = Color(1, 1, 1)
const SCORE_MAP_LINE_COLOR = Color(0.8, 0.8, 0.8)

var logMgr: GLog

var _rgb_img_width

var _data_hightlight_map: Image = null
var _data_score_map_img: Image = null
var _rgb_tex: ImageTexture = load("res://Assets/misc/r1.png")
var _rgb_img: Image
var _data = {}

var _dirty: bool = false

func _ready():
	logMgr = get_node("/root/GLog")
	_load()
	logMgr._log("[Data] ready")
	

func _save():
	if _dirty:
		var file = File.new()
		file.open(FILE_NAME, File.WRITE)
		file.store_string(to_json(_data))
		file.close()
		
	#	file.open(SCORE_MAP_CACHE_IMAGE_NAME, File.WRITE)
	#	var data = _data_score_map_img.get_data()
	#	file.store_buffer(data)
	#	file.close()
		_data_score_map_img.save_png(SCORE_MAP_CACHE_IMAGE_NAME)
		_dirty = false


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
	if file.file_exists(SCORE_MAP_CACHE_IMAGE_NAME):
		file.open(SCORE_MAP_CACHE_IMAGE_NAME, File.READ)
		var data = file.get_buffer(file.get_len())
		file.close()
		_data_score_map_img = Image.new()
		_data_score_map_img.load_png_from_buffer(data)
	_rgb_img_width = _rgb_tex.get_size().x
	_rgb_img = _rgb_tex.get_data()
	_initData()


func _addScore(data: Array):
	if data.size() == 4 && data[2] == "x":
		_dirty = true
		var idxX: int = data[0] - 11
		var idxY: int = data[1] - 11
		var dataList = []
		dataList.append(OS.get_unix_time())
		dataList.append(data[3])
		_data["mathMatrixX"][idxX][idxY].append(dataList)
		_data_score_map_img.lock()
		_set_map_color(idxX, idxY, _data["mathMatrixX"][idxX][idxY])
		_data_score_map_img.unlock()


func _clearData():
	_dirty = true
	_data = {}
	_data_score_map_img = null
	_initData()
	_save()


func _initData():
	if !_data.has("mathMatrixX"):
		_dirty = true
		var mathMatrixX = []
		_data["mathMatrixX"] = mathMatrixX
		for i in range(11, 100):
			var num1Array = []
			mathMatrixX.append(num1Array)
			for j in range(11, 100):
				var num2Array = []
				num1Array.append(num2Array)
	if _data.has("mathScoreX") && _data["mathScoreX"].size() > 0:
		_dirty = true
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
	if !_data.has("setting"):
		_dirty = true
		var setting_dic = {}
		setting_dic["score_map_color_ratio"] = 100
		_data["setting"] = setting_dic
	if !_data_score_map_img:
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
			_data_score_map_img.set_pixel(i, j, cc)


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
	_data_hightlight_map.create(SCORE_MAP_IMAGE_X, SCORE_MAP_IMAGE_Y, false, Image.FORMAT_RGBA8)


func _get_color(sec: float) -> Color:
	var ratio: float = 6 - float(_data["setting"]["score_map_color_ratio"]) / 20
	var val = clamp(sec / 60 * _rgb_img_width * ratio, 0, _rgb_img_width - 1)
	_rgb_img.lock()
	var ret = _rgb_img.get_pixel(val, 0)
	_rgb_img.unlock()
	return ret


func _init_color_map():
	_dirty = true
	_data_score_map_img = null
	_data_score_map_img = Image.new()
	_data_score_map_img.create(SCORE_MAP_IMAGE_X, SCORE_MAP_IMAGE_Y, false, SCORE_MAP_IMAGE_FORMAT)
	_data_score_map_img.lock()
	for i in range(0, SCORE_MAP_IMAGE_X):
		for j in range(0, SCORE_MAP_IMAGE_Y):
			if i % 73 == 0 || j % 73 == 0:
				_data_score_map_img.set_pixel(i, j, SCORE_MAP_LINE_COLOR)
			else:
				_data_score_map_img.set_pixel(i, j, SCORE_MAP_DEFAULT_COLOR)
	_data_score_map_img.unlock()
	_update_color_map()
	logMgr._log("[GData] init math map.")


func _update_color_map():
	_data_score_map_img.lock()
	var ii: int = -1
	var jj: int = -1
	for i in _data["mathMatrixX"]:
		ii += 1
		jj = -1
		for j in i:
			jj += 1
			if !j.empty():
				_set_map_color(ii, jj, j)
	_data_score_map_img.unlock()


func _printMetaData():
	logMgr._log(_data)


func _get_score_map_color_ratio() -> int:
	return _data["setting"]["score_map_color_ratio"]


func _set_score_map_color_ratio(ratio: int):
	if ratio != _data["setting"]["score_map_color_ratio"]:
		_dirty = true
		_data["setting"]["score_map_color_ratio"] = ratio
		_update_color_map()













