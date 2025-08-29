extends Node2D

@onready var label: Label = $Control/Label
@onready var timer: Timer = $Timer

var points = 0 #points added because enmy tries to give points to its parent and if not it gives an error 

var state = STATES.MOVING
enum STATES {MOVING, JUMPING, SHOOTING, DIAMOND, PAUSE}

var first_movement = true
var first_jump = true
var first_pause = true
var has_paused = false

func _ready() -> void:
	label.text = "Move with arrow keys"



func _process(delta: float) -> void:
	match state:
		STATES.MOVING:
			if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
				if first_movement:
					first_movement = false
					timer.start()
		STATES.JUMPING:
			if Input.is_action_just_pressed("jump"):
				if first_jump:
					first_jump = false
					timer.start()
		STATES.SHOOTING:
			pass
		STATES.DIAMOND:
			pass
		STATES.PAUSE:
			if get_tree().paused == true :
				has_paused = true
			if get_tree().paused == false and first_pause and has_paused:
				next_state()
				first_pause = false

func next_state():
	match state:
		STATES.MOVING:
			state = STATES.JUMPING
			label.text = "Jump with z, press z for low jump, push z for long jump"
		STATES.JUMPING:
			state = STATES.SHOOTING
			label.text = "Shoot with x, kill the enemy (killing a enemy grants 1 point)"
			var enemi = preload("res://Scenes/base_enemy.tscn").instantiate()
			enemi.position = Vector2(791, 200)
			enemi.connect("tree_exited", next_state)
			add_child(enemi)
		STATES.SHOOTING:
			state = STATES.DIAMOND
			label.text = "Get the diamond to get 50 points and change weapon"
			var diamond = preload("res://Scenes/diamond.tscn").instantiate()
			diamond.position = Vector2(572, 407)
			diamond.connect("tree_exited", next_state)
			add_child(diamond)
		STATES.DIAMOND:
			state = STATES.PAUSE
			label.text = "Press esc or p to open pause menu"
		STATES.PAUSE:
			label.text = "Tutorial finished, now you are ready to play the game"
			await get_tree().create_timer(5).timeout
			for i in get_child_count():
				get_child(0).queue_free()
			get_tree().change_scene_to_file("res://Scenes/start.tscn")

func spawn_diamond():
	pass # created this function so the diamond doesn't give any errors when colected
