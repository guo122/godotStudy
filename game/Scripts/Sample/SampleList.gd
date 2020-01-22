extends Node2D

var panelMgr

var isParticles: bool = false
var isParticlesBoom: bool = false

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _on_BtnTextEdit_button_up():
	panelMgr.openPanel("SampleTextEdit")


func _on_BtnLineEdit_button_up():
	panelMgr.openPanel("SampleLineEdit")


func _on_BtnParticles_button_up():
	if isParticles:
		panelMgr.closePanel_name("SampleParticles")
		isParticles = false
	else:
		panelMgr.openPanel("SampleParticles")
		isParticles = true


func _on_BtnBoom_button_up():
	if isParticles:
		panelMgr.closePanel_name("SampleBoom")
		isParticles = false
	else:
		panelMgr.openPanel("SampleBoom")
		isParticles = true







