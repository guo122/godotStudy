extends Control

signal pad_pressed

enum LayoutStyle {POSITIVE, NEGATIVE}
var layoutStyle = LayoutStyle.POSITIVE

var inputStr: String
var inputDot: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	inputStr = "0"
	inputDot = false
# warning-ignore:return_value_discarded
	$HBoxContainer/Btn11.connect("pressed", self, "pad_num_pressed", ["11"])
# warning-ignore:return_value_discarded
	$HBoxContainer/Btn12.connect("pressed", self, "pad_num_pressed", ["12"])
# warning-ignore:return_value_discarded
	$HBoxContainer/Btn13.connect("pressed", self, "pad_num_pressed", ["13"])
# warning-ignore:return_value_discarded
	$HBoxContainer2/Btn21.connect("pressed", self, "pad_num_pressed", ["21"])
# warning-ignore:return_value_discarded
	$HBoxContainer2/Btn22.connect("pressed", self, "pad_num_pressed", ["22"])
# warning-ignore:return_value_discarded
	$HBoxContainer2/Btn23.connect("pressed", self, "pad_num_pressed", ["23"])
# warning-ignore:return_value_discarded
	$HBoxContainer3/Btn31.connect("pressed", self, "pad_num_pressed", ["31"])
# warning-ignore:return_value_discarded
	$HBoxContainer3/Btn32.connect("pressed", self, "pad_num_pressed", ["32"])
# warning-ignore:return_value_discarded
	$HBoxContainer3/Btn33.connect("pressed", self, "pad_num_pressed", ["33"])
# warning-ignore:return_value_discarded
	$HBoxContainer4/Btn41.connect("pressed", self, "pad_num_pressed", ["41"])
# warning-ignore:return_value_discarded
	$HBoxContainer4/Btn42.connect("pressed", self, "pad_num_pressed", ["42"])
# warning-ignore:return_value_discarded
	$HBoxContainer4/Btn43.connect("pressed", self, "pad_clear_pressed")
	
	set_style(false)


func pad_num_pressed(ss):
	var clicked_num: String
	clicked_num = get_style_num(ss)
	if inputStr == "0":
		if clicked_num != "0" && clicked_num != ".":
			inputStr = clicked_num
		elif clicked_num == ".":
			inputStr = "0."
			inputDot = true
	elif inputStr != "0" && inputStr.length() < 8:
		if clicked_num == "." && !inputDot:
			inputDot = true
			inputStr += clicked_num
		elif clicked_num != ".":
			inputStr += clicked_num
		
	emit_signal("pad_pressed", inputStr, float(inputStr))


func num_clear():
	inputStr = "0"
	inputDot = false


func pad_clear_pressed():
	num_clear()
	emit_signal("pad_pressed", inputStr, float(0))


func set_style(bStyle):
	if bStyle:
		layoutStyle = LayoutStyle.POSITIVE
	else:
		layoutStyle = LayoutStyle.NEGATIVE
		
	if layoutStyle == LayoutStyle.POSITIVE:
		$HBoxContainer/Btn11.text = "1"
		$HBoxContainer/Btn12.text = "2"
		$HBoxContainer/Btn13.text = "3"
		$HBoxContainer2/Btn21.text = "4"
		$HBoxContainer2/Btn22.text = "5"
		$HBoxContainer2/Btn23.text = "6"
		$HBoxContainer3/Btn31.text = "7"
		$HBoxContainer3/Btn32.text = "8"
		$HBoxContainer3/Btn33.text = "9"
		$HBoxContainer4/Btn41.text = "."
		$HBoxContainer4/Btn42.text = "0"
	elif layoutStyle == LayoutStyle.NEGATIVE:
		$HBoxContainer/Btn11.text = "7"
		$HBoxContainer/Btn12.text = "8"
		$HBoxContainer/Btn13.text = "9"
		$HBoxContainer2/Btn21.text = "4"
		$HBoxContainer2/Btn22.text = "5"
		$HBoxContainer2/Btn23.text = "6"
		$HBoxContainer3/Btn31.text = "1"
		$HBoxContainer3/Btn32.text = "2"
		$HBoxContainer3/Btn33.text = "3"
		$HBoxContainer4/Btn41.text = "."
		$HBoxContainer4/Btn42.text = "0"
	else:
		$HBoxContainer/Btn11.text = "7"
		$HBoxContainer/Btn12.text = "8"
		$HBoxContainer/Btn13.text = "9"
		$HBoxContainer2/Btn21.text = "4"
		$HBoxContainer2/Btn22.text = "5"
		$HBoxContainer2/Btn23.text = "6"
		$HBoxContainer3/Btn31.text = "1"
		$HBoxContainer3/Btn32.text = "2"
		$HBoxContainer3/Btn33.text = "3"
		$HBoxContainer4/Btn41.text = "."
		$HBoxContainer4/Btn42.text = "0"


func get_style_num(num: String) -> String:
	var ret: String = "0"
	if layoutStyle == LayoutStyle.POSITIVE:
		if num == "11":
			ret = "1"
		elif num == "12":
			ret = "2"
		elif num == "13":
			ret = "3"
		elif num == "21":
			ret = "4"
		elif num == "22":
			ret = "5"
		elif num == "23":
			ret = "6"
		elif num == "31":
			ret = "7"
		elif num == "32":
			ret = "8"
		elif num == "33":
			ret = "9"
		elif num == "41":
			ret = "."
		elif num == "42":
			ret = "0"
	elif layoutStyle == LayoutStyle.NEGATIVE:
		if num == "11":
			ret = "7"
		elif num == "12":
			ret = "8"
		elif num == "13":
			ret = "9"
		elif num == "21":
			ret = "4"
		elif num == "22":
			ret = "5"
		elif num == "23":
			ret = "6"
		elif num == "31":
			ret = "1"
		elif num == "32":
			ret = "2"
		elif num == "33":
			ret = "3"
		elif num == "41":
			ret = "."
		elif num == "42":
			ret = "0"
	return ret









