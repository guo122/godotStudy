extends Control

var panelMgr
var logMgr
var dataMgr

onready var ppLabel: RichTextLabel = $VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/RichTextLabel
onready var ppMap: TextureRect = $VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/MathMulMap
onready var ppAverage: Label = $VBoxContainer/Menu0/LabelAverage
onready var ppRefresh: Button = $VBoxContainer/Menu0/BtnRefresh

var local_time: float

func _ready():
	panelMgr = get_node("/root/PanelMgr")
	logMgr = get_node("/root/GLog")
	dataMgr = get_node("/root/GData")
	local_time = 0


func _setRectSize(ssize: Vector2):
	rect_position = Vector2(0, 0)
	rect_size = ssize
	$BasicBg.rect_min_size = ssize
	$VBoxContainer.rect_min_size = ssize
	
	dataMgr._clear_hightlight_color()
	ppMap._update_map()
	_set_text()


func _process(delta):
	local_time += delta
	ppRefresh.text = "%.2f" % [local_time]


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _set_text():
	var sum_score: float = 0
	var sum_count: int = 0
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
	ppLabel.bbcode_text = str_data

	if sum_count > 0:
		ppAverage.text = "%.2f" % [sum_score / sum_count] + "s"
	else:
		ppAverage.text = "0.00s"


func _on_BtnRefresh_button_down():
	local_time = 0
