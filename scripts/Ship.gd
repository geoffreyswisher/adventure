extends KinematicBody2D


var speed = 10
var speed_cap = 200
var friction = 2
var velocity = Vector2()

var part_label = null

func _ready():
	part_label = get_node("UI/Bar/marg/Bar/Sprite/Parts")



func _process(delta):
	
	check_input()
	
	apply_friction()
	
	if abs(position.x) > 2000 or abs(position.y) > 1000:
		velocity = Vector2(0,0)
	
	velocity = move_and_slide(velocity)

func apply_friction():
	if velocity.x > 0:
		velocity.x -= friction
	if velocity.x < 0:
		velocity.x += friction
		
	if velocity.y > 0:
		velocity.y -= friction
	if velocity.y < 0:
		velocity.y += friction

func check_input():
	if Input.is_action_pressed("move_left"):
		if velocity.x > -speed_cap:
			velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		if velocity.x < speed_cap:
			velocity.x += speed
	if Input.is_action_pressed("move_up"):
		if velocity.y > -speed_cap:
			velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		if velocity.y < speed_cap:
			velocity.y += speed
