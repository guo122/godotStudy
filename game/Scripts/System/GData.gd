extends Node

const _FILE_NAME = "user://game-data.json"
const _SCORE_MAP_CACHE_IMAGE_NAME = "user://score_map_cache.png"

const _SCORE_MAP_IMAGE_X = 658
const _SCORE_MAP_IMAGE_Y = 658
const _SCORE_MAP_IMAGE_FORMAT = Image.FORMAT_RGB8
const _SCORE_MAP_DEFAULT_COLOR = Color(1, 1, 1)
const _SCORE_MAP_LINE_COLOR = Color(0.8, 0.8, 0.8)

var _rgb_img_width

var data_hightlight_map: Image = null
var data_score_map_img: Image = null
var _rgb_tex: ImageTexture = load("res://Assets/misc/r1.png")
var _rgb_img: Image
var dic_game_data = {}

var _dirty: bool = false

var _log_mgr: LogMgr

func _ready():
	_log_mgr = get_node("/root/LogMgr")
	_load()
	_log_mgr.info("[Data] ready")
	

func save():
	if _dirty:
		var file = File.new()
		file.open(_FILE_NAME, File.WRITE)
		file.store_string(to_json(dic_game_data))
		file.close()
		
	#	file.open(_SCORE_MAP_CACHE_IMAGE_NAME, File.WRITE)
	#	var data = data_score_map_img.get_data()
	#	file.store_buffer(data)
	#	file.close()
		data_score_map_img.save_png(_SCORE_MAP_CACHE_IMAGE_NAME)
		_dirty = false


func _load():
	var file = File.new()
	if file.file_exists(_FILE_NAME):
		file.open(_FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			dic_game_data = data
		else:
			_log_mgr.error("Corrupted data!")
	if file.file_exists(_SCORE_MAP_CACHE_IMAGE_NAME):
		file.open(_SCORE_MAP_CACHE_IMAGE_NAME, File.READ)
		var data = file.get_buffer(file.get_len())
		file.close()
		data_score_map_img = Image.new()
		data_score_map_img.load_png_from_buffer(data)
	_rgb_img_width = _rgb_tex.get_size().x
	_rgb_img = _rgb_tex.get_data()
	_init_data()


func add_score(data: Array):
	if data.size() == 4 && data[2] == "x":
		_dirty = true
		var idxX: int = data[0] - 11
		var idxY: int = data[1] - 11
		var dataList = []
		dataList.append(OS.get_unix_time())
		dataList.append(data[3])
		dic_game_data["mathMatrixX"][idxX][idxY].append(dataList)
		data_score_map_img.lock()
		_set_map_color(idxX, idxY, dic_game_data["mathMatrixX"][idxX][idxY])
		data_score_map_img.unlock()


func clear_data():
	_dirty = true
	dic_game_data = {}
	data_score_map_img = null
	_init_data()
	save()


func _init_data():
	if !dic_game_data.has("mathMatrixX"):
		_dirty = true
		var mathMatrixX = []
		dic_game_data["mathMatrixX"] = mathMatrixX
		for i in range(11, 100):
			var num1Array = []
			mathMatrixX.append(num1Array)
			for j in range(11, 100):
				var num2Array = []
				num1Array.append(num2Array)
	if dic_game_data.has("mathScoreX") && dic_game_data["mathScoreX"].size() > 0:
		_dirty = true
		var mathScoreX = dic_game_data["mathScoreX"]
		for num1 in mathScoreX:
			for num2 in mathScoreX[num1]:
				var scoreDataList = mathScoreX[num1][num2]
				for i in scoreDataList:
					var dataList = []
					dataList.append(i[0])
					dataList.append(i[1])
					dic_game_data["mathMatrixX"][int(num1) - 11][int(num2) - 11].append(dataList)
		dic_game_data.erase("mathScoreX")
	if !dic_game_data.has("setting"):
		_dirty = true
		var setting_dic = {}
		setting_dic["score_map_color_ratio"] = 100
		dic_game_data["setting"] = setting_dic
	if !data_score_map_img:
		init_color_map()
	clear_hightlight_color()
	save()


func _set_map_color(idxX, idxY, dataList: Array):
	var score_sum: float = 0
	var score_num: int = 0
	for data in dataList:
		score_sum += data[1]
		score_num += 1
	var cc = get_color(score_sum / score_num)
	var ii = int((idxX + 11) / 10)
	var jj = int((idxY + 11) / 10)
	var ix = idxX - ii + 1
	var iy = idxY - jj + 1
	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
		for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
			data_score_map_img.set_pixel(i, j, cc)


func set_highlight_color(idxX, idxY):
	var cc = Color(1, 1, 1, 1)
	data_hightlight_map.lock()
	var ii = int((idxX + 11) / 10)
	var jj = int((idxY + 11) / 10)
	var ix = idxX - ii + 1
	var iy = idxY - jj + 1
	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
		for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
			data_hightlight_map.set_pixel(i, j, cc)
			
#	for i in range(ix * 8 + ii, ix * 8 + 8 + ii):
#		data_hightlight_map.set_pixel(i, iy * 8 + jj, cc)
#		data_hightlight_map.set_pixel(i, iy * 8 + 7 + jj, cc)
#	for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
#		data_hightlight_map.set_pixel(ix * 8 + ii, j, cc)
#	for j in range(iy * 8 + jj, iy * 8 + 8 + jj):
#		data_hightlight_map.set_pixel(ix * 8 + 7 + ii, j, cc)
	
	data_hightlight_map.unlock()


func clear_hightlight_color():
	data_hightlight_map = null
	data_hightlight_map = Image.new()
	data_hightlight_map.create(_SCORE_MAP_IMAGE_X, _SCORE_MAP_IMAGE_Y, false, Image.FORMAT_RGBA8)


func get_color(sec: float) -> Color:
	var ratio: float = 6 - float(dic_game_data["setting"]["score_map_color_ratio"]) / 20
	var val = clamp(sec / 60 * _rgb_img_width * ratio, 0, _rgb_img_width - 1)
	_rgb_img.lock()
	var ret = _rgb_img.get_pixel(val, 0)
	_rgb_img.unlock()
	return ret


func init_color_map():
	_dirty = true
	data_score_map_img = null
	data_score_map_img = Image.new()
	data_score_map_img.create(_SCORE_MAP_IMAGE_X, _SCORE_MAP_IMAGE_Y, false, _SCORE_MAP_IMAGE_FORMAT)
	data_score_map_img.lock()
	for i in range(0, _SCORE_MAP_IMAGE_X):
		for j in range(0, _SCORE_MAP_IMAGE_Y):
			if i % 73 == 0 || j % 73 == 0:
				data_score_map_img.set_pixel(i, j, _SCORE_MAP_LINE_COLOR)
			else:
				data_score_map_img.set_pixel(i, j, _SCORE_MAP_DEFAULT_COLOR)
	data_score_map_img.unlock()
	_update_color_map()
	_log_mgr.info("[GData] init math map.")


func _update_color_map():
	data_score_map_img.lock()
	var ii: int = -1
	var jj: int = -1
	for i in dic_game_data["mathMatrixX"]:
		ii += 1
		jj = -1
		for j in i:
			jj += 1
			if !j.empty():
				_set_map_color(ii, jj, j)
	data_score_map_img.unlock()


func print_meta_data():
	_log_mgr.info(dic_game_data)


func get_score_map_color_ratio() -> int:
	return dic_game_data["setting"]["score_map_color_ratio"]


func set_score_map_color_ratio(ratio: int):
	if ratio != dic_game_data["setting"]["score_map_color_ratio"]:
		_dirty = true
		dic_game_data["setting"]["score_map_color_ratio"] = ratio
		_update_color_map()













