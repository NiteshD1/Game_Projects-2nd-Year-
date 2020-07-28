tool
extends RigidBody2D
export var rot = 0

func _ready():
	pass

func _physics_process(delta):
	set_angular_velocity(rot)

func _on_RigidBody2D_body_entered(body):

			apply_impulse(Vector2(0,0),Vector2(10,0))

