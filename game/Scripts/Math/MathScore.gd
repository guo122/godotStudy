extends Node2D

var panelMgr

var arg_dic: Dictionary

var tips_prefab = preload("res://Scenes/Math/MathScoreOneTips.tscn")

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _panel_set_dic(dic: Dictionary):
	arg_dic = dic
	
	for i in arg_dic:
		var node = tips_prefab.instance()
		node._set_data(arg_dic[i])
		$VBoxContainer.add_child(node)
