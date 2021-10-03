class_name Weather
extends Node2D

var type = WeatherData.TYPES.INVALID
var deadly = false

var speed = 75

var spawner = null

var start_point = Vector2(1,1)
var dest_point = Vector2(0,0)
var t = 0



func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("cities"):
		area.get_parent().weather_effect(type, deadly)


func _process(delta):
	t += delta * speed
	position = start_point.linear_interpolate(dest_point, t)


func _exit_tree():
	spawner.current_effect = null
