extends Control

var panelMgr
var logMgr
var dataMgr

onready var ppLabelSummary: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/ScrollContainer/VBoxContainer/LabelSummary
onready var ppLabelDatetime: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelDatetime
onready var ppLabelList: RichTextLabel = $VBoxContainer/MarginContainer/Swipe/HBoxContainer/LabelList
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
	var str_data_summary = ""
	var str_data_datetime = ""
	var str_data_list = ""
	var date_array: Array = []
	var date_dic: Dictionary = {}
	var str_date = ""
	var ii: int = 10
	var jj: int = 10
	for i in dataMgr._data["mathMatrixX"]:
		ii += 1
		jj = 10
		for j in i:
			jj += 1
			if !j.empty():
				str_data_list += str(ii) + " x " + str(jj) + " : "
				for data in j:
					str_date = ToolsDatetime._Timestamp2Date(data[0])
					str_data_list += ("%.2f" % [data[1]]) + "s "
					if !date_dic.has(str_date):
						var tmp_array: Array = []
						tmp_array.append(0)
						tmp_array.append(0)
						date_dic[str_date] = tmp_array
						date_array.append(str_date)
					date_dic[str_date][0] += data[1]
					date_dic[str_date][1] += 1
					sum_score += data[1]
					sum_count += 1
				str_data_list += "\n"
				sum_1x += 1
				if j.size() > 1:
					sum_2x += 1
				if j.size() > 2:
					sum_3x += 1
				if j.size() > 3:
					sum_4x += 1
				if j.size() > 4:
					sum_5x += 1
	date_array.sort()
	if sum_count > 0:
		str_data_summary = "Average: " + "%.2f" % [sum_score / sum_count] + "s\n"
	else:
		str_data_summary = "\n" + str_data_summary
	
	str_data_summary = "Total: " + ToolsDatetime._DurationSecond2Datetime(sum_score) +"\n" + str_data_summary
	str_data_summary = "5x: " + str(sum_5x) + ", "+"%.2f" % (float(sum_5x) / 6561 * 100)+"%\n" + str_data_summary
	str_data_summary = "4x: " + str(sum_4x) + ", "+"%.2f" % (float(sum_4x) / 6561 * 100)+"%\n" + str_data_summary
	str_data_summary = "3x: " + str(sum_3x) + ", "+"%.2f" % (float(sum_3x) / 6561 * 100)+"%\n" + str_data_summary
	str_data_summary = "2x: " + str(sum_2x) + ", "+"%.2f" % (float(sum_2x) / 6561 * 100)+"%\n" + str_data_summary
	str_data_summary = "1x: " + str(sum_1x) + ", "+"%.2f" % (float(sum_1x) / 6561 * 100)+"%\n" + str_data_summary
	ppLabelSummary.bbcode_text = str_data_summary
	ppLabelList.bbcode_text = str_data_list
	
	ToolsMisc._RichLabelAdjustHeight(ppLabelSummary)
	
	for ss in date_array:
		str_data_datetime = ss + ": " + ToolsDatetime._DurationSecond2Datetime(date_dic[ss][0]) + " (" + str(date_dic[ss][1]) + ")\n" + str_data_datetime
	ppLabelDatetime.bbcode_text = str_data_datetime


func _on_BtnBack_pressed():
	panelMgr.closePanel_animation(self)


func _on_BtnLeft_pressed():
	ppSwipe._turn_left()


func _on_BtnRight_pressed():
	ppSwipe._turn_right()










