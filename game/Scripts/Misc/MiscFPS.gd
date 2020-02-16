extends PanelBasic

onready var _p_label_fps: Label = $VBoxContainer/Menu0/LabelFPS

func _process(delta):
	_p_label_fps.text = str(Engine.get_frames_per_second())
