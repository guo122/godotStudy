extends VBoxContainer

onready var ppRect: TextureRect = $HBoxContainer/TextureRect
onready var ppSlider: Slider = $HSlider

var _g: Globals

var map_texture: ImageTexture = null

func _ready():
	_g = get_node("/root/Globals")


func _update_map():
	map_texture = null
	map_texture = ImageTexture.new()
	map_texture.create_from_image(_g.dataMgr._data_score_map_img)
	ppRect.set_texture(map_texture)
	
	var highlight_texture: ImageTexture = ImageTexture.new()
	highlight_texture.create_from_image(_g.dataMgr._data_hightlight_map)
	ppRect.material.set_shader_param("hightlight_texture", highlight_texture)
	ppRect.material.set_shader_param("color_ratio", 1)
	
	ppSlider.value = _g.dataMgr._get_score_map_color_ratio()


func _on_HSlider_value_changed(value):
	_g.dataMgr._set_score_map_color_ratio(value)
	map_texture.create_from_image(_g.dataMgr._data_score_map_img)
	ppRect.set_texture(map_texture)








