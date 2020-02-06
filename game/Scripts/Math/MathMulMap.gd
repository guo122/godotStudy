extends VBoxContainer

onready var ppRect: TextureRect = $HBoxContainer/TextureRect

var logMgr
var dataMgr

func _ready():
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")


func _update_map():
	var map_texture: ImageTexture = ImageTexture.new()
	map_texture.create_from_image(dataMgr._data_color_image)
	ppRect.set_texture(map_texture)
	
	var highlight_texture: ImageTexture = ImageTexture.new()
	highlight_texture.create_from_image(dataMgr._data_hightlight_map)
	ppRect.material.set_shader_param("hightlight_texture", highlight_texture)


func _set_color_ratio(rr: float):
	ppRect.material.set_shader_param("color_ratio", rr / 100)





