extends Node2D

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_BtnTextEdit_button_up():
	panelMgr.openPanel("SampleTextEdit")


func _on_BtnLineEdit_button_up():
	panelMgr.openPanel("SampleLineEdit")
