extends Node2D

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)
