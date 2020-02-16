extends Control

class_name MathNinePad

signal signal_pad_pressed

onready var _p_btn_11: Button = $HBoxContainer/Btn11
onready var _p_btn_12: Button = $HBoxContainer/Btn12
onready var _p_btn_13: Button = $HBoxContainer/Btn13
onready var _p_btn_21: Button = $HBoxContainer2/Btn21
onready var _p_btn_22: Button = $HBoxContainer2/Btn22
onready var _p_btn_23: Button = $HBoxContainer2/Btn23
onready var _p_btn_31: Button = $HBoxContainer3/Btn31
onready var _p_btn_32: Button = $HBoxContainer3/Btn32
onready var _p_btn_33: Button = $HBoxContainer3/Btn33
onready var _p_btn_41: Button = $HBoxContainer4/Btn41
onready var _p_btn_42: Button = $HBoxContainer4/Btn42
onready var _p_btn_43: Button = $HBoxContainer4/Btn43

enum _LayoutStyle {POSITIVE, NEGATIVE}
var _layoutStyle = _LayoutStyle.POSITIVE

var _input_str: String
var _input_dot: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	_input_str = "0"
	_input_dot = false
# warning-ignore:return_value_discarded
	_p_btn_11.connect("pressed", self, "pad_num_pressed", ["11"])
# warning-ignore:return_value_discarded
	_p_btn_12.connect("pressed", self, "pad_num_pressed", ["12"])
# warning-ignore:return_value_discarded
	_p_btn_13.connect("pressed", self, "pad_num_pressed", ["13"])
# warning-ignore:return_value_discarded
	_p_btn_21.connect("pressed", self, "pad_num_pressed", ["21"])
# warning-ignore:return_value_discarded
	_p_btn_22.connect("pressed", self, "pad_num_pressed", ["22"])
# warning-ignore:return_value_discarded
	_p_btn_23.connect("pressed", self, "pad_num_pressed", ["23"])
# warning-ignore:return_value_discarded
	_p_btn_31.connect("pressed", self, "pad_num_pressed", ["31"])
# warning-ignore:return_value_discarded
	_p_btn_32.connect("pressed", self, "pad_num_pressed", ["32"])
# warning-ignore:return_value_discarded
	_p_btn_33.connect("pressed", self, "pad_num_pressed", ["33"])
# warning-ignore:return_value_discarded
	_p_btn_41.connect("pressed", self, "pad_num_pressed", ["41"])
# warning-ignore:return_value_discarded
	_p_btn_42.connect("pressed", self, "pad_num_pressed", ["42"])
# warning-ignore:return_value_discarded
	_p_btn_43.connect("pressed", self, "pad_clear_pressed")
	
	set_style(false)


func pad_num_pressed(ss):
	var clicked_num: String
	clicked_num = get_style_num(ss)
	if _input_str == "0":
		if clicked_num != "0" && clicked_num != ".":
			_input_str = clicked_num
		elif clicked_num == ".":
			_input_str = "0."
			_input_dot = true
	elif _input_str != "0" && _input_str.length() < 8:
		if clicked_num == "." && !_input_dot:
			_input_dot = true
			_input_str += clicked_num
		elif clicked_num != ".":
			_input_str += clicked_num
		
	emit_signal("signal_pad_pressed", _input_str, float(_input_str))


func num_clear():
	_input_str = "0"
	_input_dot = false


func pad_clear_pressed():
	num_clear()
	emit_signal("signal_pad_pressed", _input_str, float(0))


func set_style(bStyle):
	if bStyle:
		_layoutStyle = _LayoutStyle.POSITIVE
	else:
		_layoutStyle = _LayoutStyle.NEGATIVE
		
	if _layoutStyle == _LayoutStyle.POSITIVE:
		_p_btn_11.text = "1"
		_p_btn_12.text = "2"
		_p_btn_13.text = "3"
		_p_btn_21.text = "4"
		_p_btn_22.text = "5"
		_p_btn_23.text = "6"
		_p_btn_31.text = "7"
		_p_btn_32.text = "8"
		_p_btn_33.text = "9"
		_p_btn_41.text = "."
		_p_btn_42.text = "0"
	elif _layoutStyle == _LayoutStyle.NEGATIVE:
		_p_btn_11.text = "7"
		_p_btn_12.text = "8"
		_p_btn_13.text = "9"
		_p_btn_21.text = "4"
		_p_btn_22.text = "5"
		_p_btn_23.text = "6"
		_p_btn_31.text = "1"
		_p_btn_32.text = "2"
		_p_btn_33.text = "3"
		_p_btn_41.text = "."
		_p_btn_42.text = "0"
	else:
		_p_btn_11.text = "7"
		_p_btn_12.text = "8"
		_p_btn_13.text = "9"
		_p_btn_21.text = "4"
		_p_btn_22.text = "5"
		_p_btn_23.text = "6"
		_p_btn_31.text = "1"
		_p_btn_32.text = "2"
		_p_btn_33.text = "3"
		_p_btn_41.text = "."
		_p_btn_42.text = "0"


func get_style_num(num: String) -> String:
	var ret: String = "0"
	if _layoutStyle == _LayoutStyle.POSITIVE:
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
	elif _layoutStyle == _LayoutStyle.NEGATIVE:
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









