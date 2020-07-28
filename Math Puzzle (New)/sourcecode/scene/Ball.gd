extends Node2D









func _ready():
	randomize()
	
	get_node("AnimationPlayer").play("New Anim")
	pass
#func getanswer():
#	var a1 = int(rand_range(1,4))
#	var a2 = int(rand_range(1,4))
#	var a3 = int(rand_range(4,6))
#	if a1 == 3:
#		a3 = answer - a3
#	else:
#		a3 = answer + a3
#	a1 = answer + a1
#	a2 = answer - a2
	
	pass
