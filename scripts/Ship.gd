#warnings-disable

extends KinematicBody2D


var speed = 10
var speed_cap = 200
var friction = 2
var velocity = Vector2()

var fuel_label = null
var part_label = null

var oil1_in = false
var oil2_in = false
var oil3_in = false
var pp_in = false
var gp_in = false

func _ready():
	fuel_label = get_node("UI/Bar/marg/Bar/Fuel/Fuel")
	fuel_label.text = str(load_fuel())
	
	part_label = get_node("UI/Bar/marg/Bar/Parts/Parts")
	part_label.text = str(load_parts())
	
	
	get_node('../Planets/Oil-Planet-1/Area2D').connect("body_entered", self, 'oil1_entered')
	get_node('../Planets/Oil-Planet-1/Area2D').connect("body_exited", self, 'oil1_exited')
	
	get_node('../Planets/Oil-Planet-2/Area2D').connect("body_entered", self, 'oil2_entered')
	get_node('../Planets/Oil-Planet-2/Area2D').connect("body_exited", self, 'oil2_exited')
	
	get_node('../Planets/Oil-Planet-3/Area2D').connect("body_entered", self, 'oil3_entered')
	get_node('../Planets/Oil-Planet-3/Area2D').connect("body_exited", self, 'oil3_exited')
	
	get_node('../Planets/Pink-Planet/Area2D').connect("body_entered", self, 'pp_entered')
	get_node('../Planets/Pink-Planet/Area2D').connect("body_exited", self, 'pp_exited')
	
	get_node('../Planets/Green-Planet/Area2D').connect("body_entered", self, 'gp_entered')
	get_node('../Planets/Green-Planet/Area2D').connect("body_exited", self, 'gp_exited')


func oil1_entered(player):
	if player == self:
		oil1_in = true

func oil1_exited(_player):
	oil1_in = false

func oil2_entered(player):
	if player == self:
		oil2_in = true

func oil2_exited(_player):
	oil2_in = false
	
func oil3_entered(player):
	if player == self:
		oil3_in = true

func oil3_exited(_player):
	oil3_in = false

func pp_entered(player):
	if player == self:
		pp_in = true

func pp_exited(_player):
	pp_in = false
	
func gp_entered(player):
	if player == self:
		gp_in = true

func gp_exited(_player):
	gp_in = false

func _process(delta):
	
	check_input()
	
	apply_friction()
	
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
			
	if Input.is_action_just_pressed("skip_dialogue"):
		if oil1_in:
			get_tree().change_scene("res://scenes/random-planet/Main.tscn")
		if oil2_in:
			get_tree().change_scene("res://scenes/random-planet/Main.tscn")
		if oil3_in:
			get_tree().change_scene("res://scenes/random-planet/Main.tscn")
		if pp_in:
			get_tree().change_scene("res://scenes/planet2/Main.tscn")
		if gp_in:
			get_tree().change_scene("res://scenes/planet1/Main.tscn")


func load_data():
	var f = File.new()
	f.open('user://data.save', File.READ)
	var ret = f.get_as_text()
	return ret
	
func load_fuel():
	return int(load_data().substr(0, 3))
	
func load_parts():
	return int(load_data().substr(3, 6))
