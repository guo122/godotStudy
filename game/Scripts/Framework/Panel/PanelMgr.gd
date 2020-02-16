extends Node

enum PANEL_LAYER {
	HUD = -1, 
	PARTICLES = 1, 
	NORMAL = 3, 
	MAIN = 5
}

enum OPEN_TYPE {
	DEFAULT, 
	ANIMATION 
}

var _dic_name_scene: Dictionary
var _dic_name_node: Dictionary
var _dic_node_name: Dictionary

var _array_layer: Array
var _dic_layer_node: Dictionary
var _dic_node_layer: Dictionary

var _local_time: float
var _dic_delay_destory_node_time: Dictionary

var _main_scene
var _main_node: CenterContainer
var _top_node: Control

var _dic_animation_name_time: Dictionary
var _dic_name_animation: Dictionary

var _str_main_panel: String

var _log_mgr: LogMgr

func _ready():
	_log_mgr = get_node("/root/LogMgr")
	_log_mgr.info("[PanelMgr] ready")
# warning-ignore:return_value_discarded
	get_tree().get_root().connect("size_changed", self, "_on_size_changed")
	_local_time = 0
	_init_animation()
	

func _process(delta):
	_local_time += delta
	var nodeList: Array = []
	for node in _dic_delay_destory_node_time.keys():
		var t = _dic_delay_destory_node_time[node]
		t -= delta
		if t <= 0:
			nodeList.append(node)
			closePanel(node)
		else:
			_dic_delay_destory_node_time[node] = t
	for node in nodeList:
# warning-ignore:return_value_discarded
		_dic_delay_destory_node_time.erase(node)

func setMainScene(scene):
	_main_node = CenterContainer.new()
	
	_main_scene = scene
	_main_scene.add_child(_main_node)
	var regex1 = RegEx.new()
	var regex2 = RegEx.new()
	regex1.compile("[^\\/]+$")
	regex2.compile("\\.tscn")
	for panelScene in _main_scene.PanelSceneList:
		if panelScene:
			var result = regex1.search(panelScene.resource_path)
			var result2 = regex2.sub(result.strings[0], "")
			if _str_main_panel == "":
				_str_main_panel = result2
			_dic_name_scene[result2] = panelScene
	
	_top_node = Control.new()
	_main_node.add_child(_top_node)
	if _str_main_panel != "":
		openPanel(_str_main_panel, PANEL_LAYER.MAIN)
	else:
		_log_mgr.warning("Panel Scene config error, no main panel.")


func openPanel(name: String, layer:int = PANEL_LAYER.NORMAL, dic: Dictionary = {}, destoryTime: float = 0, bNewInstance: bool = false):
	var ret: Node = null
	if !bNewInstance && !_dic_name_node.has(name):
		if _dic_name_scene.has(name):
			var node = _dic_name_scene[name].instance()
			_dic_name_node[name] = node
			_dic_node_name[node] = name
			
			addNode(node, layer)
			ret = node
		else:
			var error_str = "Open Panel Scene not found: " + name;
			_log_mgr.warning(error_str)
	elif bNewInstance:
		var scene = _dic_name_scene[name]
		if !scene:
			var error_str = "Open Panel Scene not found: " + name;
			_log_mgr.warning(error_str)
		else:
			var node = scene.instance()
			_dic_node_name[node] = ""
			addNode(node, layer)
			ret = node
	else:
		var warning_str = "Open Panel Scene already open: " + name;
		_log_mgr.warning(warning_str)
	if ret:
		if destoryTime > 0:
			_dic_delay_destory_node_time[ret] = destoryTime

		ret._panel_set_dic(dic)
		ret._panel_set_rect_size(_get_will_size())
		ret._panel_ready()
			
		var animation_player = AnimationPlayer.new()
		animation_player.name = "AnimationPlayer"
		_set_animtion(animation_player)
		ret.add_child(animation_player)
		animation_player.play("open")
		
	return ret


func closePanel_name(name: String):
	if _dic_name_node.has(name):
		var node = _dic_name_node[name]
# warning-ignore:return_value_discarded
		_dic_name_node.erase(name)
# warning-ignore:return_value_discarded
		_dic_node_name.erase(node)
		
		removeNode(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene not found: " + name;
		_log_mgr.warning(warning_str)


func closePanel(node: Node):
	if _dic_node_name.has(node):
		var name = _dic_node_name[node]
# warning-ignore:return_value_discarded
		_dic_node_name.erase(node)
		if _dic_name_node.has(name):
# warning-ignore:return_value_discarded
			_dic_name_node.erase(name)
		
		removeNode(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene node not found: ";
		_log_mgr.warning(warning_str)


func closePanel_animation(node: Node, anim: String = "close"):
	node.get_node("AnimationPlayer").play(anim)
	_dic_delay_destory_node_time[node] = _dic_animation_name_time[anim]


func addNode(node: Node, layer: int):
	if !_dic_layer_node.has(layer):
		_array_layer.append(layer)
		_array_layer.sort()
		var layerNode = Control.new()
		_dic_layer_node[layer] = layerNode
		
		if _array_layer.size() == 1:
			_main_node.add_child(layerNode)
		else:
			var index = _array_layer.find(layer)
			if index == _array_layer.size() - 1:
				_main_node.add_child_below_node(_top_node, layerNode)
			else:
				var lastLayerNum = _array_layer[index + 1]
				_main_node.add_child_below_node(_dic_layer_node[lastLayerNum], layerNode)

	_dic_layer_node[layer].add_child(node)
	_dic_node_layer[node] = layer


func removeNode(node: Node):
	if _dic_node_layer.has(node):
		_dic_layer_node[_dic_node_layer[node]].remove_child(node)
	else:
		var warning_str = "Remove node not found: ";
		_log_mgr.warning(warning_str)


func _on_size_changed():
	var ssize = _get_will_size()
	if ssize != Vector2(720, 1280):
		for i in _dic_node_name:
			if i.has_method("_panel_set_rect_size"):
				i._panel_set_rect_size(ssize)


func _get_will_size() -> Vector2:
	var ret: Vector2 = Vector2(720, 1280)
	
	var window_size: Vector2 = OS.get_window_size()
	var will_height = window_size.x * 1.78
	if window_size.y > will_height:
		var ratio = 720 / window_size.x
		ret = window_size * ratio
	return ret


func _init_animation():
	var animation = Animation.new()
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, ".:rect_position")
	animation.track_insert_key(track_index, 0, Vector2(720, 0))
	animation.track_insert_key(track_index, 0.2, Vector2(0, 0))
	_dic_name_animation["open"] = animation
	_dic_animation_name_time["open"] = 0.2
	
	animation = Animation.new()
	track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, ".:rect_position")
	animation.track_insert_key(track_index, 0, Vector2(0, 0))
	
	animation.track_insert_key(track_index, 0.2, Vector2(720, 0))
	_dic_name_animation["close"] = animation
	_dic_animation_name_time["close"] = 0.2
	
	animation = Animation.new()
	track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, ".:rect_position")
	animation.track_insert_key(track_index, 0, Vector2(0, 0))
	animation.track_insert_key(track_index, 0.2, Vector2(-720, 0))
	_dic_name_animation["close2"] = animation
	_dic_animation_name_time["close2"] = 0.2


func _set_animtion(animation_player):
	animation_player.add_animation("open", _dic_name_animation["open"])
	animation_player.add_animation("close", _dic_name_animation["close"])
	animation_player.add_animation("close2", _dic_name_animation["close2"])









