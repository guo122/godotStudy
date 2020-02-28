extends PanelBasic

class_name MazeTile

#onready var _p_texture_rect: TextureRect = $VBoxContainer/MarginContainer/ScoreList/TextureRect

func _ready():
	pass


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


