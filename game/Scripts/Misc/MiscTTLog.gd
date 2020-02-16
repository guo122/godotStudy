extends PanelBasic


onready var _p_basic_bg = $BasicBg
onready var _p_label_log: RichTextLabel = $VBoxContainer/MarginContainer/ScrollContainer/HBoxContainer/RichTextLabel
onready var _p_panel_setting: Control = $VBoxContainer/MarginContainer/ScrollContainer/HBoxContainer/LogSetting
onready var _p_swipe: PanelSwipe = $VBoxContainer/MarginContainer/ScrollContainer
onready var _p_btn_bg: Button = $VBoxContainer/TopFixed/BtnBg
onready var _p_btn_switch: Button = $VBoxContainer/TopFixed/BtnSwitch

enum _LogPanel {HIDDEN, ALL, TRANSPARENT}
var _style = _LogPanel.HIDDEN

func _ready():
	_g.log_mgr.connect("signal_log_update", self, "_on_log_update")
	_p_label_log.bbcode_text = _g.log_mgr.log_data()
	_set_log_panel()


func _on_log_update(sstr):
	_p_label_log.bbcode_text = sstr


func _set_log_panel():
	if _style == _LogPanel.HIDDEN:
		_p_swipe.visible = false
		_p_swipe.b_ignore_input = false
		_p_swipe.turn_left()
		_p_swipe.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_label_log.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_panel_setting.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_basic_bg.visible = false
		_p_btn_bg.visible = false
		_p_btn_switch.visible = true
		_p_btn_bg.flat = true
		_p_btn_switch.flat = true
	elif _style == _LogPanel.ALL:
		_p_swipe.visible = true
		_p_swipe.b_ignore_input = false
		_p_swipe.turn_left()
		_p_swipe.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_label_log.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_panel_setting.mouse_filter = Control.MOUSE_FILTER_STOP
		_p_basic_bg.visible = true
		_p_btn_bg.visible = true
		_p_btn_switch.visible = true
		_p_btn_bg.flat = false
		_p_btn_switch.flat = false
	elif _style == _LogPanel.TRANSPARENT:
		_p_swipe.visible = true
		_p_swipe.b_ignore_input = true
		_p_swipe.turn_left()
		_p_swipe.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_p_label_log.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_p_panel_setting.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_p_basic_bg.visible = false
		_p_btn_bg.visible = true
		_p_btn_switch.visible = false
		_p_btn_bg.flat = true
		_p_btn_switch.flat = true


func _on_BtnSwitch_pressed():
	if _style == _LogPanel.ALL:
		_style = _LogPanel.HIDDEN
	else:
		_style = _LogPanel.ALL
	_set_log_panel()


func _on_BtnBg_pressed():
	if _style == _LogPanel.ALL:
		_style = _LogPanel.TRANSPARENT
	else:
		_style = _LogPanel.ALL
	_set_log_panel()


func _on_CheckDebug_toggled(button_pressed):
	_g.log_mgr.set_debug(button_pressed)


func _on_CheckWarning_toggled(button_pressed):
	_g.log_mgr.set_warning(button_pressed)


func _on_CheckError_toggled(button_pressed):
	_g.log_mgr.set_error(button_pressed)


func _on_BtnClear_pressed():
	_g.log_mgr.clear()
