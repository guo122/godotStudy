extends Control

var panelMgr

var arg_dic: Dictionary

export (PackedScene) var tips_prefab

func _ready():
	panelMgr = get_node("/root/PanelMgr")


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
		node._set_data(arg_dic[i])
		$VBoxContainer/ScoreList.add_child(node)
