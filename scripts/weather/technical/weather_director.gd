extends Node2D

export(int, 1, 900) var sec_duration = 600
export(Array, WeatherData.TYPES) var allowed_effects = []
var weather_effect_spawners = []
var time_started
var end_timer

func _ready():
	weather_effect_spawners = get_children()
	time_started = OS.get_unix_time()
	
	end_timer = Timer.new()
	add_child(end_timer)
	end_timer.wait_time = sec_duration
	end_timer.start()
	
	weather_effect_spawners[0].spawn(preload("res://scenes/weather/effects/rain.tscn"))


func get_play_time():
	return OS.get_unix_time() - time_started


func chance(percentage):
	randomize()
	return (percentage - 1) <= (randi() % 100)
