extends Control

var panelMgr
var logMgr

var bSwitch: bool = true
onready var ppLog: RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
onready var ppBtnBg: Button = $VBoxContainer/TopFixed/BtnBg
onready var ppBtnSwitch: Button = $VBoxContainer/TopFixed/BtnSwitch

enum LogPanel {HIDDEN, ALL, TRANSPARENT}
var style = LogPanel.HIDDEN

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	logMgr.connect("glog_update", self, "_on_log_update")
	ppLog.bbcode_text = logMgr.log_data
	_set_log_panel()


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _on_log_update(sstr):
	ppLog.bbcode_text = sstr


func _set_log_panel():
	if style == LogPanel.HIDDEN:
		ppLog.visible = false
		ppLog.mouse_filter = Control.MOUSE_FILTER_STOP
		$BasicBg.visible = false
		ppBtnBg.visible = false
		ppBtnSwitch.visible = true
	elif style == LogPanel.ALL:
		ppLog.visible = true
		ppLog.mouse_filter = Control.MOUSE_FILTER_STOP
		$BasicBg.visible = true
		ppBtnBg.visible = true
		ppBtnSwitch.visible = true
	elif style == LogPanel.TRANSPARENT:
		ppLog.visible = true
		ppLog.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$BasicBg.visible = false
		ppBtnBg.visible = true
		ppBtnSwitch.visible = false


func _on_BtnSwitch_pressed():
	if style == LogPanel.ALL:
		style = LogPanel.HIDDEN
	else:
		style = LogPanel.ALL
	_set_log_panel()


func _on_BtnBg_pressed():
	if style == LogPanel.ALL:
		style = LogPanel.TRANSPARENT
	else:
		style = LogPanel.ALL
	_set_log_panel()






