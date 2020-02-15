extends Node

export (Array, PackedScene) var PanelSceneList

var logMgr
var panelMgr

func _ready():
	logMgr = get_node("/root/LogMgr")
	panelMgr = get_node("/root/PanelMgr")
	logMgr._log("[MainScene] ready")
	panelMgr.setMainScene(self)
