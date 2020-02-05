extends Control

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _on_BtnBack_button_down():
	panelMgr.closePanel_animation(self)


func _on_BtnWill_button_down():
	panelMgr.openPanel("MiscWillLog")
