extends Node2D

var panelMgr

var selfStr: String

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_Nine_click(num: String):
	selfStr += num


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)
