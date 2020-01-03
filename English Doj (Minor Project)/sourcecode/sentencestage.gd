extends Sprite
var fileobj1 = null

#onready var main = load("res://scene/main.tscn")

func _ready():
	fileobj1 = utils.loadfile1()
	var stage = int(get_node("Label1").get_text())
	print(stage)
	print((fileobj1[0]/100)+1)
	if stage <= (fileobj1[0]/100)+1:
		get_node("lock").hide()
#		
	pass







func _on_TouchScreenButton_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if !get_node("lock").is_visible():
		utils.sentencestage = int(get_node("Label1").get_text())
		utils.wordmode = false
		utils.emit_signal("levelshow")
#		
		
#		
		
		
	pass # replace with function body