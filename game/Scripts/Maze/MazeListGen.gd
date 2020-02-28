extends PanelBasic

class_name MazeListGen

var _maze_width
var _maze_height

var _maze_list: Array = []

func _ready():
	randomize()


func init_maze(width: int, height: int):
	_maze_width = width
	_maze_height = height
	
	for nn in _maze_list:
		nn.clear()
	_maze_list.clear()
	for i in range(0, _maze_width * _maze_height):
		_maze_list.append(_new_maze_node(0))


func generate_maze():
	_init_tree()
	for i in range(0, _maze_width):
		for j in range(0, _maze_height):
			if i % 2 == 1 && i != _maze_width - 1:
				if j % 2 == 1 && j != _maze_height - 1:
					var rr = randi() % 4
					if rr == 0:
						_set_one_tree(i - 1, j, 1)
					elif rr == 1:
						_set_one_tree(i + 1, j, 1)
					elif rr == 2:
						_set_one_tree(i, j - 1, 1)
					else:
						_set_one_tree(i, j + 1, 1)
	
#	var ii: int = -1
#	for i in range(0, _maze_width):
#		for j in range(0, _maze_height):
#			ii += 1
#			var node = _new_maze_node(_maze_list[ii])


func get_list() -> Array:
	return _maze_list


func _set_one_tree(x: int, y: int, val: int):
	if x < _maze_width - 1 && y < _maze_height - 1 && x > 0 && y > 0:
		_maze_list[x * _maze_height + y].val = val


func _get_one_tree(x: int, y: int) -> int:
	var ret: int = 0
	if x < _maze_width && y < _maze_height && x >= 0 && y >= 0:
		ret = _maze_list[x * _maze_height + y].val
	return ret


func _init_tree():
	var ii: int = -1
	for i in range(0, _maze_width):
		for j in range(0, _maze_height):
			ii += 1
			_maze_list[ii].clear()
			if i % 2 == 0 || (i % 2 == 1 && i == _maze_width - 1):
				_maze_list[ii].val = 0
			else:
				if j % 2 == 1 && j != _maze_height - 1:
					_maze_list[ii].val = 1
				else:
					_maze_list[ii].val = 0


func _new_maze_node(vv, parent = null) -> GTree:
	var ret: GTree = GTree.new()
	ret.val = vv
	if parent:
		parent.add_node(ret)
	return ret






