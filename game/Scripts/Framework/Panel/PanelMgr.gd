extends Node

const PANEL_HUD_LAYER = -1
const PANEL_PARTICLES_LAYER = 1
const PANEL_NORMAL_LAYER = 3
const PANEL_MAIN_LAYER = 5

var panelNameSceneDic: Dictionary
var panelNameNodeDic: Dictionary
var panelNodeNameDic: Dictionary

var layerArray: Array
var layerDic: Dictionary
var nodeDic: Dictionary

var localTime: float
var delayNodeDic: Dictionary

var mainScene
var mainNode: CenterContainer
var topNode: Control

var mainPanelName: String

func _ready():
	print("panelMgr ready")
# warning-ignore:return_value_discarded
	get_tree().get_root().connect("size_changed", self, "_size_changed")
	localTime = 0
	

func _process(delta):
	localTime += delta
	var nodeList: Array = []
	for node in delayNodeDic.keys():
		var t = delayNodeDic[node]
		t -= delta
		if t <= 0:
			nodeList.append(node)
			closePanel(node)
		else:
			delayNodeDic[node] = t
	for node in nodeList:
# warning-ignore:return_value_discarded
		delayNodeDic.erase(node)

func setMainScene(scene):
	mainNode = CenterContainer.new()
	
	mainScene = scene
	mainScene.add_child(mainNode)
	var regex1 = RegEx.new()
	var regex2 = RegEx.new()
	regex1.compile("[^\\/]+$")
	regex2.compile("\\.tscn")
	for panelScene in mainScene.PanelSceneList:
		if panelScene:
			var result = regex1.search(panelScene.resource_path)
			var result2 = regex2.sub(result.strings[0], "")
			if mainPanelName == "":
				mainPanelName = result2
			panelNameSceneDic[result2] = panelScene
	
	topNode = Control.new()
	mainNode.add_child(topNode)
	if mainPanelName != "":
		openPanel(mainPanelName, PANEL_MAIN_LAYER)
	else:
		push_error("Panel Scene config error, no main panel.")


func openPanel(name: String, layer:int = PANEL_NORMAL_LAYER, dic: Dictionary = {}, destoryTime: float = 0, bNewInstance: bool = false):
	var ret: Node = null
	if !bNewInstance && !panelNameNodeDic.has(name):
		if panelNameSceneDic.has(name):
			var node = panelNameSceneDic[name].instance()
			panelNameNodeDic[name] = node
			panelNodeNameDic[node] = name
			
			addNode(node, layer)
			ret = node
		else:
			var error_str = "Open Panel Scene not found: " + name;
			push_error(error_str)
	elif bNewInstance:
		var scene = panelNameSceneDic[name]
		if !scene:
			var error_str = "Open Panel Scene not found: " + name;
			push_error(error_str)
		else:
			var node = scene.instance()
			panelNodeNameDic[node] = ""
			addNode(node, layer)
			ret = node
	else:
		var warning_str = "Open Panel Scene already open: " + name;
		push_warning(warning_str)
	if ret:
		if destoryTime > 0:
			delayNodeDic[ret] = destoryTime
		
		if !dic.empty() && ret.has_method("_panel_set_dic"):
			ret._panel_set_dic(dic)
		
		if ret.has_method("_setRectSize"):
			ret._setRectSize(_get_will_size())
		
	return ret


func closePanel_name(name: String):
	if panelNameNodeDic.has(name):
		var node = panelNameNodeDic[name]
# warning-ignore:return_value_discarded
		panelNameNodeDic.erase(name)
# warning-ignore:return_value_discarded
		panelNodeNameDic.erase(node)
		
		removeNode(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene not found: " + name;
		push_warning(warning_str)


func closePanel(node: Node):
	if panelNodeNameDic.has(node):
		var name = panelNodeNameDic[node]
# warning-ignore:return_value_discarded
		panelNodeNameDic.erase(node)
		if panelNameNodeDic.has(name):
# warning-ignore:return_value_discarded
			panelNameNodeDic.erase(name)
		
		removeNode(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene node not found: ";
		push_warning(warning_str)


func addNode(node: Node, layer: int):
	if !layerDic.has(layer):
		layerArray.append(layer)
		layerArray.sort()
		var layerNode = Control.new()
		layerDic[layer] = layerNode
		
		if layerArray.size() == 1:
			mainNode.add_child(layerNode)
		else:
			var index = layerArray.find(layer)
			if index == layerArray.size() - 1:
				mainNode.add_child_below_node(topNode, layerNode)
			else:
				var lastLayerNum = layerArray[index + 1]
				mainNode.add_child_below_node(layerDic[lastLayerNum], layerNode)

	layerDic[layer].add_child(node)
	nodeDic[node] = layer


func removeNode(node: Node):
	if nodeDic.has(node):
		layerDic[nodeDic[node]].remove_child(node)
	else:
		var warning_str = "Remove node not found: ";
		push_warning(warning_str)


func _size_changed():
	var window_size: Vector2 = OS.get_window_size()
	var will_height = window_size.x * 1.78
	if window_size.y > will_height:
		var ratio = 720 / window_size.x
		var ssize = window_size * ratio
		
		for i in panelNodeNameDic:
			if i.has_method("_setRectSize"):
				i._setRectSize(ssize)


func _get_will_size() -> Vector2:
	var ret: Vector2 = Vector2(720, 1280)
	
	var window_size: Vector2 = OS.get_window_size()
	var will_height = window_size.x * 1.78
	if window_size.y > will_height:
		var ratio = 720 / window_size.x
		ret = window_size * ratio
	return ret





