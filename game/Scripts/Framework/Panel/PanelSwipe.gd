extends ScrollContainer

class_name PanelSwipe

export (Array, int) var scroll_list

var logMgr

var touch_start_pos: float = 0
var last_swipe_speed = 0

var current_pos: float = 0
var start_pos: float = 0
var end_pos: float = 0

var running: bool = false
var total_time: float = 0.2
var local_time: float = 0
var current_page: int = 0

enum ScrollTouchState {Default, Locked, Swipe}
var state = ScrollTouchState.Default

# Called when the node enters the scene tree for the first time.
func _ready():
	logMgr = get_node("/root/GLog")

func _process(delta):
	if running:
		local_time += delta
		set_h_scroll(lerp(start_pos, end_pos, sin(local_time / total_time * PI / 2)))
		if local_time > total_time:
			running = false
			set_h_scroll(end_pos)
	if state == ScrollTouchState.Locked:
		set_h_scroll(scroll_list[current_page])

func _turn_left():
	_turn_impl(-1)


func _turn_right():
	_turn_impl(1)


func _turn_impl(tt: int):
	var to_page = current_page + tt
	if to_page >= 0 && to_page < scroll_list.size():
		current_page = to_page
		start_pos = get_h_scroll()
		end_pos = scroll_list[current_page]
		local_time = 0
		running = true


func _input(event: InputEvent):
	if event.is_class("InputEventScreenDrag"):
		var input_event: InputEventScreenDrag = event
		if state == ScrollTouchState.Default:
			if abs(input_event.relative.x) > abs(input_event.relative.y):
				state = ScrollTouchState.Swipe
				_set_children_mouse_filter(Control.MOUSE_FILTER_IGNORE)
			else:
				state = ScrollTouchState.Locked
				_set_children_mouse_filter(Control.MOUSE_FILTER_STOP)
		last_swipe_speed = abs(input_event.speed.x)
	elif event.is_class("InputEventScreenTouch"):
		var input_event: InputEventScreenTouch = event
		state = ScrollTouchState.Default
		_set_children_mouse_filter(Control.MOUSE_FILTER_PASS)
		if input_event.pressed:
			touch_start_pos = get_h_scroll()
		else:
			var h_scroll: int = get_h_scroll()
			var offset = h_scroll - touch_start_pos
			if abs(h_scroll - touch_start_pos) < scroll_list[1]:
				if offset > scroll_list[1] / 2 || (offset > 0 &&  last_swipe_speed > 200):
					_turn_impl(1)
				elif offset < -scroll_list[1] / 2 || (offset < 0 &&  last_swipe_speed > 200):
					_turn_impl(-1)
				else:
					_turn_impl(0)
			else:
				var nearly_page: int = 0
				var nearly_pos: int = scroll_list[1]
				var ii: int = 0
				for i in scroll_list:
					if abs(h_scroll - i) < nearly_pos:
						nearly_pos = abs(h_scroll - i)
						nearly_page = ii
					ii += 1
				_turn_impl(nearly_page - current_page)


func _set_children_mouse_filter(filter):
	var children = get_node("HBoxContainer").get_children()
	for child in children:
		child.mouse_filter = filter



