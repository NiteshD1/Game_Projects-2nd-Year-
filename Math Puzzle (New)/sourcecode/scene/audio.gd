extends Node2D


var sound= null
signal sound_change

func _ready():
	sound = utils.fileobj[700]
	set_sound()
	pass


func _on_bg_finished():
	get_node("SamplePlayer2D").play("bg",1)
	pass # replace with function body

func save(content):
	var file = File.new()
#	var path = str("res://files/file" +str(level) + ".dat")
	file.open("user://save_game.dat", file.WRITE)
	file.store_string(content)
	file.close()

func loadfile():
	var file = File.new()
#	var path = str("res://files/file" +str(level) + ".dat")
	file.open("user://save_game.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	return content

func set_sound():
	if sound == 0:
		get_node("SamplePlayer2D").set_param(0,-80)
		print("volume")
	else:
		get_node("SamplePlayer2D").set_param(0,0)
		print("volume")
	

