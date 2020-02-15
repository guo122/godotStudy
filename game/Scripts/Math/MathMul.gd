extends PanelBasic

onready var _ppNumCount: Label = $VBoxContainer/Menu0/NumCount
onready var _ppNinePad = $VBoxContainer/MenuNinePad/Nine

var _num1: int
var _num2: int
var _numX: String
var _inputNum: float

var _running: bool
var _local_time: float

var _score_max: int
var _score_count: int
var _score_dic: Dictionary

func _ready():
	_ppNinePad.connect("pad_pressed", self, "_on_Nine_click")
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
		_ppNumCount.text = "%.2f" % [_local_time]
		_ppNumCount.set("custom_colors/font_color", _g.dataMgr._get_color(_local_time))
	

func _on_Nine_click(ss:String, num: float):
	_inputNum = num
	$VBoxContainer/Menu2/SelfNum.text = ss
	
	if _num_check():
		_running = false
		_ppNumCount.set("custom_colors/font_color", Color(0,1,0))
		yield(get_tree().create_timer(1), "timeout")
		if _local_time < 60 && _score_dic.has(_score_count):
			var dd_array: Array = _score_dic[_score_count]
			dd_array.append(_local_time)
		_num_init()


func _num_init():
	if _score_count >= _score_max:
		_g.panelMgr.closePanel_animation(self, "close2")
		_g.panelMgr.openPanel("MathScore", PanelMgr.PANEL_LAYER.NORMAL_LAYER, _score_dic)
	
	_ppNumCount.set("custom_colors/font_color", Color(0,0,0))
	_local_time = 0
	_running = true
	_score_count += 1
	
	var a = randi() % 9 + 1
	var b = randi() % 9 + 1
	var c = randi() % 9 + 1
	var d = randi() % 9 + 1
	_num1 = a * 10 + b
	_num2 = c * 10 + d
	_numX = "x"
	
	var data_array: Array = []
	data_array.append(_num1)
	data_array.append(_num2)
	data_array.append(_numX)
	_score_dic[_score_count] = data_array
	
	_ppNinePad.num_clear()
	$VBoxContainer/Menu2/SelfNum.text = "0"
	_num_setGUI()


func _num_check() -> bool:
	if _numX == "x" && (_num1 * _num2 == int(_inputNum)):
		return true
	elif _numX == "+" && (_num1 + _num2 == int(_inputNum)):
		return true
	elif _numX == "-" && (_num1 - _num2 == int(_inputNum)):
		return true
	return false


func _num_setGUI():
	$VBoxContainer/Menu1/Num1.text = str(_num1)
	$VBoxContainer/Menu1/Num2.text = str(_num2)
	$VBoxContainer/Menu1/Numx.text = _numX
	$VBoxContainer/Menu3/Progress.text = str(_score_count) + "/" + str(_score_max)


func _on_BtnBack_pressed():
	_g.panelMgr.closePanel_animation(self)


func _on_BtnPass_pressed():
	_num_init()
