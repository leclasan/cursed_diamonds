extends Node

var lives = 3

var weapon 
var weapon_cooldown = 0.333
var weapon_file
var weapon_flip 

var lose_scene = preload("res://Scenes/lose.tscn")

func _process(delta: float) -> void:
	if lives <= 0:
		get_tree().change_scene_to_packed(lose_scene)
		lives = 3
