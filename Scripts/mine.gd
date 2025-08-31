extends Node2D

var bullet_scene = preload("res://Scenes/mine_bullet.tscn")

var cooldown = 0.45

func _ready() -> void:
	PlayerStats.weapon_cooldown = cooldown
	PlayerStats.weapon = self
	PlayerStats.weapon_file = "res://Scenes/mine.tscn"
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
	get_parent().get_parent().add_child(bullet)
