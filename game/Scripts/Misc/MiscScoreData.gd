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
	var mathScoreX = dataMgr.dataJson["mathScoreX"]
	var sum_score: float = 0
	var sum_count: int = 0
	for num1 in mathScoreX:
		for num2 in mathScoreX[num1]:
			var scoreDataList = mathScoreX[num1][num2]
			for i in scoreDataList:
				ppLabel.bbcode_text += num1 + " x " + num2 + " : " + ("%.2f" % [i[1]]) + "s\n"
				sum_score += i[1]
				sum_count += 1
	if sum_count > 0:
		ppAverage.text = "%.2f" % [sum_score / sum_count] + "s"
	else:
		ppAverage.text = "0.00s"


func _on_BtnRefresh_button_down():
	local_time = 0
