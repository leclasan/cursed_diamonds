extends Node2D

@onready var life_3: AnimatedSprite2D = $Life3
@onready var life_2: AnimatedSprite2D = $Life2
@onready var life_1: AnimatedSprite2D = $Life1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerStats.lives < 3:
		life_3.set_animation("empty")
	if PlayerStats.lives < 2:
		life_2.set_animation("empty")
	if PlayerStats.lives < 1:
		life_1.set_animation("empty")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerStats.lives < 3:
		life_3.set_animation("empty")
	if PlayerStats.lives < 2:
		life_2.set_animation("empty")
	if PlayerStats.lives < 1:
		life_1.set_animation("empty")
