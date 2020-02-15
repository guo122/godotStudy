extends PanelBasic


func _on_BtnMath_pressed():
	_g.panelMgr.openPanel("MathMul")


func _on_BtnScore_pressed():
	_g.panelMgr.openPanel("MathScoreData")


func _on_BtnSetting_pressed():
	_g.panelMgr.openPanel("MiscSetting")


func _on_BtnChangeLog_pressed():
	_g.panelMgr.openPanel("MiscChangeLog")


func _on_BtnSolar_pressed():
	_g.panelMgr.openPanel("SolarSystem")




