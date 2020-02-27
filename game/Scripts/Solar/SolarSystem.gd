extends PanelBasic


onready var _p_texture_rect: TextureRect = $VBoxContainer/MarginContainer/ScoreList/TextureRect


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnPrevDay_pressed():
	pass # Replace with function body.


func _on_BtnNextDay_pressed():
	pass # Replace with function body.
