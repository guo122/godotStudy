extends Node2D

signal pad_pressed

var inputStr: String
var inputDot: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	inputStr = "0"
	inputDot = false
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer/Btn1.connect("button_down", self, "pad_num_pressed", ["1"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer/Btn2.connect("button_down", self, "pad_num_pressed", ["2"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer/Btn3.connect("button_down", self, "pad_num_pressed", ["3"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer2/Btn4.connect("button_down", self, "pad_num_pressed", ["4"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer2/Btn5.connect("button_down", self, "pad_num_pressed", ["5"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer2/Btn6.connect("button_down", self, "pad_num_pressed", ["6"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer3/Btn7.connect("button_down", self, "pad_num_pressed", ["7"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer3/Btn8.connect("button_down", self, "pad_num_pressed", ["8"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer3/Btn9.connect("button_down", self, "pad_num_pressed", ["9"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer4/Btn0.connect("button_down", self, "pad_num_pressed", ["0"])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer4/BtnDot.connect("button_down", self, "pad_num_pressed", ["."])
# warning-ignore:return_value_discarded
	$VBoxContainer/HBoxContainer4/BtnC.connect("button_down", self, "pad_clear_pressed")


func pad_num_pressed(ss):
	if inputStr == "0":
		if ss != "0" && ss != ".":
			inputStr = ss
		elif ss == ".":
			inputStr = "0."
			inputDot = true
	elif inputStr != "0" && inputStr.length() < 8:
		if ss == "." && !inputDot:
			inputDot = true
			inputStr += ss
		elif ss != ".":
			inputStr += ss
		
	emit_signal("pad_pressed", inputStr, float(inputStr))


func pad_clear_pressed():
	inputStr = "0"
	inputDot = false
	emit_signal("pad_pressed", inputStr, float(0))
