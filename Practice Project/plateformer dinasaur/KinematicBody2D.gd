extends KinematicBody2D

export(float) var speed
export(float) var jumpspeed
var gravity = 100






func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	
	var direction = Vector2(0,1)
	var velocity = Vector2()
	
	velocity.y += direction.y * gravity
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("jump"):
		direction.y = -1
	
	velocity.x = direction.x * speed 
	velocity.y = direction.y * jumpspeed 
	
	move_and_slide(velocity)