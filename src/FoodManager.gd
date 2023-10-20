extends Node3D

@export var food_scene: PackedScene
var time_elapsed = 0.0
var time_to_spawn = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	if time_elapsed < time_to_spawn:
		return
	time_elapsed -= time_to_spawn
	var new_food = food_scene.instantiate()
	add_child(new_food)
	new_food.global_position = Vector3(randf_range(-50.0,50.0),0.0,randf_range(-50.0,50.0))

	pass
