extends PanelBasic

onready var _ppLabelFPS: Label = $VBoxContainer/Menu0/LabelFPS

func _process(delta):
	_ppLabelFPS.text = str(Engine.get_frames_per_second())
