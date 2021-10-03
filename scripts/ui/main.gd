extends Node2D

var playing = false


func _ready():
	WeatherData.camera = $Camera2D
	$Menu/Clouds/Clouds.play()
	$Menu/Clouds/Clouds2.playb()
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("Face").modulate = Color("#00ffffff")
#	$Map/WeatherDirector.can_spawn = true


func to_play():
	playing = true
	$AnimationPlayer.play("start")
	$Menu/Clouds/Clouds/FadePlayer.play("fade")
	$Menu/Clouds/Clouds2/FadePlayer.play("fade")
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("AnimationPlayer").play("face_in")


func to_menu():
	playing = false
	$AnimationPlayer.play_backwards("start")
	$Menu/Clouds/Clouds/FadePlayer.play_backwards("fade")
	$Menu/Clouds/Clouds2/FadePlayer.play_backwards("fade")
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("AnimationPlayer").play_backwards("face_in")

func _input(event):
	if event is InputEventKey and not event.is_echo() and event.is_pressed():
		if playing:
			to_menu()
		else:
			to_play()
