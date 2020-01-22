extends Node

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_BtnSample_button_down():
	panelMgr.openPanel("SampleList", PANEL_NORMAL_LAYER)


func _on_BtnStar_button_down():
	if !panelMgr.openPanel("SampleParticles", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("SampleParticles")
