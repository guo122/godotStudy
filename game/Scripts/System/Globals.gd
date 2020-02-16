extends Node

var log_mgr: LogMgr
var panel_mgr: PanelMgr
var data_mgr: GData
var score_mgr: GScore

func _ready():
	log_mgr = get_node("/root/LogMgr")
	panel_mgr = get_node("/root/PanelMgr")
	data_mgr = get_node("/root/GData")
	score_mgr = get_node("/root/GScore")
	
	log_mgr.info("[Globals] ready")
	


