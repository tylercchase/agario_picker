class_name MovieBot
extends CharacterBody3D


@export var movie_name: String = ''
@export var time_to_check = 3.0
var cool_color
var speed: float = 3.0

var time_elapsed = 0.0

var target: Node3D
var direction = Vector3()
func _ready():
	%MovieLabel.text = movie_name

func _process(delta):
	time_elapsed += delta

	if target:
		direction = global_position.direction_to(target.global_position)
	velocity = direction * speed
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
	target = bodies[0]

func handle_collision(collision):
	print("I collided with ", collision.get_collider().name)
