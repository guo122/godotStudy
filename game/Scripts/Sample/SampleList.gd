extends Node2D

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var panelMgr

var isParticles: bool = false
var isParticlesBoom: bool = false
var boomArray: Array

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	panelMgr.openPanel("SampleHUD", PANEL_HUD_LAYER)

func _on_BtnTextEdit_button_up():
	panelMgr.openPanel("SampleTextEdit", PANEL_NORMAL_LAYER)


func _on_BtnLineEdit_button_up():
	panelMgr.openPanel("SampleLineEdit", PANEL_NORMAL_LAYER)


func _on_BtnParticles_button_up():
	if isParticles:
		panelMgr.closePanel_name("SampleParticles")
		isParticles = false
	else:
		panelMgr.openPanel("SampleParticles", PANEL_PARTICLES_LAYER)
		isParticles = true


func _on_BtnOneBoom_button_up():
	if isParticles:
		panelMgr.closePanel_name("SampleBoom")
		isParticles = false
	else:
		panelMgr.openPanel("SampleBoom", PANEL_PARTICLES_LAYER)
		isParticles = true


func _on_BtnBoom_button_up():
	boomArray.append(panelMgr.openPanel("SampleBoom", PANEL_PARTICLES_LAYER, 10, true))
	

func _on_BtnLayerTest_button_up():
	panelMgr.openPanel("SampleLayerTest", PANEL_NORMAL_LAYER)



