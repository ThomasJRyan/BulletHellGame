extends KinematicBody2D

export var speed = 400

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fire_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var screensize = get_viewport().size
	if position.x > screensize.x + 100:
		queue_free()
	if position.x < -100:
		queue_free()
	if position.y > screensize.y + 100:
		queue_free()
	if position.y < -100:
		queue_free()
		
	move_and_slide(fire_direction)
		
func fire(pos):
	fire_direction = (pos - position).normalized() * speed
#	print(fire_direction)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
