extends Control

var _dataMgr: GData
var _logMgr: LogMgr
var _panelMgr: PanelMgr
var _scoreMgr: GScore
var _globals: Globals

func _ready():
	_panelMgr = get_node("/root/PanelMgr")
	_logMgr = get_node("/root/LogMgr")
	_dataMgr = get_node("/root/GData")
	_scoreMgr = get_node("/root/GScore")
	_globals = get_node("/root/Globals")


func _panel_set_dic(dic: Dictionary):
	pass
	

func _panel_set_rect_size(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _panel_ready():
	pass
