extends PanelBasic

onready var ppLabel = $VBoxContainer/Menu0/Label


func _on_BtnBack_pressed():
	_g.panelMgr.closePanel_animation(self)


func _on_ScrollContainer_page_changed(page):
	if page == 0:
		ppLabel.text = "ChangeLog"
	elif page == 1:
		ppLabel.text = "Will"
