extends Control


func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if is_visible():
			hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			show()


func _on_return_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_settings_pressed() -> void:
	$Settings2.show()
