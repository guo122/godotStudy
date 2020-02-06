extends Control

var dataMgr
var panelMgr
var globals

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3

onready var ppNumCount = $VBoxContainer/Menu0/NumCount

var num1: int
var num2: int
var numX: String
var inputNum: float

var running: bool
var local_time: float

var score_max: int
var score_count: int
var score_dic: Dictionary
var lastColor: Color = Color(0, 0, 0)

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	dataMgr = get_node("/root/GData")
	globals = get_node("/root/Globals")
	$VBoxContainer/MenuNinePad/Nine.set_style(globals.NinePadPositiveLayoutStyle)
	$VBoxContainer/MenuNinePad/Nine.connect("pad_pressed", self, "_on_Nine_click")
	randomize()
	
	score_dic = {}
	
	score_max = 5
	score_count = 0
	
	running = false
	local_time = 0
	_num_init()


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize


func _process(delta):
	if running:
		local_time += delta
		ppNumCount.text = "%.2f" % [local_time]
		var cc = dataMgr._get_color(local_time)
		if cc != lastColor:
			lastColor = cc
			ppNumCount.set("custom_colors/font_color", cc)
	

func _on_Nine_click(ss:String, num: float):
	inputNum = num
	$VBoxContainer/Menu2/SelfNum.text = ss
	
	if _num_check():
		running = false
		ppNumCount.set("custom_colors/font_color", Color(0,1,0))
		yield(get_tree().create_timer(1), "timeout")
		if local_time < 60 && score_dic.has(score_count):
			var dd_array: Array = score_dic[score_count]
			dd_array.append(local_time)
		_num_init()


func _num_init():
	if score_count >= score_max:
		panelMgr.closePanel_animation(self, "close2")
		panelMgr.openPanel("MathScore", PANEL_NORMAL_LAYER, score_dic)
	
	ppNumCount.set("custom_colors/font_color", Color(0,0,0))
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
	
	var data_array: Array = []
	data_array.append(num1)
	data_array.append(num2)
	data_array.append(numX)
	score_dic[score_count] = data_array
	
	$VBoxContainer/MenuNinePad/Nine.num_clear()
	$VBoxContainer/Menu2/SelfNum.text = "0"
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
	$VBoxContainer/Menu1/Num1.text = str(num1)
	$VBoxContainer/Menu1/Num2.text = str(num2)
	$VBoxContainer/Menu1/Numx.text = numX
	$VBoxContainer/Menu3/Progress.text = str(score_count) + "/" + str(score_max)


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)


func _on_BtnPass_pressed():
	_num_init()
