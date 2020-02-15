extends Control

class_name PanelBasic

var _g: Globals

func _ready():
	_g = get_node("/root/Globals")


func _panel_set_rect_size(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _panel_set_dic(dic: Dictionary):
	pass


func _panel_ready():
	pass

