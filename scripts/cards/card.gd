class_name Card
extends Control

var type = 0 # change to invalid after debug

var offset = Vector2(0,0)
var zero_rotation = 0
var origin_card_point = self
var selected = false
var go_to_origin = true
var go_to_city = false
var city = null
export(float) var test_zoom

var big = false
onready var o_scale = rect_scale
var scale_plus = Vector2(0.5,0.5)

var scale_multiplier = Vector2(1.3, 1.3)

#func _ready():
#	$AnimatedSprite.playing = true


func _on_Card_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				big = false
				offset = get_local_mouse_position()
				selected = true
				go_to_origin = false
				go_to_city = false
				if city:
					city.forecast_card = null
					city = null
			else:
#				$AnimatedSprite.playing = false
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
						
	elif event is InputEventMouseMotion:
		pass
	


func _process(_delta):
	if selected:
		rect_rotation = lerp(rect_rotation, zero_rotation, 0.17)
		rect_global_position = lerp(rect_global_position, get_global_mouse_position() - offset, 0.5)
		rect_scale = lerp(rect_scale, Vector2(1,1), 0.3)
	elif go_to_city:
		rect_rotation = lerp(rect_rotation, zero_rotation, 0.2)
		var cityPosWS = city.get_node("CardHolder").rect_global_position
		var cityPosSS = ((cityPosWS - Vector2(640, 360)) / WeatherData.camera.zoom.x) + Vector2(640, 360)  
		var cardPosSS = rect_global_position
		rect_global_position = lerp(cardPosSS, cityPosSS, 0.2)
		rect_scale = lerp(rect_scale, city.get_node("CardHolder").rect_scale, 0.4)
#		rect_rotation = lerp(rect_rotation, zero_rotation, 0.2)
#		rect_global_position = lerp(rect_global_position, city.get_node("CardHolder").rect_global_position, 0.2)
#		rect_scale = lerp(rect_scale, city.get_node("CardHolder").rect_scale, 0.4)
	elif go_to_origin:
		rect_global_position = lerp(rect_global_position, origin_card_point.rect_global_position, 0.2)
		rect_rotation = lerp(rect_rotation, 0, 0.2)
		rect_scale = lerp(rect_scale, Vector2(1,1), 0.3)
#		if rect_global_position.is_equal_approx(origin_card_point.rect_global_position):
#			go_to_origin = false
#			rect_pivot_offset = Vector2(52.5,157)
	
	if rect_global_position.is_equal_approx(origin_card_point.rect_global_position):
		go_to_origin = false
	
	if selected or go_to_origin or go_to_city:
		rect_pivot_offset = Vector2(0, 0)
	else:
		rect_pivot_offset = Vector2(52.5, 157)
	
	if big:
		rect_scale = lerp(rect_scale, o_scale + scale_plus, 0.3)
	else:
		rect_scale = lerp(rect_scale, o_scale, 0.3)
	
#	if selected or city:
#		rect_pivot_offset = Vector2(0,0)
#	elif rect_global_position.is_equal_approx(origin_card_point.rect_global_position):
#		go_to_origin = false
#		rect_pivot_offset = Vector2(52.5,157)
#	elif go_to_origin:
#		if rect_global_position.is_equal_approx(origin_card_point.rect_global_position):
#			go_to_origin = false
#			rect_pivot_offset = Vector2(52.5,157)
#		else:
#			rect_pivot_offset = Vector2(0,0)


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
		


func _on_Card_mouse_entered():
	if not city:
		$AnimatedSprite.playing = true
		big = true


func _on_Card_mouse_exited():
	$AnimatedSprite.playing = false
	big = false
