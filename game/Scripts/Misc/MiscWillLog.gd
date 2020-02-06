extends Control

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize
	

func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)
