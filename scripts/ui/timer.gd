extends Label


var time = 0
var timer_on = false
var notdead = true

func _ready():
	if(notdead == true):
		timer_on = true
	
		
func _process(delta):
	if(timer_on):
		time += delta
