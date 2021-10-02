extends Area2D



func _on_Deleter_area_entered(area):
	if area.get_parent().is_in_group("weather"):
		area.get_parent().queue_free()
	else:
		printerr("some random non weather node entered deleter. Continuing...")
