extends Node2D




 




func _ready():
	randomize()
	
	get_node("AnimationPlayer").play("New Anim")
	pass
