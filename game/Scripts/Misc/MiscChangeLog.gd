extends PanelBasic

onready var _p_label = $VBoxContainer/Menu0/Label


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_ScrollContainer_page_changed(page):
	if page == 0:
		_p_label.text = "ChangeLog"
	elif page == 1:
		_p_label.text = "Will"
