extends Node2D

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	panelMgr.openPanel("SampleHUD", PANEL_HUD_LAYER)

func _on_BtnTextEdit_button_up():
	panelMgr.openPanel("SampleTextEdit", PANEL_NORMAL_LAYER)


func _on_BtnLineEdit_button_up():
	panelMgr.openPanel("SampleLineEdit", PANEL_NORMAL_LAYER)


func _on_BtnParticles_button_up():
	if !panelMgr.openPanel("SampleParticles", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("SampleParticles")


func _on_BtnOneBoom_button_up():
	if !panelMgr.openPanel("SampleBoom", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("SampleBoom")


func _on_BtnBoom_button_up():
	panelMgr.openPanel("SampleBoom", PANEL_PARTICLES_LAYER, 10, true)
	

func _on_BtnLayerTest_button_up():
	panelMgr.openPanel("SampleLayerTest", PANEL_NORMAL_LAYER)


func _on_BtnBack_button_up():
	panelMgr.closePanel_name("SampleHUD")
	panelMgr.closePanel(self)
