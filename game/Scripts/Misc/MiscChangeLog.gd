extends Control

onready var ppLabel = $VBoxContainer/Menu0/Label

var panelMgr

func _ready():
	panelMgr = get_node("/root/PanelMgr")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)


func _on_ScrollContainer_page_changed(page):
	if page == 0:
		ppLabel.text = "ChangeLog"
	elif page == 1:
		ppLabel.text = "Will"
