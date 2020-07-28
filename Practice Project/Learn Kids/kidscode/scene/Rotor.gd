
extends RigidBody2D
export var angular = 2

func _ready():
	$AnimationPlayer.play("New Anim")
	pass
#
#func _physics_process(delta):
#	angular_velocity += angular
#	position.x += angular