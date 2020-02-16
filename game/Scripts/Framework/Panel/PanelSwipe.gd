extends ScrollContainer

class_name PanelSwipe

export (int) var scroll_speed = 100
export (Array, int) var scroll_list

signal signal_page_changed(page)

var b_ignore_input: bool = false

var _touch_start_pos: float = 0
var _last_swipe_speed = 0

var _current_pos: float = 0
var _start_pos: float = 0
var _end_pos: float = 0

var _b_running: bool = false
var _total_time: float = 0.2
var _local_time: float = 0
var _current_page: int = 0

const _SCROLL_FREEZE_TIME = 0.1
var _scroll_stay_time = _SCROLL_FREEZE_TIME
var _scroll_start_time: float = 0
var _scroll_start_enable: bool = false

enum _ScrollTouchState {Default, Locked, Swipe}
var _state = _ScrollTouchState.Default

var _log_mgr: LogMgr

func _ready():
	_log_mgr = get_node("/root/LogMgr")

func _process(delta):
	if _b_running:
		_local_time += delta
		set_h_scroll(lerp(_start_pos, _end_pos, sin(_local_time / _total_time * PI / 2)))
		if _local_time > _total_time:
			_b_running = false
			set_h_scroll(_end_pos)
			emit_signal("signal_page_changed", _current_page)
	if _state == _ScrollTouchState.Locked:
		set_h_scroll(scroll_list[_current_page])
	if _scroll_start_enable:
		_scroll_start_time += delta
	if _scroll_stay_time > 0:
		_scroll_stay_time -= delta
		if _scroll_stay_time < 0:
			_last_swipe_speed = 0

func turn_left(num: int = -1):
	_turn_impl(num)


func turn_right(num: int = 1):
	_turn_impl(num)


func _turn_impl(tt: int):
	var to_page = _current_page + tt
	if to_page >= 0 && to_page < scroll_list.size():
		_current_page = to_page
		_start_pos = get_h_scroll()
		_end_pos = scroll_list[_current_page]
		_local_time = 0
		_b_running = true


func _input(event: InputEvent):
	if !b_ignore_input:
		if event.is_class("InputEventScreenDrag"):
			var input_event: InputEventScreenDrag = event
			if _state == _ScrollTouchState.Default:
				if abs(input_event.relative.x) > abs(input_event.relative.y):
					_state = _ScrollTouchState.Swipe
					_set_children_mouse_filter(Control.MOUSE_FILTER_IGNORE)
				else:
					_state = _ScrollTouchState.Locked
					_set_children_mouse_filter(Control.MOUSE_FILTER_STOP)
			if input_event.speed == Vector2(0, 0):
				_scroll_start_enable = true
				var tmp_abs_relative = abs(input_event.relative.x) + (abs(input_event.relative.x) * 0.2)
				_last_swipe_speed = tmp_abs_relative / _scroll_start_time
			else:
				_scroll_start_enable = false
				_last_swipe_speed = abs(input_event.speed.x) + (abs(input_event.speed.x) * 0.2)
			_scroll_stay_time = _SCROLL_FREEZE_TIME
		elif event.is_class("InputEventScreenTouch"):
			var input_event: InputEventScreenTouch = event
			_state = _ScrollTouchState.Default
			_set_children_mouse_filter(Control.MOUSE_FILTER_PASS)
			if input_event.pressed:
				_touch_start_pos = get_h_scroll()
				_scroll_start_time = 0
			else:
				var h_scroll: int = get_h_scroll()
				var offset = h_scroll - _touch_start_pos
				if abs(h_scroll - _touch_start_pos) < scroll_list[1]:
					if offset > scroll_list[1] / 2 || (offset > 0 &&  _last_swipe_speed > scroll_speed):
						_turn_impl(1)
					elif offset < -scroll_list[1] / 2 || (offset < 0 &&  _last_swipe_speed > scroll_speed):
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
					_turn_impl(nearly_page - _current_page)


func _set_children_mouse_filter(filter):
	var children = get_node("HBoxContainer").get_children()
	for child in children:
		child.mouse_filter = filter



