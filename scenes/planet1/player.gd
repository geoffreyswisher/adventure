extends KinematicBody2D

var gravity = 27
var friction = 15
var pos = Vector2(position.x, position.y)
var velocity = Vector2(0,-10)
var jumping = false
var on_floor = false

var jump_strength = -900
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
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
	
	# collision detection
	for i in get_slide_count():
		if get_slide_collision(i).collider.name == "Fuel":
			get_tree().change_scene("res://scenes/open-space/Main.tscn")

	
	# input detection
	check_input()
	
	
	

	

func jump():
	if is_on_floor():
		velocity.y = jump_strength
		on_floor = false

func check_input():
	if Input.is_action_pressed("plat_jump"):
		jump()
	if Input.is_action_pressed("plat_left"):
		velocity.x = -speed
	if Input.is_action_pressed("plat_right"):
		velocity.x = speed

