extends VBoxContainer

onready var ppRect: TextureRect = $HBoxContainer/TextureRect

var logMgr: GLog
var dataMgr: GData

var map_texture: ImageTexture = null

func _ready():
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")


func _update_map():
	map_texture = null
	map_texture = ImageTexture.new()
	dataMgr._rgb_ratio = 1
	dataMgr._update_color_map()
	map_texture.create_from_image(dataMgr._data_score_map_img)
	ppRect.set_texture(map_texture)
	
	var highlight_texture: ImageTexture = ImageTexture.new()
	highlight_texture.create_from_image(dataMgr._data_hightlight_map)
	ppRect.material.set_shader_param("hightlight_texture", highlight_texture)
	ppRect.material.set_shader_param("color_ratio", 1)


func _on_HSlider_value_changed(value):
	dataMgr._rgb_ratio = 6 - value / 20
	dataMgr._update_color_map()
	map_texture.create_from_image(dataMgr._data_score_map_img)
	ppRect.set_texture(map_texture)
#	ppRect.material.set_shader_param("color_ratio", value / 100)








