extends Node2D

var bullet_scene = preload("res://Scenes/minigun_bullet.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var cooldown = 0.1

func _ready() -> void:
	PlayerStats.weapon_cooldown = cooldown
	PlayerStats.weapon = self
	PlayerStats.weapon_file = "res://Scenes/minigun.tscn"
	PlayerStats.just_press = false

func _process(delta: float) -> void:
	if PlayerStats.weapon_flip:
		rotation = PI
		$Sprite2D.flip_v = true
	else:
		rotation = 0
		$Sprite2D.flip_v = false
		
func shoot(direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = direction
	get_parent().get_parent().add_child(bullet)
	audio_stream_player.play()
