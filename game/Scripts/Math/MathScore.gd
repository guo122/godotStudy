extends Control

var logMgr
var panelMgr

var arg_dic: Dictionary

export (PackedScene) var tips_prefab

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _panel_set_dic(dic: Dictionary):
	arg_dic = dic
	
	for i in arg_dic:
		var node = tips_prefab.instance()
		$VBoxContainer/ScoreList.add_child(node)
		node._set_data(arg_dic[i])
