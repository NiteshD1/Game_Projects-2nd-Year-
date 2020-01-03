extends Sprite

var fileobj = null

#onready var main = load("res://scene/main.tscn")

func _ready():
	fileobj = utils.loadfile()
	var stage = int(get_node("Label1").get_text())
	print(stage)
	print((fileobj[0]/100)+1)
	if stage <= (fileobj[0]/100)+1:
		get_node("lock").hide()
#		
	pass







func _on_TouchScreenButton_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if !get_node("lock").is_visible():
		utils.wordstage = int(get_node("Label1").get_text())
		utils.wordmode = true
		utils.emit_signal("levelshow")
#		
		print(utils.wordstage)
#		
		
		
	pass # replace with function body



