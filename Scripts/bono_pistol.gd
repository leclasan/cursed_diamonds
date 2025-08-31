extends Node2D

var bullet_scene = preload("res://Scenes/basic_bullet.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var cooldown = 0.333

func _ready() -> void:
	PlayerStats.weapon_cooldown = cooldown
	PlayerStats.weapon = self
	PlayerStats.weapon_file = "res://Scenes/bonus_pistol.tscn"
	PlayerStats.just_press = true

func _process(delta: float) -> void:
	pass
	
func shoot(direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = 1
	get_parent().get_parent().add_child(bullet)
	bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = -1
	get_parent().get_parent().add_child(bullet)
	audio_stream_player.play()
