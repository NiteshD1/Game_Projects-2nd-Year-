extends Control


var volume = 0
func _ready():
	if loadvalue() != null:
		volume = loadvalue()
	$HSlider.set_value(float(volume))
	pass


func _on_HSlider_value_changed(value):
	audio.volume = value
	save(value)
	
	audio.emit_signal("changevolume")
	pass # replace with function body


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	pass # replace with function body
		
func save(content):
    var file = File.new()
    file.open("res://save_game1.dat", file.WRITE)
    file.store_string(str(content))
    file.close()

func loadvalue():
    var file = File.new()
    file.open("res://save_game1.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    return content
