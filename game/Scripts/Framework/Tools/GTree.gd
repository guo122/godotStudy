extends Object

class_name GTree

var root: GTree = self
var parent: GTree = null

var nexts: Dictionary = {}

var val

func add_node(node: GTree):
	if !nexts.has(node):
		nexts[node] = 0
		node.root = root
		node.parent = self


func is_exist_node(node: GTree) -> bool:
	return root.find_node(node)


func find_node(node: GTree) -> bool:
	var ret: bool = node == self
	for nn in nexts.keys():
		if ret:
			break
		ret = nn.find_node(node)
	return ret


func clear():
	root._clear_impl()


func _clear_impl():
	if !nexts.empty():
		for nn in nexts.keys():
			nn._clear_impl()
	nexts.clear()
	root = self
	parent = null




