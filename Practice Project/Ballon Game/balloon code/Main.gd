extends Node2D

export(PackedScene) var Ballg
export(PackedScene) var Stars


func _ready():
	drawball()
	pass

func _process(delta):
#	$Path2D/PathFollow2D.offset += 100*delta
#	$Camera2D.position = $Path2D/PathFollow2D.position
	pass
	
func drawball():
	for i in range (0,1):
		var item = Ballg.instance()
		add_child(item)
		item.position = $Camera2D/Position2D.global_position

func _on_Area2D_body_exited(body):
	drawball()
	pass # replace with function body


func _on_Timerstar_timeout():
	$Camera2D/Path2D/PathFollow2D.offset = randi()
	var item = Stars.instance()
	add_child(item)
	item.position = $Camera2D/Path2D/PathFollow2D.global_position
	pass # replace with function body


func _on_Areaend_body_exited(body):
	print("y")
	body.queue_free()
	pass # replace with function body
