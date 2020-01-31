extends Node2D

var panelMgr
var globals

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

var num1: int
var num2: int
var numX: String
var inputNum: float

var running: bool
var local_time: float

var score_max: int
var score_count: int
var score_dic: Dictionary

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	globals = get_node("/root/Globals")
	$Nine.set_style(globals.NinePadPositiveLayoutStyle)
	$Nine.connect("pad_pressed", self, "_on_Nine_click")
	randomize()
	
	score_max = 5
	score_count = 0
	
	running = false
	local_time = 0
	_num_init()


func _process(delta):
	if running:
		local_time += delta
		$NumCount.text = str(local_time).left(4)
	

func _on_Nine_click(ss:String, num: float):
	inputNum = num
	$ColorRect2/SelfNum.text = ss
	
	if _num_check():
		running = false
		yield(get_tree().create_timer(1), "timeout")
		if score_dic.has(score_count):
			var dd_array: Array = score_dic[score_count]
			dd_array.append(local_time)
		_num_init()


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _num_init():
	if score_count >= score_max:
		panelMgr.closePanel(self)
		panelMgr.openPanel("MathScore", PANEL_NORMAL_LAYER, score_dic)
	
	local_time = 0
	running = true
	score_count += 1
	
	var a = randi() % 9 + 1
	var b = randi() % 9 + 1
	var c = randi() % 9 + 1
	var d = randi() % 9 + 1
	num1 = a * 10 + b
	num2 = c * 10 + d
	numX = "x"
	
	var data_array: Array
	data_array.append(num1)
	data_array.append(num2)
	data_array.append(numX)
	score_dic[score_count] = data_array
	
	$Nine.num_clear()
	$ColorRect2/SelfNum.text = "0"
	_num_setGUI()


func _num_check() -> bool:
	if numX == "x" && (num1 * num2 == int(inputNum)):
		return true
	elif numX == "+" && (num1 + num2 == int(inputNum)):
		return true
	elif numX == "-" && (num1 - num2 == int(inputNum)):
		return true
	return false


func _num_setGUI():
	$Num1.text = str(num1)
	$Num2.text = str(num2)
	$Numx.text = numX
	$Progress.text = str(score_count) + "/" + str(score_max)


func _on_BtnRefresh_button_down():
	_num_init()








