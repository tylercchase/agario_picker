extends Node3D

@export var bot_scene: PackedScene
var movie_names = []
var movie_bots = []
func _ready():
	var file = FileAccess.open("res://movie_list.txt", FileAccess.READ)
	var counter = 0
	while not file.eof_reached():
		var line = file.get_line()
		movie_names.push_back(line)
	movie_names.shuffle()
	for movie in movie_names:
		var new_ball = bot_scene.instantiate()
		new_ball.movie_name = movie
		add_child(new_ball)
		var spacing = counter % 50 * 0.5 + (randf() * 2.0 - 1.0)
		var row = floor(counter / 50)
		new_ball.global_position = Vector3( -20 + spacing * 2, 10,-20 + row * 2 + (randf() * 2.0 - 1.0))
		counter += 1
		movie_bots.push_back(new_ball)
