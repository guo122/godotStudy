extends Node

export (Array, PackedScene) var PanelSceneList
var panelMgr

var root_node

func _ready():
	print_debug("mainScene ready")
	panelMgr = get_node("/root/PanelMgr")
	panelMgr.setMainScene(self)
