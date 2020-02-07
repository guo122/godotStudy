extends ScrollContainer

export (Array, int) var scroll_list

var logMgr

# Called when the node enters the scene tree for the first time.
func _ready():
	logMgr = get_node("/root/GLog")
	connect("scroll_started", self, "_on_PanelSwipe_scroll_started")
	connect("scroll_ended", self, "_on_PanelSwipe_scroll_ended")

func _process(delta):
	pass
#	print(get_h_scroll())


func _on_Swipe_gui_input(event: InputEvent):
	if event.is_pressed():
		logMgr._debug("[Swipe] start")
	else:
		logMgr._debug("[Swipe] end")


func _on_Swipe_scroll_ended():
	logMgr._debug("[Swipe] scroll ended")


func _on_Swipe_scroll_started():
	logMgr._debug("[Swipe] scroll started")
