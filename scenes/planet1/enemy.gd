extends KinematicBody2D

var pos = Vector2(position.x, position.y)
var velocity = Vector2(0,-10)
var gravity = 27
var friction = 27
var jump_strength = 500
var on_floor = true
var speed = 30

var delta = 50

var loc_vector = Vector2.ZERO

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():

	# use velocity
	velocity = move_and_slide(velocity, Vector2(0, -1))
	pass # Replace with function body.

func get_world_objects(object):
	loc_vector = player.position - global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	print(owner.get_node("Player").position)
	print(position)
	
	# use velocity
	velocity = move_and_slide(velocity, Vector2(0, -1))

	# gross friction calculation
	if velocity.x > 0:
		if velocity.x < friction:
			velocity.x = 0
		velocity.x = velocity.x - friction
	if velocity.x < 0:
		if velocity.x > -friction:
			velocity.x = 0
		velocity.x = velocity.x + friction

	# gravity calculation
	velocity.y += gravity
	
	if player != null:
		pass
	else:
		print('nope')

	# collision detection
	for i in get_slide_count():
		if get_slide_collision(i).collider.name == "Fuel":
			emit_signal("collided", get_slide_collision(i).collider)

func jump():
	if is_on_floor():
		velocity.y = jump_strength
		on_floor = false

func _on_Area2D_body_entered(body):
	if body != self and body.is_class('KinematicBody2D'):
		player = body
	else:
		player = null


func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	player = null
