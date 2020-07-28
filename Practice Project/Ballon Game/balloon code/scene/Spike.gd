tool
extends RigidBody2D

func _ready():
	

	
	pass


func _on_RigidBody2D_body_entered(body):
	var dir = body.position - global_position
	dir = dir.normalized() * 50
	body.apply_impulse(Vector2(),dir)
	pass # replace with function body


func _on_Timer_timeout():
	if get_parent().position.x > 115:
		$AnimationPlayer.play("New Anim (2)")
		$Sprite.flip_v = true
	else:
		$AnimationPlayer.play("New Anim")
	
	pass # replace with function body
