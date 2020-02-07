extends ScrollContainer

class_name PanelSwipe

export (Array, int) var scroll_list

var logMgr

var current_pos: float = 0
var start_pos: float = 0
var end_pos: float = 0

var running: bool = false
var total_time: float = 0.2
var local_time: float = 0
var current_page: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	logMgr = get_node("/root/GLog")
	connect("scroll_started", self, "_on_PanelSwipe_scroll_started")
	connect("scroll_ended", self, "_on_PanelSwipe_scroll_ended")

func _process(delta):
	if running:
		local_time += delta
		set_h_scroll(lerp(start_pos, end_pos, sin(local_time / total_time * PI / 2)))
		if local_time > total_time:
			running = false
			set_h_scroll(end_pos)

func _turn_left():
	if current_page > 0 && current_page < scroll_list.size():
		current_page -= 1
		start_pos = get_h_scroll()
		end_pos = scroll_list[current_page]
		local_time = 0
		running = true


func _turn_right():
	if current_page < scroll_list.size() - 1:
		current_page += 1
		start_pos = get_h_scroll()
		end_pos = scroll_list[current_page]
		local_time = 0
		running = true


func _on_Swipe_gui_input(event: InputEvent):
	if event.is_pressed():
		logMgr._debug("[Swipe] start")
	else:
		logMgr._debug("[Swipe] end")


func _on_Swipe_scroll_ended():
	logMgr._debug("[Swipe] scroll ended")


func _on_Swipe_scroll_started():
	logMgr._debug("[Swipe] scroll started")
