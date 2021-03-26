#warnings-disable

extends KinematicBody2D


# enemy #1: flies over player and tries to crush them

var velocity = Vector2(0,-10)

var crush_strength = 500
var speed = 800

var move = Vector2.ZERO

var player = null

func _ready():
	pass # Replace with function body.

func _process(_delta):
	
	# use velocity
	velocity = move_and_slide(velocity, Vector2(0, -1))

	# collision detection
	for i in get_slide_count():
		if get_slide_collision(i).collider.name == "Fuel":
			emit_signal("collided", get_slide_collision(i).collider)

func rand_crush():
	var t = rand_range(0, 0.1)
	yield(get_tree().create_timer(t), 'timeout')
	velocity.y = crush_strength

func _physics_process(delta):
	
	if player != null:
		move = position.direction_to(player.position) * speed
		if (move.y > 0): move.y = 0
		if player.position.y > position.y + 100 and abs(player.position.x - position.x) < 2:
			rand_crush()
	else:
		move = Vector2.ZERO
	
	if position.y > 175: move.y -= 1000
	
	move = move.normalized()
	move = move_and_collide(move)
	
	$AnimationPlayer.play("Flap")

func _on_Area2D_body_entered(body):
	if body != self and body.is_class('KinematicBody2D') and body.name == 'Player':
		player = body
	else:
		player = null

