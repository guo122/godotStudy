extends VBoxContainer

class_name MathMulMap

onready var _p_texture_rect: TextureRect = $HBoxContainer/TextureRect
onready var _p_slider: Slider = $HSlider

var _g: Globals

var _map_texture: ImageTexture = null

func _ready():
	_g = get_node("/root/Globals")


func _update_map():
	_map_texture = null
	_map_texture = ImageTexture.new()
	_map_texture.create_from_image(_g.data_mgr.data_score_map_img)
	_p_texture_rect.set_texture(_map_texture)
	
	var highlight_texture: ImageTexture = ImageTexture.new()
	highlight_texture.create_from_image(_g.data_mgr.data_hightlight_map)
	_p_texture_rect.material.set_shader_param("hightlight_texture", highlight_texture)
	_p_texture_rect.material.set_shader_param("color_ratio", 1)
	
	_p_slider.value = _g.data_mgr.get_score_map_color_ratio()


func _on_HSlider_value_changed(value):
	_g.data_mgr.set_score_map_color_ratio(value)
	_map_texture.create_from_image(_g.data_mgr.data_score_map_img)
	_p_texture_rect.set_texture(_map_texture)








