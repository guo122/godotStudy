extends Control

var panelMgr
var logMgr
var dataMgr

onready var ppLabel: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/RichTextLabel
onready var ppMap: TextureRect = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/MathMulMap
onready var ppBtnLeft: Button = $VBoxContainer/Menu0/BtnLeft
onready var ppBtnRight: Button = $VBoxContainer/Menu0/BtnRight
onready var ppSwipe: PanelSwipe = $VBoxContainer/MarginContainer/Swipe

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize
	
	dataMgr._clear_hightlight_color()
	ppMap._update_map()
	_set_text()


func _set_text():
	var sum_score: float = 0
	var sum_count: int = 0
	var sum_1x: int = 0
	var sum_2x: int = 0
	var sum_3x: int = 0
	var sum_4x: int = 0
	var sum_5x: int = 0
	var ii: int = 10
	var jj: int = 10
	var str_data = ""
	for i in dataMgr._data["mathMatrixX"]:
		ii += 1
		jj = 10
		for j in i:
			jj += 1
			if !j.empty():
				str_data += str(ii) + " x " + str(jj) + " : "
				for data in j:
					str_data += ("%.2f" % [data[1]]) + "s "
					sum_score += data[1]
					sum_count += 1
				str_data += "\n"
				sum_1x += 1
				if j.size() > 1:
					sum_2x += 1
				if j.size() > 2:
					sum_3x += 1
				if j.size() > 3:
					sum_4x += 1
				if j.size() > 4:
					sum_5x += 1
	var tmp_hour: int = int(sum_score) / 3600
	var tmp_minute: int = (int(sum_score) - (tmp_hour * 3600)) / 60
	var tmp_second: int = int(sum_score) - (tmp_hour * 3600) - (tmp_minute * 60)
	var str_h: String = ""
	var str_m: String = ""
	var str_s: String = ""
	if tmp_hour > 0:
		str_h = str(tmp_hour) + "h "
	if tmp_hour > 0 || tmp_minute > 0:
		str_m = str(tmp_minute) + "m "
	if tmp_hour > 0 || tmp_minute > 0 || tmp_second > 0:
		str_s = str(tmp_second) + "s "
	if sum_count > 0:
		str_data = "Average: " + "%.2f" % [sum_score / sum_count] + "s\n\n" + str_data
	else:
		str_data = "\n" + str_data
	
	str_data = "Total: " + str_h + str_m + str_s +"\n" + str_data
	str_data = "5x: " + str(sum_5x) + ", "+"%.2f" % (float(sum_5x) / 6561 * 100)+"%\n" + str_data
	str_data = "4x: " + str(sum_4x) + ", "+"%.2f" % (float(sum_4x) / 6561 * 100)+"%\n" + str_data
	str_data = "3x: " + str(sum_3x) + ", "+"%.2f" % (float(sum_3x) / 6561 * 100)+"%\n" + str_data
	str_data = "2x: " + str(sum_2x) + ", "+"%.2f" % (float(sum_2x) / 6561 * 100)+"%\n" + str_data
	str_data = "1x: " + str(sum_1x) + ", "+"%.2f" % (float(sum_1x) / 6561 * 100)+"%\n" + str_data
	ppLabel.bbcode_text = str_data
	
	var font_height = ppLabel.get_font("normal_font").get_height()
	var line_count = ppLabel.get_line_count()
	var the_rect_size = ppLabel.rect_size
	the_rect_size.y = font_height * line_count
	ppLabel.rect_min_size = the_rect_size


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)


func _on_BtnLeft_pressed():
	ppSwipe._turn_left()


func _on_BtnRight_pressed():
	ppSwipe._turn_right()










