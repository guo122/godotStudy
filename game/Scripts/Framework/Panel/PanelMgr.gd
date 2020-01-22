extends Node

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
var topNode: Node

var mainPanelName: String

func _ready():
	print("panelMgr ready")
	localTime = 0
	

func _process(delta):
	localTime += delta
	var nodeList: Array
	for node in delayNodeDic.keys():
		var t = delayNodeDic[node]
		t -= delta
		if t <= 0:
			nodeList.append(node)
			closePanel(node)
		else:
			delayNodeDic[node] = t
	for node in nodeList:
		delayNodeDic.erase(node)

func setMainScene(scene):
	mainScene = scene
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
	
	topNode = Node.new()
	mainScene.add_child(topNode)
	if mainPanelName != "":
		openPanel(mainPanelName, PANEL_MAIN_LAYER)
	else:
		push_error("Panel Scene config error, no main panel.")


func openPanel(name: String, layer:int, destoryTime: float = 0, bNewInstance: bool = false):
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
	if ret && destoryTime > 0:
		delayNodeDic[ret] = destoryTime
	return ret


func closePanel_name(name: String):
	if panelNameNodeDic.has(name):
		var node = panelNameNodeDic[name]
		panelNameNodeDic.erase(name)
		panelNodeNameDic.erase(node)
		
		removeNode(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene not found: " + name;
		push_warning(warning_str)


func closePanel(node: Node):
	if panelNodeNameDic.has(node):
		var name = panelNodeNameDic[node]
		panelNodeNameDic.erase(node)
		if panelNameNodeDic.has(name):
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
		var layerNode = Node.new()
		layerDic[layer] = layerNode
		
		if layerArray.size() == 1:
			mainScene.add_child(layerNode)
		else:
			var index = layerArray.find(layer)
			if index == layerArray.size() - 1:
				mainScene.add_child_below_node(topNode, layerNode)
			else:
				var lastLayerNum = layerArray[index + 1]
				mainScene.add_child_below_node(layerDic[lastLayerNum], layerNode)

	layerDic[layer].add_child(node)
	nodeDic[node] = layer


func removeNode(node: Node):
	if nodeDic.has(node):
		layerDic[nodeDic[node]].remove_child(node)
	else:
		var warning_str = "Remove node not found: ";
		push_warning(warning_str)







