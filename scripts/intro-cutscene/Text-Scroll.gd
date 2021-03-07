extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0
var prev = -1
var nodes = 0
var delay = 10

var default_separation = 1
var separation = default_separation

var container
var top

# Called when the node enters the scene tree for the first time.
func _ready():
	container = get_node("VBoxContainer")
	top = get_node("VBoxContainer/Text")

func _process(_delta):
	counter += 1
	nodes = counter / delay
	_add_node()

func _add_node():
	
	if nodes != prev and nodes < 50:
		container.add_constant_override("separation", default_separation)
		separation = default_separation
		
		var new = Label.new()
		new.text = str(nodes)
		
		container.add_child_below_node(top, new)
	else:
		separation += 1
		container.add_constant_override("separation", separation)
		
	prev = nodes
