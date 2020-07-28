extends TouchScreenButton
var btn = null
signal btn

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_btn1_pressed():
	btn = get_node("Label").get_text()
	emit_signal("btn")
	
	pass # replace with function body
