extends Control

var panelMgr
var logMgr
var dataMgr

onready var ppLabel: RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
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
	
	_set_data()
	

func _process(delta):
	local_time += delta
	ppRefresh.text = "%.2f" % [local_time]


func _on_BtnBack_button_down():
	panelMgr.closePanel(self)


func _set_data():
	var mathScore = dataMgr.dataJson["mathScore"]
	var sum_score: float = 0
	var sum_count: int = 0
	for i in mathScore:
		if i.size() == 4:
			ppLabel.bbcode_text += str(i[0]) + " " + i[2] + " " + str(i[1]) + ": " + ("%.2f" % [i[3]]) + "s\n"
			sum_score += i[3]
			sum_count += 1
		else:
			logMgr._error("[MiscScoreData]math score data error.")
	if sum_count > 0:
		ppAverage.text = "%.2f" % [sum_score / sum_count] + "s"
	else:
		ppAverage.text = "0.00s"


func _on_BtnRefresh_button_down():
	local_time = 0
