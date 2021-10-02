extends Node2D

export(int, 1, 5) var city = 1 
export(int, 1, 3) var population = 2
export(float, 1, 250) var collision_radius = 80 

var forecast_card = null

var faces = [
	preload("res://assets/map/people_dead.png"),
	preload("res://assets/map/people_sad.png"),
	preload("res://assets/map/people_happy.png")
]


func _ready():
	set_radius(collision_radius)
	set_type(city)


func set_radius(value):
	collision_radius = value
	$Area2D/CollisionShape2D.shape.radius = value


func set_type(value):
	city = value
	$Sprite.texture = load("res://assets/map/city_" + str(value) + ".png")


func add_to_population(count, deadly=false):
	population = clamp(population+count, 0, 2)
	if population == 0 and not deadly:
		population = 1
		return
	$Face.texture = faces[population]

func weather_effect(type, deadly):
	if forecast_card:
		if type == forecast_card.type:
			print("good forecast")
			add_to_population(1, deadly)
			print(population)
		else:
			print("bad forecast")
			add_to_population(1, deadly)
	else:
		add_to_population(-1, deadly)
