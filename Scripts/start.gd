extends Control

var start_scene = preload("res://Scenes/level_0.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion):
		PlayerStats.is_using_controller = true

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_scene)


func _on_settings_button_pressed() -> void:
	$Settings.show()
	$Settings.reset_focus()


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")

func reset_focus():
	$Button.grab_focus()
