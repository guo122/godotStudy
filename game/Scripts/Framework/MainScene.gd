extends Node

export (Array, PackedScene) var PanelSceneList
var panelMgr

func _ready():
	print_debug("mainScene ready")
	panelMgr = get_node("/root/PanelMgr")
	panelMgr.setMainScene(self)
