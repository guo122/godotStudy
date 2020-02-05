extends Node2D

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_Button_button_up():
	panelMgr.closePanel_animation(self)
