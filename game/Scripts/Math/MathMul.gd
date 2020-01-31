extends Node2D

var panelMgr

var num1: int
var num2: int
var numX: String
var inputNum: float

var running: bool
var local_time: float

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	$Nine.connect("pad_pressed", self, "_on_Nine_click")
	randomize()
	
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
		local_time = 0
		_num_init()


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _num_init():
	local_time = 0
	running = true
	
	var a = randi() % 9 + 1
	var b = randi() % 9 + 1
	var c = randi() % 9 + 1
	var d = randi() % 9 + 1
	num1 = a * 10 + b
	num2 = c * 10 + d
	numX = "x"
	
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






