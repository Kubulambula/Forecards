class_name Card
extends Control

var type = 0 # change to invalid after debug

var offset = Vector2(0,0)
var zero_rotation = 0
var origin_card_point = self
var selected = false
var go_to_origin = false
var go_to_city = false
var city = null


func _on_Card_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				$AnimatedSprite.playing = true
				offset = get_local_mouse_position()
				selected = true
				go_to_origin = false
				go_to_city = false
				if city:
					city.forecast_card = null
					city = null
			else:
				$AnimatedSprite.playing = false
				selected = false
				var cities = get_cities_beneath()
				
				match cities.size():
					0:
						go_to_city = false
						go_to_origin = true
						if city:
							city.forecast_card = null
							city = null
					1:
						if cities[0].forecast_card != null:
							cities[0].forecast_card.city = null
							cities[0].forecast_card.go_to_origin = true
							cities[0].forecast_card.go_to_city = false
						
						if cities[0].population:
							city = cities[0]
							cities[0].forecast_card = self
							go_to_city = true
							go_to_origin = false
							particles()
						else:
							go_to_origin = true
						
					_:
						for c in cities:
							if c.forecast_card == null:
								city = c
								c.forecast_card = self
								go_to_city = true
								go_to_origin = false
								return
						
						cities[0].forecast_card.city = null
						cities[0].forecast_card.go_to_origin = true
						cities[0].forecast_card.go_to_city = false
						
						city = cities[0]
						cities[0].forecast_card = self
						go_to_city = true
						go_to_origin = false
						particles()


func _process(_delta):
	if selected:
		rect_rotation = lerp(rect_rotation, zero_rotation, 0.17)
		rect_global_position = lerp(rect_global_position, get_global_mouse_position() - offset, 0.5)
		rect_scale = lerp(rect_scale, Vector2(1,1), 0.3)
	elif go_to_city:
		rect_rotation = lerp(rect_rotation, zero_rotation, 0.2)
		rect_global_position = lerp(rect_global_position, city.get_node("CardHolder").rect_global_position, 0.2)
		rect_scale = lerp(rect_scale, city.get_node("CardHolder").rect_scale, 0.4)
	elif go_to_origin:
		rect_global_position = lerp(rect_global_position, origin_card_point.rect_global_position, 0.2)
		rect_rotation = lerp(rect_rotation, 0, 0.2)
		rect_scale = lerp(rect_scale, Vector2(1,1), 0.3)
#	else:
#		# do nothing
#		pass


func get_cities_beneath():
	var cities = []
	for _city in $Area2D.get_overlapping_areas():
		if _city.get_parent().is_in_group("cities"):
			cities.append(_city.get_parent())
	return cities


func particles():
	for c in $Particles.get_children():
		c.restart()
		c.emitting = true
		
