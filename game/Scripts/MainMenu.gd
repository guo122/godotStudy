extends Control

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize



func _on_BtnSample_button_down():
	panelMgr.openPanel("SampleList")


func _on_BtnStar_button_down():
	if !panelMgr.openPanel("SampleParticles", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("SampleParticles")


func _on_BtnMath_button_down():
	panelMgr.openPanel("MathMul")


func _on_BtnChangeLog_button_down():
	panelMgr.openPanel("MiscChangeLog")


func _on_BtnSetting_button_down():
	panelMgr.openPanel("MiscSetting")


func _on_BtnScore_button_down():
	panelMgr.openPanel("MathScoreData")
