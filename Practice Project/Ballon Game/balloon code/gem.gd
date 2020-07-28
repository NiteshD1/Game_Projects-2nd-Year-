extends Area2D

func _ready():
	$AnimationPlayer.play("New Anim")
	pass





func _on_gem_body_entered(body):
	if body.is_in_group("player"):
		utils.emit_signal("gemscore")
		audio.get_node("gem").play()
		queue_free()
	pass # replace with function body
