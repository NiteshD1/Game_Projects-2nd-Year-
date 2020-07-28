extends Camera2D

export var cameramove = 0
func _ready():
	pass

func _process(delta):
	position.y -= cameramove * delta
	