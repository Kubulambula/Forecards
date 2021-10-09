extends Node2D

var playing = false
var is_ded = false
export(bool) var lol = false setget idk


func idk(val):
	if val:
		$Menu/GameOver/Sprite/Label.text = "Time survived: " + str(get_node("Map/WeatherDirector").get_play_time())
		is_ded = true
		$AnimationPlayer.play_backwards("game_over") 
		get_node("Map/CardContainer/AnimationPlayer").play("fade") 
		$Menu/Clouds/Clouds/FadePlayer.play_backwards("fade")
		$Menu/Clouds/Clouds2/FadePlayer.play_backwards("fade")
		for city in get_tree().get_nodes_in_group("cities"):
			city.get_node("AnimationPlayer").play_backwards("face_in")
		WeatherData.gui.get_node("AnimationPlayer").play_backwards("hide")
		
		

func _ready():
	$AnimationPlayer.play("black_out")
	WeatherData.camera = $Camera2D
	$Menu/Clouds/Clouds.play()
	$Menu/Clouds/Clouds2.playb()
	for city in get_tree().get_nodes_in_group("cities"):
		city.get_node("Face").modulate = Color("#00ffffff")
	WeatherData.gui.get_node("Sprite2").modulate = Color("#00ffffff")


func to_play():
	$CanvasLayer/ColorRect.modulate = Color("#002f2f2f")
	get_node("Map/CardContainer/AnimationPlayer").play_backwards("fade")
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
	get_node("Map/CardContainer/AnimationPlayer").play("fade")
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
		if playing and not is_ded:
			to_menu()
		else:
			to_play()


func _on_Sprite_pressed():
	to_play()


func _on_Sprite2_pressed():
	get_tree().quit()



func _on_replay_pressed():
	$AnimationPlayer.play("black_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "black_in":
		get_tree().reload_current_scene()
		
