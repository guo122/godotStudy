extends ScrollContainer

class_name PanelSwipe

export (int) var scroll_speed = 100
export (Array, int) var scroll_list

signal page_changed(page)

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

const SCROLL_FREEZE_TIME = 0.1
var scroll_stay_time = SCROLL_FREEZE_TIME
var scroll_start_time: float = 0
var scroll_start_enable: bool = false

enum ScrollTouchState {Default, Locked, Swipe}
var state = ScrollTouchState.Default

var _ignore: bool = false

func _ready():
	logMgr = get_node("/root/GLog")

func _process(delta):
	if running:
		local_time += delta
		set_h_scroll(lerp(start_pos, end_pos, sin(local_time / total_time * PI / 2)))
		if local_time > total_time:
			running = false
			set_h_scroll(end_pos)
			emit_signal("page_changed", current_page)
	if state == ScrollTouchState.Locked:
		set_h_scroll(scroll_list[current_page])
	if scroll_start_enable:
		scroll_start_time += delta
	if scroll_stay_time > 0:
		scroll_stay_time -= delta
		if scroll_stay_time < 0:
			last_swipe_speed = 0

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
	if !_ignore:
		if event.is_class("InputEventScreenDrag"):
			var input_event: InputEventScreenDrag = event
			if state == ScrollTouchState.Default:
				if abs(input_event.relative.x) > abs(input_event.relative.y):
					state = ScrollTouchState.Swipe
					_set_children_mouse_filter(Control.MOUSE_FILTER_IGNORE)
				else:
					state = ScrollTouchState.Locked
					_set_children_mouse_filter(Control.MOUSE_FILTER_STOP)
			if input_event.speed == Vector2(0, 0):
				scroll_start_enable = true
				var tmp_abs_relative = abs(input_event.relative.x) + (abs(input_event.relative.x) * 0.2)
				last_swipe_speed = tmp_abs_relative / scroll_start_time
			else:
				scroll_start_enable = false
				last_swipe_speed = abs(input_event.speed.x) + (abs(input_event.speed.x) * 0.2)
			scroll_stay_time = SCROLL_FREEZE_TIME
		elif event.is_class("InputEventScreenTouch"):
			var input_event: InputEventScreenTouch = event
			state = ScrollTouchState.Default
			_set_children_mouse_filter(Control.MOUSE_FILTER_PASS)
			if input_event.pressed:
				touch_start_pos = get_h_scroll()
				scroll_start_time = 0
			else:
				var h_scroll: int = get_h_scroll()
				var offset = h_scroll - touch_start_pos
				if abs(h_scroll - touch_start_pos) < scroll_list[1]:
					if offset > scroll_list[1] / 2 || (offset > 0 &&  last_swipe_speed > scroll_speed):
						_turn_impl(1)
					elif offset < -scroll_list[1] / 2 || (offset < 0 &&  last_swipe_speed > scroll_speed):
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



