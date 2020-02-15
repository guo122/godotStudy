extends PanelBasic

onready var ppList: VBoxContainer = $VBoxContainer/MarginContainer/ScrollContainer/ScoreList
onready var ppAverage: Label = $VBoxContainer/Menu0/LabelAverage
onready var ppMap = $VBoxContainer/MarginContainer/ScrollContainer/ScoreList/MathMulMap

var arg_dic: Dictionary

export (PackedScene) var tips_prefab


func _panel_set_dic(dic: Dictionary):
	arg_dic = dic
	_g.dataMgr._clear_hightlight_color()
	var score_sum: float = 0
	var score_num: int = 0
	for i in arg_dic:
		var node = tips_prefab.instance()
		ppList.add_child(node)
		node._set_data(arg_dic[i])
		if arg_dic[i].size() == 4:
			_g.dataMgr._set_highlight_color(arg_dic[i][0] - 11, arg_dic[i][1] - 11)
			score_sum += arg_dic[i][3]
			score_num += 1
	
	if score_num > 0:
		ppAverage.text = "%.2f" % [score_sum / score_num] + "s"
	else:
		ppAverage.text = "0.00s"
	_g.dataMgr._save()
	
	ppMap._update_map()
	
	var richLabelSummary = RichTextLabel.new()
	ppList.add_child(richLabelSummary)
	var score_dic = _g.scoreMgr._get_score_data()
	richLabelSummary.add_font_override("normal_font", load("res://Fonts/Text33.tres"))
	richLabelSummary.add_color_override("default_color", Color(0, 0, 0))
	richLabelSummary.mouse_filter = Control.MOUSE_FILTER_PASS
	richLabelSummary.text = "\n" + score_dic["summary"]
	ToolsMisc._RichLabelAdjustHeight(richLabelSummary, 50)


func _on_BtnBack_pressed():
	_g.dataMgr._save()
	_g.panelMgr.closePanel_animation(self)


func _on_BtnNext_pressed():
	_g.dataMgr._save()
	_g.panelMgr.closePanel_animation(self, "close2")
	_g.panelMgr.openPanel("MathMul")



