extends Node2D

var playing = false

func _ready():
	WeatherData.camera = $Camera2D
	$Menu/Clouds/Clouds.play()
	$Menu/Clouds/Clouds2.playb()
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("Face").modulate = Color("#00ffffff")
	WeatherData.gui.get_node("Sprite2").modulate = Color("#00ffffff")


func to_play():
	playing = true
	get_tree().paused = false
	$Map/WeatherDirector.can_spawn = true
	$AnimationPlayer.play("start")
	$Menu/Clouds/Clouds/FadePlayer.play("fade")
	$Menu/Clouds/Clouds2/FadePlayer.play("fade")
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("AnimationPlayer").play("face_in")
	WeatherData.gui.get_node("AnimationPlayer").play("hide")


func to_menu():
	playing = false
	get_tree().paused = true
	$AnimationPlayer.play_backwards("start")
	$Menu/Clouds/Clouds/FadePlayer.play_backwards("fade")
	$Menu/Clouds/Clouds2/FadePlayer.play_backwards("fade")
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("AnimationPlayer").play_backwards("face_in")
	WeatherData.gui.get_node("AnimationPlayer").play_backwards("hide")

func _input(event):
	if event is InputEventKey and not event.is_echo() and event.is_pressed() and event.scancode == KEY_ESCAPE:
		if playing:
			to_menu()
		else:
			to_play()


func _on_Sprite_pressed():
	to_play()


func _on_Sprite2_pressed():
	get_tree().quit()

