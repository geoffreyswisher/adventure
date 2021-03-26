#warnings-disable

extends KinematicBody2D

var speed = 100
var distance = 300
var pos0
var velocity = Vector2(-speed, 0)

func _ready():
	pos0 = position

func _process(_delta):
	$AnimationPlayer.play("wiggle")
	
	if (velocity.x == 0):
		$Sprite.flip_h = !$Sprite.flip_h
		if $Sprite.flip_h:
			velocity.x = speed
		else:
			velocity.x = -speed
		
	if (abs(position.x - pos0.x) > distance):
		$Sprite.flip_h = !$Sprite.flip_h
		velocity.x = -velocity.x
	
	velocity = move_and_slide(velocity)
