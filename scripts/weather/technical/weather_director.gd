extends Node2D

export(Array, WeatherData.TYPES) var allowed_effects = []
var weather_effect_spawners = []
var time_started

func _ready():
	weather_effect_spawners = get_children()
	time_started = OS.get_unix_time()


func get_play_time():
	return OS.get_unix_time() - time_started
