extends Node

var logMgr: LogMgr
var panelMgr: PanelMgr
var dataMgr: GData
var scoreMgr: GScore

func _ready():
	logMgr = get_node("/root/LogMgr")
	panelMgr = get_node("/root/PanelMgr")
	dataMgr = get_node("/root/GData")
	scoreMgr = get_node("/root/GScore")
	
	logMgr._log("[Globals] ready")
	


