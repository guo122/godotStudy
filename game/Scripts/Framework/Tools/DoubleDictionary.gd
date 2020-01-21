extends Object

class_name DoubleDictionary

var Key2Value: Dictionary
var Value2Key: Dictionary

func add(key, value) -> bool:
	if Key2Value.has(key):
		return false
	else:
		Key2Value[key] = value
		Value2Key[value] = key
		return true


func eraseKey(key) -> bool:
	if Key2Value.has(key):
		var value = Key2Value[key]
		Value2Key.erase(value)
		Key2Value.erase(key)
		return true
	else:
		return false


func eraseValue(value) -> bool:
	if Value2Key.has(value):
		var key = Value2Key[value]
		Value2Key.erase(value)
		Key2Value.erase(key)
		return true
	else:
		return false


func hasKey(key) -> bool:
	return Key2Value.has(key)


func hasValue(value) -> bool:
	return Value2Key.has(value)


func getValue(key):
	if Key2Value.has(key):
		return Key2Value[key]
	else:
		return null


func getKey(value):
	if Value2Key.has(value):
		return Value2Key[value]
	else:
		return null


















