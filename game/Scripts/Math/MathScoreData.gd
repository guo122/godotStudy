extends PanelBasic


onready var _p_label_summary: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/LabelSummary
onready var _p_label_datetime: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelDatetime
onready var _p_label_list: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelList
onready var _p_map: MathMulMap = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/MathMulMap
onready var _p_swipe: PanelSwipe = $VBoxContainer/MarginContainer/Swipe


func _panel_ready():
	_g.data_mgr.clear_hightlight_color()
	_p_map._update_map()
	_set_text()


func _set_text():
	var dic = _g.score_mgr.get_score_data()
	_p_label_summary.bbcode_text = dic["summary"]
	ToolsMisc.rich_label_adjust_height(_p_label_summary)
	_p_label_datetime.bbcode_text = dic["datetime"]
	_p_label_list.bbcode_text = dic["list"]


func _on_BtnBack_pressed():
	_g.data_mgr.save()
	_g.panel_mgr.closePanel_animation(self)











