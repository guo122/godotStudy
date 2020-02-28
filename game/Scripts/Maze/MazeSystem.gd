extends PanelBasic

class_name MazeSystem

enum TileType {PASS, BLOCK}

const _MAZE_HEIGHT = 17
const _MAZE_WIDTH = 17

onready var _p_texture_rect: TextureRect = $VBoxContainer/MarginContainer/ScoreList/TextureRect

var _maze_png_gen: MazePngGen = null
var _maze_list_gen: MazeListGen = null

var _maze_texture: ImageTexture = null


func _ready():
	_maze_png_gen = MazePngGen.new()
	_maze_list_gen = MazeListGen.new()
	
	_maze_list_gen.init_maze(_MAZE_WIDTH, _MAZE_HEIGHT)
	_maze_list_gen.generate_maze()
	_update_tex_rect()


func _update_tex_rect():
	_maze_png_gen.init_maze(_MAZE_WIDTH, _MAZE_HEIGHT, _maze_list_gen.get_list())
	_maze_texture = null
	_maze_texture = ImageTexture.new()
	_maze_texture.create_from_image(_maze_png_gen.maze_img)
	_p_texture_rect.set_texture(_maze_texture)


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnRefresh_pressed():
	_maze_list_gen.generate_maze()
	_update_tex_rect()


func _on_BtnTile_pressed():
	_g.panel_mgr.openPanel("MazeTile")






