extends PanelBasic

onready var _p_label_stopwatch: Label = $VBoxContainer/Menu0/LabelStopwatch
onready var _p_nine_pad = $VBoxContainer/MenuNinePad/Nine
onready var _p_label_input = $VBoxContainer/Menu2/LabelInput
onready var _p_label_question = $VBoxContainer/Menu1/LabelQuestion
onready var _p_label_progress = $VBoxContainer/Menu3/LabelProgress

var _num_1: int
var _num_2: int
var _num_type: String
var _input_num: float

var _running: bool
var _local_time: float

var _score_max: int
var _score_count: int
var _score_dic: Dictionary

func _ready():
	_p_nine_pad.connect("signal_pad_pressed", self, "_on_Nine_click")
	randomize()
	
	_score_dic = {}
	
	_score_max = 5
	_score_count = 0
	
	_running = false
	_local_time = 0
	_num_init()


func _process(delta):
	if _running:
		_local_time += delta
		_p_label_stopwatch.text = "%.2f" % [_local_time]
		_p_label_stopwatch.set("custom_colors/font_color", _g.data_mgr.get_color(_local_time))
	

func _on_Nine_click(ss:String, num: float):
	_input_num = num
	_p_label_input.text = ss
	
	if _num_check():
		_running = false
		_p_label_stopwatch.set("custom_colors/font_color", Color(0,1,0))
		yield(get_tree().create_timer(1), "timeout")
		if _local_time < 60 && _score_dic.has(_score_count):
			var dd_array: Array = _score_dic[_score_count]
			dd_array.append(_local_time)
		_num_init()


func _num_init():
	if _score_count >= _score_max:
		_g.panel_mgr.closePanel_animation(self, "close2")
		_g.panel_mgr.openPanel("MathScore", PanelMgr.PANEL_LAYER.NORMAL, _score_dic)
	
	_p_label_stopwatch.set("custom_colors/font_color", Color(0,0,0))
	_local_time = 0
	_running = true
	_score_count += 1
	
	var a = randi() % 9 + 1
	var b = randi() % 9 + 1
	var c = randi() % 9 + 1
	var d = randi() % 9 + 1
	_num_1 = a * 10 + b
	_num_2 = c * 10 + d
	_num_type = "x"
	
	var data_array: Array = []
	data_array.append(_num_1)
	data_array.append(_num_2)
	data_array.append(_num_type)
	_score_dic[_score_count] = data_array
	
	_p_nine_pad.num_clear()
	_p_label_input.text = "0"
	_num_setGUI()


func _num_check() -> bool:
	if _num_type == "x" && (_num_1 * _num_2 == int(_input_num)):
		return true
	elif _num_type == "+" && (_num_1 + _num_2 == int(_input_num)):
		return true
	elif _num_type == "-" && (_num_1 - _num_2 == int(_input_num)):
		return true
	return false


func _num_setGUI():
	_p_label_question.text = str(_num_1) + _num_type + str(_num_2)
	_p_label_progress.text = str(_score_count) + "/" + str(_score_max)


func _on_BtnBack_pressed():
	_g.panel_mgr.closePanel_animation(self)


func _on_BtnPass_pressed():
	_num_init()
