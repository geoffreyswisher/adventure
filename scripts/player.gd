#warnings-disable

extends KinematicBody2D

var gravity = 27
var friction = 15
var pos = Vector2(position.x, position.y)
var velocity = Vector2(0,-10)
var jumping = false
var on_floor = false

var jump_strength = -900
var speed = 300
var lives = 3

var pos0



func _ready():
	pos0 = position
	
	$Walk.hide()
	$Jump.hide()


func _process(_delta):
	
	# use velocity
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	# gross friction calculation
	if velocity.x > 0:
		
		$Idle.flip_h = false
		$Walk.flip_h = false
		$Jump.flip_h = false
		
		if velocity.x < friction:
			velocity.x = 0
		velocity.x = velocity.x - friction
	if velocity.x < 0:
		
		$Idle.flip_h = true
		$Walk.flip_h = true
		$Jump.flip_h = true
		
		if velocity.x > -friction:
			velocity.x = 0
		velocity.x = velocity.x + friction
	
	# gravity calculation
	velocity.y += gravity
	
	# collision detection
	for i in get_slide_count():
		if get_slide_collision(i).collider.name == "Fuel":
			save_data(load_fuel()+1, load_parts())
			get_tree().change_scene("res://scenes/open-space/Main.tscn")
		
		if get_slide_collision(i).collider.name == "Part":
			save_data(load_fuel(), load_parts()+1)
			get_tree().change_scene("res://scenes/open-space/Main.tscn")
			
		if get_slide_collision(i).collider.name.substr(0,4) == "Slug":
			position = pos0
			
		if get_slide_collision(i).collider.name.substr(0,3) == "Bat":
			position = pos0
			
		if get_slide_collision(i).collider.name.substr(0,5) == "Enemy":
			position = pos0
	
	# input detection
	check_input()
	
	if velocity.x != 0 and is_on_floor():
		$Idle.hide()
		$Jump.hide()
		$Walk.show()
		$AnimationPlayer.play("Walk")
	elif !is_on_floor():
		$Jump.show()
		$Idle.hide()
		$Walk.hide()
	else:
		$Idle.show()
		$Walk.hide()
		$Jump.hide()

	

func jump():
	if is_on_floor():
		velocity.y = jump_strength
		on_floor = false
		$AnimationPlayer.play("Jump")

func check_input():
	if Input.is_action_pressed("plat_jump"):
		jump()
	if Input.is_action_pressed("plat_left"):
		velocity.x = -speed
	if Input.is_action_pressed("plat_right"):
		velocity.x = speed



func load_data():
	var f = File.new()
	f.open('user://data.save', File.READ)
	var ret = f.get_as_text()
	return ret
	
func load_fuel():
	return int(load_data().substr(0, 3))
	
func load_parts():
	return int(load_data().substr(3, 6))

func save_data(fuel, parts):
	var f = File.new()
	f.open('user://data.save', File.WRITE)
	f.store_string('%02d\n%02d' % [fuel, parts])


