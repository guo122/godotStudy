extends PanelBasic

onready var _p_list: VBoxContainer = $VBoxContainer/MarginContainer/ScrollContainer/ScoreList
onready var _p_label_average: Label = $VBoxContainer/Menu0/LabelAverage
onready var _p_map: MathMulMap = $VBoxContainer/MarginContainer/ScrollContainer/ScoreList/MathMulMap

export (PackedScene) var tips_prefab

func _panel_set_dic(dic: Dictionary):
	_g.data_mgr.clear_hightlight_color()
	var score_sum: float = 0
	var score_num: int = 0
	for i in dic:
		var node = tips_prefab.instance()
		_p_list.add_child(node)
		node.set_data(dic[i])
		if dic[i].size() == 4:
			_g.data_mgr.set_highlight_color(dic[i][0] - 11, dic[i][1] - 11)
			score_sum += dic[i][3]
			score_num += 1
	
	if score_num > 0:
		_p_label_average.text = "%.2f" % [score_sum / score_num] + "s"
	else:
		_p_label_average.text = "0.00s"
	_g.data_mgr.save()
	
	_p_map._update_map()
	
	var richLabelSummary = RichTextLabel.new()
	_p_list.add_child(richLabelSummary)
	var score_dic = _g.score_mgr.get_score_data()
	richLabelSummary.add_font_override("normal_font", load("res://Fonts/Text33.tres"))
	richLabelSummary.add_color_override("default_color", Color(0, 0, 0))
	richLabelSummary.mouse_filter = Control.MOUSE_FILTER_PASS
	richLabelSummary.text = "\n" + score_dic["summary"]
	ToolsMisc.rich_label_adjust_height(richLabelSummary, 50)


func _on_BtnBack_pressed():
	_g.data_mgr.save()
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnNext_pressed():
	_g.data_mgr.save()
	_g.panel_mgr.closePanel_animation(self, "close2")
	_g.panel_mgr.openPanel("MathMul")



