extends Control

var paused = false

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not paused:
		visible = true
		get_tree().paused = true
		paused = true
	elif Input.is_action_just_pressed("ui_cancel"):
		paused = false
		visible = false
		get_tree().paused = false


func _on_Button_pressed():
	visible = false
	get_tree().paused = false

func _on_Button2_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/ui/MainMenu_test.tscn")
