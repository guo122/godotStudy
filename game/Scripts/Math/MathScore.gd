extends Control

var dataMgr
var logMgr
var panelMgr

onready var ppList: VBoxContainer = $VBoxContainer/ScrollContainer/ScoreList
onready var ppAverage: Label = $VBoxContainer/Menu0/LabelAverage
onready var ppMap = $VBoxContainer/ScrollContainer/ScoreList/MathMulMap

var arg_dic: Dictionary

export (PackedScene) var tips_prefab

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _panel_set_dic(dic: Dictionary):
	arg_dic = dic
	dataMgr._clear_hightlight_color()
	var score_sum: float = 0
	var score_num: int = 0
	for i in arg_dic:
		var node = tips_prefab.instance()
		ppList.add_child(node)
		node._set_data(arg_dic[i])
		if arg_dic[i].size() == 4:
			dataMgr._set_highlight_color(arg_dic[i][0] - 11, arg_dic[i][1] - 11)
			score_sum += arg_dic[i][3]
			score_num += 1
	
	if score_num > 0:
		ppAverage.text = "%.2f" % [score_sum / score_num] + "s"
	else:
		ppAverage.text = "0.00s"
	dataMgr._save()
	
	ppMap._update_map()


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)
