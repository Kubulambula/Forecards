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

var _type
var _deadly


func _ready():
	set_radius(collision_radius)
	set_type(city)
	$Face.texture = faces[population]


func set_radius(value):
	collision_radius = value
	$Area2D/CollisionShape2D.shape.radius = value


func set_type(value):
	city = value
	$Sprite.texture = load("res://assets/map/city_" + str(value) + ".png")


func add_to_population(count=1, deadly=false):
	if count > 0:
		if not deadly:
			population = clamp(population+count, 0, 2)
	else:
		population = clamp(population+count, 0, 2)
		if population == 0 and not deadly:
			population = 1
		
	$Face.texture = faces[population]
	$Reputation.texture = faces[population]
	if population == 0:
		$Sprite.texture = load("res://assets/map/city_" + str(city) + "_destroyed.png")
		$AudioStreamPlayer.play()
	$Reputation.emitting = true
	
	WeatherData.gui.happy()

func weather_effect(type, deadly):
	$Timer.start()
	_type = type
	_deadly = deadly


func _on_Timer_timeout():
	do_weather()


func do_weather():
	if not $Timer.is_stopped():
		$Timer.stop()
	if population:
		if forecast_card:
			if _type == forecast_card.type:
				print("good forecast")
				add_to_population(1, _deadly)
			else:
				print("bad forecast")
				add_to_population(-1, _deadly)
			
			forecast_card.city = null
			forecast_card.go_to_city = false
			forecast_card.go_to_origin = true
			
		else:
			print("no forecast")
			add_to_population(-1, _deadly)
	else:
		if forecast_card:
			forecast_card.city = null
			forecast_card.go_to_city = false
			forecast_card.go_to_origin = true
	forecast_card = null
