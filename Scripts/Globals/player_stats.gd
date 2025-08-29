extends Node

var lives = 3

var color_list = ["beish", "blue", "green", "pink", "yellow"]
var color = "green"

var weapon 
var weapon_cooldown = 0.333
var weapon_file = "res://Scenes/pistol.tscn"
var weapon_flip 
var just_press = true

var points = 0

var has_powerup = false

func _process(delta: float) -> void:
	if lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/lose.tscn")



func reset():
	weapon_file =  "res://Scenes/pistol.tscn"
	points = 0
	lives = 3
