extends Label

func _ready():
	pass # Replace with function body.


func _set_data(data: Array):
	if data.size() == 3:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": --"
	elif data.size() == 4:
		text = str(data[0]) + " " + data[2] + " " + str(data[1]) + ": " + str(data[3]).left(4) + "s"
