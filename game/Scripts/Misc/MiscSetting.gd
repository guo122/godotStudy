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


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _on_BtnLog_button_down():
	if !panelMgr.openPanel("MiscTTLog", PANEL_PARTICLES_LAYER):
		panelMgr.closePanel_name("MiscTTLog")
