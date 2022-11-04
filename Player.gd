extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_speed = 150
export var speed_step = 4
var current_speed = 0

export(PackedScene) var bullet_scene
var velocity = Vector2()

var inputs = {
	"MoveUp": Vector2.UP,
	"MoveDown": Vector2.DOWN,
	"MoveLeft": Vector2.LEFT,
	"MoveRight": Vector2.RIGHT,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#func move(direction):
#	position += inputs[direction]	
#
#func _unhandled_input(event):
#	for direction in inputs.keys():
#		if event.is_action_pressed(direction):
#			move(direction)

func move_player():
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	velocity = Vector2()
	
	if Input.is_action_pressed("MoveUp"):
		current_speed += speed_step if current_speed <= max_speed else 0
	else:
		current_speed -= speed_step / 2 if current_speed > 0 else 0
	
	velocity = Vector2(current_speed, 0).rotated(rotation)
	
	var screensize = get_viewport().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
func fire_bullet():
	var bullet = bullet_scene.instance()
	var direction = get_global_mouse_position()
	
	bullet.position = position
	
	get_parent().add_child(bullet)
	
	bullet.fire(direction)
			
func _physics_process(delta):
	move_player()
	velocity = move_and_slide(velocity)
#	position.move_toward(velocity, delta * max_speed)
	
func _input(event):
	if event.is_action_pressed("Fire"):
		fire_bullet()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
