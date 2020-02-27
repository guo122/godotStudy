extends PanelBasic

class_name MazeSystem

enum TileType {PASS, BLOCK}

const _MAZE_HEIGHT = 15
const _MAZE_WIDTH = 15

onready var _p_texture_rect: TextureRect = $VBoxContainer/MarginContainer/ScoreList/TextureRect

var _maze_png_gen: MazePngGen = null

var _maze_texture: ImageTexture = null

var _maze_list: Array = []

func _ready():
	for i in range(0, _MAZE_HEIGHT * _MAZE_WIDTH):
		_maze_list.append(0)
	_maze_png_gen = MazePngGen.new()
	
	_generate_maze()


func _generate_maze():
	var ii: int = -1
	for i in range(0, _MAZE_WIDTH):
		for j in range(0, _MAZE_HEIGHT):
			ii += 1
			if i % 2 == 1:
				_maze_list[ii] = 0
			else:
				if j % 2 == 0:
					_maze_list[ii] = 1
				else:
					_maze_list[ii] = 0
	_update_tex_rect()


func _update_tex_rect():
	_maze_png_gen.init_maze(_MAZE_WIDTH, _MAZE_HEIGHT, _maze_list)
	_maze_texture = null
	_maze_texture = ImageTexture.new()
	_maze_texture.create_from_image(_maze_png_gen.maze_img)
	_p_texture_rect.set_texture(_maze_texture)


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)






