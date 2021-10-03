extends Node2D

export(int, 1, 1800) var sec_duration = 600 # 10 minut
export(float, 0.1, 60) var weather_update_tick_rate = 3
export(float, 0.1, 60) var weather_update_tick_rate_random_delay = 5
export(bool) var allowed_rain = true
export(bool) var allowed_fire = false
export(bool) var allowed_rock = false
export(bool) var allowed_tornado = false
export(int, 1, 100) var max_weather_effects = 4 
var can_spawn = false setget set_can_spawn
var weather_effect_spawners = []
var time_started
var end_timer
var lazy_update_timer

var effects = [
	preload("res://scenes/weather/effects/rain.tscn"),
	preload("res://scenes/weather/effects/tornado.tscn"),
	preload("res://scenes/weather/effects/fire.tscn"),
	preload("res://scenes/weather/effects/rock.tscn")
]

func _ready():
	weather_effect_spawners = $Spawners.get_children()
	time_started = OS.get_unix_time()
	
	end_timer = Timer.new()
	end_timer.wait_time = sec_duration
	add_child(end_timer)
	end_timer.start()
	
	lazy_update_timer = Timer.new()
	lazy_update_timer.wait_time = weather_update_tick_rate
	lazy_update_timer.connect("timeout", self, "lazy_update")
	add_child(lazy_update_timer)
	lazy_update_timer.start()


func set_can_spawn(value):
	if value:
		time_started = OS.get_unix_time()
		can_spawn = true
	else:
		can_spawn = false


func get_play_time():
	return OS.get_unix_time() - time_started


func chance(percentage):
	randomize()
	return (percentage - 1) <= (randi() % 100)


func remap_value_between_ranges(value: float, old_range: Vector2, new_range: Vector2) -> float:
	return ((value - old_range.x) / (old_range.y - old_range.x)) * (new_range.y - new_range.x) + new_range.x


func get_active_weather_effect_count():
	return $WeatherContainer.get_child_count()


func lazy_update():
	randomize()
#	lazy_update_timer.wait_time = weather_update_tick_rate + rand_range(0, weather_update_tick_rate_random_delay)
	if can_spawn and get_active_weather_effect_count() < max_weather_effects:
		for spawner in weather_effect_spawners:
			if spawner.current_effect == null:
				spawner.spawn(effects[randi()%effects.size()], $WeatherContainer)
