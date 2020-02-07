extends Object

class_name ToolsMisc


static func _RichLabelAdjustHeight(label: RichTextLabel):
	var font_height = label.get_font("normal_font").get_height()
	var line_count = label.get_line_count()
	var the_rect_size = label.rect_size
	the_rect_size.y = font_height * line_count
	label.rect_min_size = the_rect_size




















