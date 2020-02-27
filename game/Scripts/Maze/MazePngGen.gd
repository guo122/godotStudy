extends Node

class_name MazePngGen

const _MAZE_CACHE_IMAGE_NAME = "user://maze_cache.png"

const _MAZE_IMAGE_X = 658
const _MAZE_IMAGE_Y = 658
const _MAZE_IMAGE_FORMAT = Image.FORMAT_RGB8

var _dirty: bool = false

var _maze_tile_0_tex: ImageTexture = load("res://Assets/png/maze_tile_0.png")
var _maze_tile_1_tex: ImageTexture = load("res://Assets/png/maze_tile_1.png")
var _maze_tile_0_img: Image
var _maze_tile_1_img: Image

var _maze_tile_size: float

var maze_img: Image = null
var _maze_last_list: Array = []

var _max_x: int = 0
var _max_y: int = 0
var _one_x: float
var _one_y: float
var _tile_ratio: float

func _init():
	_load()
	_save()


func init_maze(x: int, y: int, list: Array):
	_max_x = x
	_max_y = y
	_one_x = float(_MAZE_IMAGE_X) / float(_max_x)
	_one_y = float(_MAZE_IMAGE_Y) / float(_max_y)
	_tile_ratio = _maze_tile_size / _one_x
	
	
	if !list.empty() && list.size() == _max_x * _max_y:
		if _maze_last_list.size() != list.size():
			_maze_last_list.clear()
			for i in range(0, list.size()):
				_maze_last_list.append(-1)
		maze_img.lock()
		_maze_tile_0_img.lock()
		_maze_tile_1_img.lock()
		var ii: int = -1
		for i in range(0, _max_x):
			for j in range(0, _max_y):
				ii += 1
				if list[ii] != _maze_last_list[ii]:
					_set_one_maze(i, j, list[ii])
					_maze_last_list[ii] = list[ii]
		maze_img.unlock()
		_maze_tile_0_img.unlock()
		_maze_tile_1_img.unlock()
	
	_save()


func _save():
	if _dirty:
		maze_img.save_png(_MAZE_CACHE_IMAGE_NAME)
		_dirty = false


func _load():
	_maze_tile_0_img = _maze_tile_0_tex.get_data()
	_maze_tile_1_img = _maze_tile_1_tex.get_data()
	_maze_tile_size = _maze_tile_0_tex.get_size().x
	
	var file = File.new()
	if file.file_exists(_MAZE_CACHE_IMAGE_NAME):
		file.open(_MAZE_CACHE_IMAGE_NAME, File.READ)
		var data = file.get_buffer(file.get_len())
		file.close()
		maze_img = Image.new()
		maze_img.load_png_from_buffer(data)
	if !maze_img:
		_init_maze_img()


func _init_maze_img():
	_dirty = true
	maze_img = null
	maze_img = Image.new()
	maze_img.create(_MAZE_IMAGE_X, _MAZE_IMAGE_Y, false, _MAZE_IMAGE_FORMAT)


func _set_one_maze(x: int, y: int, type):
	if x < _max_x && y < _max_y:
		if type == 0:
			for i in range(0, _one_x + 1):
				for j in range(0, _one_y + 1):
					maze_img.set_pixel(x * _one_x + i, y * _one_y + j, _maze_tile_0_img.get_pixel(i * _tile_ratio, j * _tile_ratio))
		elif type == 1:
			for i in range(0, _one_x + 1):
				for j in range(0, _one_y + 1):
					maze_img.set_pixel(x * _one_x + i, y * _one_y + j, _maze_tile_1_img.get_pixel(i * _tile_ratio, j * _tile_ratio))
		_dirty = true







