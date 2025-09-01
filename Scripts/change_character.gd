extends Control

@onready var label: Label = $Label
var left_pressed = false
var right_pressed = false

func _ready() -> void:
	label.text = PlayerStats.color

func _process(delta: float) -> void:
	if left_pressed:
		var color_index = PlayerStats.color_list.find(PlayerStats.color)
		if color_index == 0:
			color_index = PlayerStats.color_list.size()
		PlayerStats.color = PlayerStats.color_list.get(color_index - 1)
		left_pressed = false
		print(PlayerStats.color_list.get(color_index - 1))
	elif right_pressed:
		var color_index = PlayerStats.color_list.find(PlayerStats.color)
		if color_index == PlayerStats.color_list.size() -1 :
			color_index = -1
		PlayerStats.color = PlayerStats.color_list.get(color_index + 1)
		right_pressed = false
	label.text = PlayerStats.color

func _on_button_left_pressed() -> void:
	left_pressed = true

func _on_button_right_pressed() -> void:
	right_pressed = true


func _on_focus_entered() -> void:
	$ButtonLeft.grab_focus()
