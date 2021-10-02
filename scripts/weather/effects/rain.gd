extends Node2D

var move_vector = Vector2(1,0)
var speed = 100

onready var start_point = position
var t = 0


func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("cities"):
		area.get_parent().weather_effect(WeatherData.TYPES.RAIN)


func _process(delta):
	t += delta * speed
	position = start_point.linear_interpolate(move_vector, t)
