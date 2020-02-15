extends PanelBasic


onready var ppClearData : Button = $VBoxContainer/Menu1/HBoxContainer2/BtnClearData

const CLEAR_DEFAULT_BTN_NAME = "ClearData"
const CLEAR_RESET_TIME = 1
const CLEAR_DEFAULT_STATE = 8

var local_time: float = CLEAR_RESET_TIME
var clearStage: int = CLEAR_DEFAULT_STATE


func _process(delta):
	if clearStage != CLEAR_DEFAULT_STATE:
		local_time -= delta
		if local_time < 0:
			_resetBtnClear()


func _resetBtnClear():
	local_time = CLEAR_RESET_TIME
	clearStage = CLEAR_DEFAULT_STATE
	ppClearData.text = CLEAR_DEFAULT_BTN_NAME


func _on_BtnBack_pressed():
	_g.panelMgr.closePanel_animation(self)


func _on_BtnLog_pressed():
	if !_g.panelMgr.openPanel("MiscTTLog", PanelMgr.PANEL_LAYER.PARTICLES_LAYER):
		_g.panelMgr.closePanel_name("MiscTTLog")


func _on_BtnPrintData_pressed():
	_g.dataMgr._printMetaData()


func _on_BtnClearData_pressed():
	if clearStage > 0:
		local_time = CLEAR_RESET_TIME
		clearStage -= 1
		ppClearData.text = CLEAR_DEFAULT_BTN_NAME + "[" + str(clearStage) + "]"
	else:
		_g.dataMgr._clearData()
		yield(get_tree().create_timer(1), "timeout")
		_resetBtnClear()


func _on_BtnRefreshMathMap_pressed():
	_g.dataMgr._init_color_map()
	_g.dataMgr._save()


func _on_BtnFPS_pressed():
	if !_g.panelMgr.openPanel("MiscFPS", PanelMgr.PANEL_LAYER.HUD_LAYER):
		_g.panelMgr.closePanel_name("MiscFPS")








