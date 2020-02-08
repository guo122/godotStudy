extends Control

var panelMgr
var logMgr
var dataMgr
var scoreMgr

onready var ppLabelSummary: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/LabelSummary
onready var ppLabelDatetime: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelDatetime
onready var ppLabelList: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelList
onready var ppMap: TextureRect = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/MathMulMap
onready var ppBtnLeft: Button = $VBoxContainer/Menu0/BtnLeft
onready var ppBtnRight: Button = $VBoxContainer/Menu0/BtnRight
onready var ppSwipe: PanelSwipe = $VBoxContainer/MarginContainer/Swipe

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")
	scoreMgr = get_node("/root/GScore")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize
	
	dataMgr._clear_hightlight_color()
	ppMap._update_map()
	_set_text()


func _set_text():
	var dic = scoreMgr._get_score_data()
	ppLabelSummary.bbcode_text = dic["summary"]
	ToolsMisc._RichLabelAdjustHeight(ppLabelSummary)
	ppLabelDatetime.bbcode_text = dic["datetime"]
	ppLabelList.bbcode_text = dic["list"]


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)











