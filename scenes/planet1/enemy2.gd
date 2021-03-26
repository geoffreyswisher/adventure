#warnings-disable
extends KinematicBody2D

# enemy #1: flies over player and tries to crush them

var velocity = Vector2(0,-10)

var speed = 50

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


func _physics_process(delta):
	
	if player != null:
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
	
	move = move.normalized()
	move = move_and_collide(move)
	
	$AnimationPlayer.play("Flap")

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body != self and body.is_class('KinematicBody2D') and body.name == 'Player':
		player = body

