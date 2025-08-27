extends Control

@export var win = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if win:
		$Label.text = "YOU WON WITH " + str(PlayerStats.points) + " POINTS"
	else:
		$Label.text = "YOU LOST WITH " + str(PlayerStats.points) + " POINTS"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_0.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
