extends Node

export (Array, PackedScene) var PanelSceneList

var _log_mgr: LogMgr
var _panel_mgr: PanelMgr

func _ready():
	_log_mgr = get_node("/root/LogMgr")
	_panel_mgr = get_node("/root/PanelMgr")
	_log_mgr.info("[MainScene] ready")
	_panel_mgr.setMainScene(self)
