extends Node

export (Array, PackedScene) var PanelSceneList
var panelMgr
var logMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	logMgr._log("mainScene ready")
	panelMgr.setMainScene(self)
