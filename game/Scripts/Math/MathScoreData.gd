extends PanelBasic


onready var ppLabelSummary: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/LabelSummary
onready var ppLabelDatetime: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelDatetime
onready var ppLabelList: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelList
onready var ppMap: TextureRect = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/MathMulMap
onready var ppSwipe: PanelSwipe = $VBoxContainer/MarginContainer/Swipe


func _panel_ready():
	_g.dataMgr._clear_hightlight_color()
	ppMap._update_map()
	_set_text()


func _set_text():
	var dic = _g.scoreMgr._get_score_data()
	ppLabelSummary.bbcode_text = dic["summary"]
	ToolsMisc._RichLabelAdjustHeight(ppLabelSummary)
	ppLabelDatetime.bbcode_text = dic["datetime"]
	ppLabelList.bbcode_text = dic["list"]


func _on_BtnBack_pressed():
	_g.dataMgr._save()
	_g.panelMgr.closePanel_animation(self)











