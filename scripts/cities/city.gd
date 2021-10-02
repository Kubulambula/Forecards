tool
extends Node2D

export(int, 1, 5) var city = 1 setget set_type
export(int, 1, 999999) var population = 100
export(float, 1, 250) var collision_radius = 80 setget set_radius


var received_forecast = WeatherData.TYPES.INVALID

func _init():
	pass

#func _ready():
#	set_radius(collision_radius)
#	set_type(city)

func set_radius(value):
	if Engine.editor_hint:
		collision_radius = value
		$Area2D/CollisionShape2D.shape.radius = value

func set_type(value):
	if Engine.editor_hint:
		city = value
		$Sprite.texture = load("res://assets/map/city_" + str(value) + ".png")


func weather_effect(what):
	if what == received_forecast:
		# good
		print("good forecast")
	else:
		# bad
		print("bad forecast")
