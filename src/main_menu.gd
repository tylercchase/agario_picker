extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%StartButton.pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/main.tscn")
