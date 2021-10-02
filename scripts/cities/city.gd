tool
extends Node2D

export(int, 1, 5) var city = 1 setget set_type
export(int, 1, 3) var population = 2
export(float, 1, 250) var collision_radius = 80 setget set_radius


var forecast = WeatherData.TYPES.INVALID setget set_forecast


func set_forecast(value):
	forecast = value
	print("Forecasted: ", value)


func set_radius(value):
	if Engine.editor_hint:
		collision_radius = value
		$Area2D/CollisionShape2D.shape.radius = value

func set_type(value):
	if Engine.editor_hint:
		city = value
		$Sprite.texture = load("res://assets/map/city_" + str(value) + ".png")


func weather_effect(type, _deadly):
	if type == forecast:
		# good
		print("good forecast")
	else:
		# bad
		print("bad forecast")
