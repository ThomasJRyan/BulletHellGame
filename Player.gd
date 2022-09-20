extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 10
export(PackedScene) var bullet_scene

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
	look_at(get_global_mouse_position())
	
	var velocity = Vector2()
	velocity.y += 1 if Input.is_action_pressed("MoveDown") else 0
	velocity.y -= 1 if Input.is_action_pressed("MoveUp") else 0
	velocity.x += 1 if Input.is_action_pressed("MoveRight") else 0
	velocity.x -= 1 if Input.is_action_pressed("MoveLeft") else 0
	
	move_and_collide(velocity.normalized() * speed)
	
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
	
func _input(event):
	if event.is_action_pressed("Fire"):
		fire_bullet()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
