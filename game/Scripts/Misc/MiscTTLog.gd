extends Control

var panelMgr: PanelMgr
var logMgr: GLog

var bSwitch: bool = true
onready var ppLog: RichTextLabel = $VBoxContainer/MarginContainer/ScrollContainer/HBoxContainer/RichTextLabel
onready var ppSetting: Control = $VBoxContainer/MarginContainer/ScrollContainer/HBoxContainer/LogSetting
onready var ppSwipe: PanelSwipe = $VBoxContainer/MarginContainer/ScrollContainer
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
		ppSwipe.visible = false
		ppSwipe._ignore = false
		ppSwipe._turn_left()
		ppSwipe.mouse_filter = Control.MOUSE_FILTER_STOP
		ppLog.mouse_filter = Control.MOUSE_FILTER_STOP
		ppSetting.mouse_filter = Control.MOUSE_FILTER_STOP
		$BasicBg.visible = false
		ppBtnBg.visible = false
		ppBtnSwitch.visible = true
		ppBtnBg.flat = true
		ppBtnSwitch.flat = true
	elif style == LogPanel.ALL:
		ppSwipe.visible = true
		ppSwipe._ignore = false
		ppSwipe._turn_left()
		ppSwipe.mouse_filter = Control.MOUSE_FILTER_STOP
		ppLog.mouse_filter = Control.MOUSE_FILTER_STOP
		ppSetting.mouse_filter = Control.MOUSE_FILTER_STOP
		$BasicBg.visible = true
		ppBtnBg.visible = true
		ppBtnSwitch.visible = true
		ppBtnBg.flat = false
		ppBtnSwitch.flat = false
	elif style == LogPanel.TRANSPARENT:
		ppSwipe.visible = true
		ppSwipe._ignore = true
		ppSwipe._turn_left()
		ppSwipe.mouse_filter = Control.MOUSE_FILTER_IGNORE
		ppLog.mouse_filter = Control.MOUSE_FILTER_IGNORE
		ppSetting.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$BasicBg.visible = false
		ppBtnBg.visible = true
		ppBtnSwitch.visible = false
		ppBtnBg.flat = true
		ppBtnSwitch.flat = true


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


func _on_CheckDebug_toggled(button_pressed):
	logMgr._set_debug(button_pressed)


func _on_CheckWarning_toggled(button_pressed):
	logMgr._set_warning(button_pressed)


func _on_CheckError_toggled(button_pressed):
	logMgr._set_error(button_pressed)


func _on_BtnClear_pressed():
	logMgr._clear()
