class_name MovieBot
extends CharacterBody3D


@export var movie_name: String = ''
@export var time_to_check = 3.0
var cool_color
var speed: float = 3.0

var time_elapsed = 0.0

var target: Node3D
var direction = Vector3()

var total_food_value = 1

var gravity = Vector3(0,-9.8,0)

func _ready():
	%MovieLabel.text = movie_name

func _process(delta):
	time_elapsed += delta

	if is_instance_valid(target):
		direction = global_position.direction_to(target.global_position)
	velocity = direction * speed + gravity
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		handle_collision(collision)

	if direction.x != 0:
		look_at(global_transform.origin + direction*10, Vector3.UP)

	if time_elapsed < time_to_check:
		return
	time_elapsed -= time_to_check
	if not target:
		direction = Vector3(randf_range(-1.0,1.0),0,randf_range(-1.0,1.0))

	var bodies = %DetectionArea.get_overlapping_bodies()
	if bodies.size() == 0:
		return
	for body in bodies:
		if body is Food:
			target = body
			return
		elif body is MovieBot and body.total_food_value <= total_food_value:
			target = body
			return

func handle_collision(collision):
	if collision.get_collider() is Food:
		var food_value = collision.get_collider().food_value
		total_food_value += food_value
		scale = Vector3(total_food_value,total_food_value,total_food_value)
		collision.get_collider().queue_free()
	if collision.get_collider() is MovieBot:
		var other_bot_value = collision.get_collider().total_food_value
		if other_bot_value < total_food_value:
			total_food_value += other_bot_value - 0.99
			scale = Vector3(total_food_value,total_food_value,total_food_value)
			collision.get_collider().queue_free()
