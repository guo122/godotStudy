extends Object

class_name ToolsMisc


static func rich_label_adjust_height(label: RichTextLabel, offset: float = 0):
	var font_height = label.get_font("normal_font").get_height()
	var line_count = label.get_line_count()
	var the_rect_size = label.rect_size
	the_rect_size.y = font_height * line_count + offset
	label.rect_min_size = the_rect_size




















