class_name Card
extends Control

signal selected(what)
signal deselected(what)

var offset = Vector2(0,0)
var origin_card_point = self
var selected = false
var go_to_origin = false


func _on_Card_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				selected = true
				go_to_origin = false
				emit_signal("selected", self)
			else:
				selected = false
				var cities = get_cities_beneath()
				if not cities:
					go_to_origin = true
				emit_signal("deselected", self)


func _process(_delta):
	if selected:
		rect_global_position = get_global_mouse_position() + offset
	elif go_to_origin:
		rect_global_position = lerp(rect_global_position, origin_card_point.rect_global_position, 0.2)
	else:
		# wait or something
		pass


func get_cities_beneath():
	var cities = []
	for city in $Area2D.get_overlapping_areas():
		if city.get_parent().is_in_group("cities"):
			cities.append(city)
	return cities
