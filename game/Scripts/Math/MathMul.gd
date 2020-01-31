extends Node2D

var panelMgr

var inputNum: float

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	$Nine.connect("pad_pressed", self, "_on_Nine_click")


func _on_Nine_click(ss:String, num: float):
	inputNum = num
	$ColorRect2/SelfNum.text = ss


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)
