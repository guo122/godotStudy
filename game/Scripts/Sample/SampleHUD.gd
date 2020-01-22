extends Node2D

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _process(delta):
	$FPS_Label.text = "FPS: " + str(Engine.get_frames_per_second())
