extends Control

var _log_mgr: LogMgr
var _panel_mgr: PanelMgr
var _data_mgr: GData
var _score_mgr: GScore
var _globals: Globals

func _ready():
	_panel_mgr = get_node("/root/PanelMgr")
	_log_mgr = get_node("/root/LogMgr")
	_data_mgr = get_node("/root/GData")
	_score_mgr = get_node("/root/GScore")
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
