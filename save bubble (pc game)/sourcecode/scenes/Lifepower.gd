extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play("animlifepower")
 


func _on_Lifepower_area_entered(area):
	if area.is_in_group("player"):
		audio.get_node("Life").play()
		$AnimationPlayer.play("end")
		utils.emit_signal("splife")
		queue_free()
	pass # replace with function body
