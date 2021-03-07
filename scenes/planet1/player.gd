extends KinematicBody2D

var gravity = 20
var friction = 15
var pos = Vector2(position.x, position.y)
var velocity = Vector2(0,-10)
var jumping = false
var on_floor = false

var jump_strength = -600
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# gross friction calculation
	if velocity.x > 0:
		if velocity.x < friction:
			velocity.x = 0
		velocity.x = velocity.x - friction
	if velocity.x < 0:
		if velocity.x > -friction:
			velocity.x = 0
		velocity.x = velocity.x + friction
	
	# collision detection
	for i in get_slide_count():
		if get_slide_collision(i).collider.name == "Tiles":
			on_floor = true
			velocity.y = 0
	
	# input detection
	check_input()
	
	# gravity calculation
	velocity.y += gravity
	
	# use velocity
	move_and_slide(velocity)

func jump():
	if on_floor:
		velocity.y = jump_strength
		on_floor = false

func check_input():
	if Input.is_action_pressed("plat_jump"):
		jump()
	if Input.is_action_pressed("plat_left"):
		velocity.x = -speed
	if Input.is_action_pressed("plat_right"):
		velocity.x = speed

