extends Node

var panelNameSceneDic: Dictionary
var panelNameNodeDic: Dictionary
var panelNodeNameDic: Dictionary

var mainScene

var mainPanelName: String

func _ready():
	print("panelMgr ready")


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
	
	if mainPanelName != "":
		openPanel(mainPanelName)
	else:
		push_error("Panel Scene config error, no main panel.")


func openPanel(name: String):
	if !panelNameNodeDic.has(name):
		var scene = panelNameSceneDic[name]
		if !scene:
			var error_str = "Open Panel Scene not found: " + name;
			push_error(error_str)
		else:
			var node = scene.instance()
			panelNameNodeDic[name] = node
			panelNodeNameDic[node] = name
			mainScene.add_child(node)
	else:
		var warning_str = "Open Panel Scene already open: " + name;
		push_warning(warning_str)


func closePanel_name(name: String):
	if panelNameNodeDic.has(name):
		var node = panelNameNodeDic[name]
		panelNameNodeDic.erase(name)
		panelNodeNameDic.erase(node)
		
		mainScene.remove_child(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene not found: " + name;
		push_warning(warning_str)


func closePanel(node: Node):
	if panelNodeNameDic.has(node):
		var name = panelNodeNameDic[node]
		panelNodeNameDic.erase(node)
		panelNameNodeDic.erase(name)
		
		mainScene.remove_child(node)
		node.queue_free()
	else:
		var warning_str = "Close Panel Scene node not found: ";
		push_warning(warning_str)




