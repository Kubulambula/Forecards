class_name Card
extends Control

signal selected(what)
signal deselected(what)

var offset = Vector2(0,0)
var origin_card_point = self
var selected = false


func _on_Card_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				selected = true
				emit_signal("selected", self)
			else:
				selected = false
				emit_signal("deselected", self)


func _process(_delta):
	if selected:
		print("selected")
		rect_global_position = get_global_mouse_position() + offset
	else:
		rect_global_position = lerp(rect_global_position, origin_card_point.rect_global_position, 0.2)
