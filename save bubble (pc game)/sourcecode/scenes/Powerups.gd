extends Area2D


func _ready():
	$AnimationPlayer.play("animpowerups")



func _on_Powerups_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("end")
		if utils.haspower:
			utils.emit_signal("spshield")
		else:
			utils.emit_signal("pshield")
		queue_free()
		
	pass # replace with function body
