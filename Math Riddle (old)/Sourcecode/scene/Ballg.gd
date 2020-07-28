tool
extends RigidBody2D
export var angular = 20
func _ready():
	pass

func _physics_process(delta):
	pass






func _on_Ballg_body_entered(body):
	audio.get_node("SamplePlayer2D").play("hit")
	pass # replace with function body
