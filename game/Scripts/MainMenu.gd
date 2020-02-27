extends PanelBasic


func _on_BtnMath_pressed():
	_g.panel_mgr.openPanel("MathMul")


func _on_BtnScore_pressed():
	_g.panel_mgr.openPanel("MathScoreData")


func _on_BtnSetting_pressed():
	_g.panel_mgr.openPanel("MiscSetting")


func _on_BtnChangeLog_pressed():
	_g.panel_mgr.openPanel("MiscChangeLog")


func _on_BtnSolar_pressed():
	_g.panel_mgr.openPanel("SolarSystem")


func _on_BtnMaze_pressed():
	_g.panel_mgr.openPanel("MazeSystem")




