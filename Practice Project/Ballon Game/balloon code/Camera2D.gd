extends Camera2D

export(float) var cameramove = 0
var degree = 0
func _ready():
	pass

func _process(delta):
	position.y -= cameramove * delta

func _on_Timer_timeout():
	degree += 20
#	rotation_degrees 
#	rotate(deg2rad(degree))
	set_rotation_degrees(degree)
	pass # replace with function body
