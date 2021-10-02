extends Node2D

export(int, 1, 5) var city = 1 
export(int, 1, 3) var population = 2
export(float, 1, 250) var collision_radius = 80 

var forecast_card = null


func _ready():
	set_radius(collision_radius)
	set_type(city)

#func set_forecast_card(value):
#	if value:
#		forecast_card = value
#		value.city = self
#	else:
#		print("no value")
#		forecast_card = WeatherData.empty_card


func set_radius(value):
	collision_radius = value
	$Area2D/CollisionShape2D.shape.radius = value



func set_type(value):
	city = value
	$Sprite.texture = load("res://assets/map/city_" + str(value) + ".png")


func weather_effect(type, _deadly):
	if forecast_card:
		if type == forecast_card.type:
			# good
			print("good forecast")
		else:
			# bad
			print("bad forecast")
	else:
		print("no forecast")
