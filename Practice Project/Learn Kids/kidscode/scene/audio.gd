extends Node2D

var sound 
signal sound_change

func _ready():
	sound = int(loadfile())
	set_sound()
	pass


func _on_bg_finished():
	$bg.play()
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
		$tap.volume_db = -80
		$bg.volume_db = -80
		$hit.volume_db = -80

		$click.volume_db = -80
		$gem.volume_db = -80
		$lose.volume_db = -80
		$start.volume_db = -80
		$level.volume_db = -80
	else:
		$tap.volume_db = 0
		$bg.volume_db = 0
		$hit.volume_db = 0

		$click.volume_db = 0
		$gem.volume_db = 0
		$lose.volume_db = 0
		$start.volume_db = 0
		$level.volume_db = 0

