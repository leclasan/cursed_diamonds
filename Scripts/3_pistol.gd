extends Node2D

var bullet_scene = preload("res://Scenes/3_bullet.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var cooldown = 1.0

func _ready() -> void:
	PlayerStats.weapon_cooldown = cooldown
	PlayerStats.weapon = self
	PlayerStats.weapon_file = "res://Scenes/3_pistol.tscn"
	PlayerStats.just_press = true

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
	get_tree().get_root().add_child(bullet)
	bullet = bullet_scene.instantiate()
	bullet.position = global_position +  Vector2(8,5)
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
	bullet = bullet_scene.instantiate()
	bullet.position = global_position + Vector2(16,10)
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
	audio_stream_player.play()
