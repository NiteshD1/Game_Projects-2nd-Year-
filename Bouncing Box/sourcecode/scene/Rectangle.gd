tool
extends RigidBody2D
var angular = 0

func _ready():
	randomize()
	if utils.level >= 4:
		var no = rand_range(0,2)
		if no:
			angular = rand_range(100,170)
			$Timer.start()


func _physics_process(delta):
	
	position.x += angular*delta
	
	pass




func _on_Rectangle_body_entered(body):
			print("free")


func _on_Timer_timeout():
	angular = -angular
	pass # replace with function body
