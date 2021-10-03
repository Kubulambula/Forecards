extends Weather

func _init():
	type = WeatherData.TYPES.FIRE
	deadly = true

func _ready():
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count("default")
