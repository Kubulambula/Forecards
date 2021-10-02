extends Node2D

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("cities"):
		area.get_parent().weather_effect(WeatherData.TYPES.RAIN)


func _physics_process(delta):
	pass
