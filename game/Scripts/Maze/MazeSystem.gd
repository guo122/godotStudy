extends PanelBasic

class_name MazeSystem

enum TileType {PASS, BLOCK}

const _MAZE_HEIGHT = 17
const _MAZE_WIDTH = 17

onready var _p_texture_rect: TextureRect = $VBoxContainer/MarginContainer/ScoreList/TextureRect

var _maze_png_gen: MazePngGen = null

var _maze_texture: ImageTexture = null

var _maze_list: Array = []

func _ready():
	randomize()
	_maze_list.resize(_MAZE_WIDTH * _MAZE_HEIGHT)
	_init_tree()
	
	_maze_png_gen = MazePngGen.new()
	
	_generate_maze()


func _generate_maze():
	_init_tree()
	
	for i in range(0, _MAZE_WIDTH):
		for j in range(0, _MAZE_HEIGHT):
			if i % 2 == 1 && i != _MAZE_WIDTH - 1:
				if j % 2 == 1 && j != _MAZE_HEIGHT - 1:
					var rr = randi() % 4
					if rr == 0:
						_set_one_tree(i - 1, j, 1)
					elif rr == 1:
						_set_one_tree(i + 1, j, 1)
					elif rr == 2:
						_set_one_tree(i, j - 1, 1)
					else:
						_set_one_tree(i, j + 1, 1)
	_update_tex_rect()


func _set_one_tree(x: int, y: int, val: int):
	if x < _MAZE_WIDTH - 1 && y < _MAZE_HEIGHT - 1 && x > 0 && y > 0:
		_maze_list[x * _MAZE_HEIGHT + y] = val


func _init_tree():
	var ii: int = -1
	for i in range(0, _MAZE_WIDTH):
		for j in range(0, _MAZE_HEIGHT):
			ii += 1
			if i % 2 == 0 || (i % 2 == 1 && i == _MAZE_WIDTH - 1):
				_maze_list[ii] = 0
			else:
				if j % 2 == 1 && j != _MAZE_HEIGHT - 1:
					_maze_list[ii] = 1
				else:
					_maze_list[ii] = 0


func _update_tex_rect():
	_maze_png_gen.init_maze(_MAZE_WIDTH, _MAZE_HEIGHT, _maze_list)
	_maze_texture = null
	_maze_texture = ImageTexture.new()
	_maze_texture.create_from_image(_maze_png_gen.maze_img)
	_p_texture_rect.set_texture(_maze_texture)


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnRefresh_pressed():
	_generate_maze()






