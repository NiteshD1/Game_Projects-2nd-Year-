extends Control

onready var sound = preload("res://asset/soundon.png")
onready var mute = preload("res://asset/soundoff.png")

func _ready():
	set_sound_image()

	pass


func _on_soundbtn_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("soundbtn").set_scale(Vector2(0.4,0.4))
	var s = utils.loadfile()
	if get_node("soundbtn").normal == sound:
		s[500] = 0
		audio.sound = 0
	else:
		s[500] = 1
		audio.sound = 1
	utils.save(s)
	audio.set_sound()
#	audio.emit_signal("sound_change")
	set_sound_image()
	pass # replace with function body
	
func set_sound_image():
#	var sound = int(audio.loadfile())
	if audio.sound == 0:
		get_node("soundbtn").normal = mute
	else:
		get_node("soundbtn").normal = sound


func _on_backmain_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("VBoxContainer/backmain").set_scale(Vector2(0.58,0.58))
	get_node("AnimationPlayer").play("animout")
	pass # replace with function body


func _on_LinkButton_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	OS.shell_open("https://bouncingbox2.blogspot.com/p/bouncing-box-privacy-policy.html")
	pass # replace with function body


func _on_soundbtn_released():
	get_node("soundbtn").set_scale(Vector2(0.35,0.35))
	pass # replace with function body


func _on_backmain_released():
	get_node("VBoxContainer/backmain").set_scale(Vector2(0.5,0.5))
	pass # replace with function body
