extends Object

class_name GGraph

var connects: Dictionary = {}

var val

func connect_node(node: GGraph):
	if !connects.has(node):
		connects[node] = 0
		node.connect_node(self)


func disconnect_node(node: GGraph):
	if connects.has(node):
		connects.erase(node)
		node.disconnect_node(self)

