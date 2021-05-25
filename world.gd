extends Node2D

onready var plantable_scene = preload("res://plantable.tscn")
onready var plant_scene = preload("res://plant.tscn")
onready var grass_scene = preload("res://grass.tscn")
onready var soil_scene = preload("res://soil.tscn")

# 1 Grass 2 Soil 3 Plantable
var flag_player = 0
var area

var count_grass = 0
var count_plant = 0

func _ready():
	# Create random terrain
	var random = RandomNumberGenerator.new()
	var world = [0, 0]
	var num
	var possibly = 50
	var area_size = 32
	
	random.randomize()

	var body
	
	for i in range(100): # 100x100
		for ii in range(100):
			num = random.randi_range(0, 100)
			
			if world[0]: possibly = 25
			else: possibly = 50
			
			if num > possibly: # Grass
				body = grass_scene.instance()
				world[0] = 1
				count_grass += 1
			else:
				body = soil_scene.instance()
				world[0] = 0
			
			body.position = Vector2(ii, i) * area_size
			add_child(body)


func _physics_process(_delta):
	control()


func control():
	if Input.is_action_just_pressed("ui_select"):
		cultivate()


func cultivate():
	if flag_player == 1:
		var plantable = plantable_scene.instance()
		plantable.position = area.position
		
		area.free()
		
		add_child(plantable)
		flag_player = 0
		
	elif flag_player == 3:
		if not area.is_plant:
			var plant = plant_scene.instance()
			
			area.add_child(plant)
			plant.global_position = area.position
			area.is_plant = true
			
			count_plant += 1
			
			if count_plant == count_grass:
				$player/Label.visible = true


func _on_Timer_timeout():
	$Label.visible = false
