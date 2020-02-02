extends Control

var panelMgr
var logMgr

var bSwitch: bool = true
onready var ppLog: RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
onready var ppBtnSwitch: Button = $VBoxContainer/TopFixed/BtnSwitch

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	logMgr.connect("glog_update", self, "_on_log_update")
	ppLog.bbcode_text = logMgr.log_data
	ppLog.visible = false
	$BasicBg.visible = false

func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize
	ppBtnSwitch.rect_position = Vector2(596, 0)


func _on_Button_button_down():
	if ppLog.visible:
		ppLog.visible = false
		$BasicBg.visible = false
	else:
		ppLog.visible = true
		$BasicBg.visible = true


func _on_log_update(sstr):
	ppLog.bbcode_text = sstr
