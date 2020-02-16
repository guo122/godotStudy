extends PanelBasic


onready var _p_btn_clear_data : Button = $VBoxContainer/Menu1/HBoxContainer2/BtnClearData

const _CLEAR_DEFAULT_BTN_NAME = "ClearData"
const _CLEAR_RESET_TIME = 1
const _CLEAR_DEFAULT_STATE = 8

var _local_time: float = _CLEAR_RESET_TIME
var _clear_stage: int = _CLEAR_DEFAULT_STATE


func _process(delta):
	if _clear_stage != _CLEAR_DEFAULT_STATE:
		_local_time -= delta
		if _local_time < 0:
			_resetBtnClear()


func _resetBtnClear():
	_local_time = _CLEAR_RESET_TIME
	_clear_stage = _CLEAR_DEFAULT_STATE
	_p_btn_clear_data.text = _CLEAR_DEFAULT_BTN_NAME


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnLog_pressed():
	if !_g.panel_mgr.openPanel("MiscTTLog", PanelMgr.PANEL_LAYER.PARTICLES):
		_g.panel_mgr.closePanel_name("MiscTTLog")


func _on_BtnPrintData_pressed():
	_g.data_mgr.print_meta_data()


func _on_BtnClearData_pressed():
	if _clear_stage > 0:
		_local_time = _CLEAR_RESET_TIME
		_clear_stage -= 1
		_p_btn_clear_data.text = _CLEAR_DEFAULT_BTN_NAME + "[" + str(_clear_stage) + "]"
	else:
		_g.data_mgr.clear_data()
		yield(get_tree().create_timer(1), "timeout")
		_resetBtnClear()


func _on_BtnRefreshMathMap_pressed():
	_g.data_mgr.init_color_map()
	_g.data_mgr.save()


func _on_BtnFPS_pressed():
	if !_g.panel_mgr.openPanel("MiscFPS", PanelMgr.PANEL_LAYER.HUD):
		_g.panel_mgr.closePanel_name("MiscFPS")








