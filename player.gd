extends KinematicBody2D

onready var world = get_tree().get_current_scene()

var gravity = -50

var vel = Vector2(0, 0)
var acc = 10
var max_speed = 50

func _ready():
	pass


func _process(_delta):
	control()
	animation_manager()
	
	vel = move_and_slide(vel)


var is_walk = 0
func control():
	if Input.is_action_pressed("ui_right"):
		vel.x = min(vel.x+acc, max_speed)
	elif Input.is_action_pressed("ui_left"):
		vel.x = max(vel.x-acc, -max_speed)
	else: 
		vel.x = lerp(vel.x, 0, 0.2)
	if Input.is_action_pressed("ui_down"):
		vel.y = min(vel.y+acc, max_speed)
	elif Input.is_action_pressed("ui_up"):
		vel.y = max(vel.y-acc, -max_speed)
	else: 
		vel.y = lerp(vel.y, 0, 0.2)


func animation_manager():
	pass


func _on_foot_body_entered(body):
	world.area = body
	if body.collision_layer == 4:
		world.flag_player = 1 # Grass
	elif body.collision_layer == 8:
		world.flag_player = 2 # Soil
	elif body.collision_layer == 16:
		world.flag_player = 3 # Plantable
