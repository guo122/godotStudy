extends Control

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var dataMgr
var panelMgr
var logMgr

onready var ppClearData : Button = $VBoxContainer/Menu1/HBoxContainer2/BtnClearData
const CLEAR_DEFAULT_BTN_NAME = "ClearData"
const CLEAR_RESET_TIME = 1
const CLEAR_DEFAULT_STATE = 8
var local_time: float = CLEAR_RESET_TIME
var clearStage: int = CLEAR_DEFAULT_STATE

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	dataMgr = get_node("/root/GData")
	logMgr = get_node("/root/GLog")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _process(delta):
	if clearStage != CLEAR_DEFAULT_STATE:
		local_time -= delta
		if local_time < 0:
			_resetBtnClear()


func _on_BtnBack_button_down():
	panelMgr.closePanel_animation(self)


func _on_BtnLog_button_down():
	if !panelMgr.openPanel("MiscTTLog", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("MiscTTLog")


func _on_BtnClearData_button_down():
	if clearStage > 0:
		local_time = CLEAR_RESET_TIME
		clearStage -= 1
		ppClearData.text = CLEAR_DEFAULT_BTN_NAME + "[" + str(clearStage) + "]"
	else:
		dataMgr._clearData()
		yield(get_tree().create_timer(1), "timeout")
		_resetBtnClear()
		

func _resetBtnClear():
	local_time = CLEAR_RESET_TIME
	clearStage = CLEAR_DEFAULT_STATE
	ppClearData.text = CLEAR_DEFAULT_BTN_NAME


func _on_BtnPrintData_button_down():
	dataMgr._printMetaData()
