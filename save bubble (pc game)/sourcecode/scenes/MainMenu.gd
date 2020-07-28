extends Control
export(PackedScene) var main
export(PackedScene) var omenu

onready var onod = get_node("Sprite3")
onready var osnod = get_node("Container/MenuButton")
func _ready():
	audio.get_node("Start").play()
	pass


func change (var cnod):
	onod.hide()
	onod = cnod 
	cnod.show()

func schange (var csnod):
	csnod.set_self_modulate(Color(0.5,0.5,0.5,1))
	yield(utils.create_timer(0.2),"timeout")
	osnod.set_self_modulate(Color(1,1,1,1))
	osnod = csnod 
	



func _on_MenuButton_pressed():
	audio.get_node("Button").play()
	change($Sprite3)
	schange($Container/MenuButton)
	yield(utils.create_timer(0.1),"timeout")
	get_tree().change_scene_to(main)




func _on_MenuButton2_pressed():
	audio.get_node("Button").play()
	change($Sprite5)
	schange($Container/MenuButton2)
	yield(utils.create_timer(0.1),"timeout")
	get_tree().change_scene_to(omenu)


func _on_MenuButton4_pressed():
	audio.get_node("Button").play()
	change($Sprite6)
	schange($Container/MenuButton4)
	yield(utils.create_timer(0.1),"timeout")
	get_tree().quit()
	get_tree().free()