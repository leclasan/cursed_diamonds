extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var weapon_list = ["res://Scenes/pistol.tscn", "res://Scenes/3_pistol.tscn", "res://Scenes/minigun.tscn","res://Scenes/banana_boomerang.tscn" ]

var speed = 300.0
var jump = -300
var stairs_velocity = 100

var jump_state
enum JUMP_STATES {FALLING, JUMPPRESSED, INITIALJUMP, FLOOR, STAIRS, UPSTAIRS, DOWNSTAIRS}
var jump_timer_seconds = 0.3

var bullet_direction = 1

var can_shoot = true

var stairs = false

func _ready() -> void:
	var resource = load(PlayerStats.weapon_file).instantiate()
	add_child(resource)

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		bullet_direction = direction
		velocity.x = direction * speed
		if animated_sprite_2d.animation != "running":
			animated_sprite_2d.play("running")
	else:
		if animated_sprite_2d.animation != "normal":
			animated_sprite_2d.play("normal")
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if stairs:
		if Input.is_action_pressed("move_up"):
			jump_state = JUMP_STATES.UPSTAIRS
		elif Input.is_action_pressed("move_down"):
			jump_state = JUMP_STATES.DOWNSTAIRS
		else:
			jump_state = JUMP_STATES.STAIRS
	
	else:
		if is_on_floor():
			jump_state = JUMP_STATES.FLOOR
		
		if not is_on_floor() and jump_state != JUMP_STATES.JUMPPRESSED :
			jump_state = JUMP_STATES.FALLING
			if animated_sprite_2d.animation != "normal":
				animated_sprite_2d.play("normal")
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump_state = JUMP_STATES.INITIALJUMP
		elif Input.is_action_just_released("jump"):
			jump_state = JUMP_STATES.FALLING
	
	sort_y_movement(delta)
	
	if PlayerStats.just_press:
		if Input.is_action_just_pressed("shoot"):
			if can_shoot:
				PlayerStats.weapon.shoot(bullet_direction)
				can_shoot = false
				$CanShootTimer.start(PlayerStats.weapon_cooldown)
	else:
		if Input.is_action_pressed("shoot"):
			if can_shoot:
				PlayerStats.weapon.shoot(bullet_direction)
				can_shoot = false
				$CanShootTimer.start(PlayerStats.weapon_cooldown)
	
	move_and_slide()
	
	if position.x > get_viewport_rect().size.x :
		position.x = 0
	elif position.x < 0:
		position.x = get_viewport_rect().size.x
	
	if position.y > get_viewport_rect().size.y :
		position.y = 0
	elif position.y < 0:
		position.y = get_viewport_rect().size.y
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
		PlayerStats.weapon_flip = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false
		PlayerStats.weapon_flip = true

func sort_y_movement(delta):
	match jump_state:
		JUMP_STATES.FALLING:
			velocity += WorldStats.gravity * delta
		JUMP_STATES.INITIALJUMP:
			velocity.y = jump 
			jump_state = JUMP_STATES.JUMPPRESSED
			get_tree().create_timer(jump_timer_seconds).timeout.connect(on_jump_timer_timeout)
		JUMP_STATES.JUMPPRESSED:
			velocity += (WorldStats.gravity/8) * delta
		JUMP_STATES.FLOOR:
			pass
		JUMP_STATES.STAIRS:
			velocity.y = 0
		JUMP_STATES.UPSTAIRS:
			velocity.y = -stairs_velocity
		JUMP_STATES.DOWNSTAIRS:
			velocity.y = stairs_velocity

func on_jump_timer_timeout():
	if jump_state == JUMP_STATES.JUMPPRESSED:
		jump_state = JUMP_STATES.FALLING


func _on_can_shoot_timer_timeout() -> void:
	can_shoot = true

func change_weapon():
	var repeat = true
	var random_weapon
	while repeat:
		random_weapon = weapon_list.pick_random()
		if random_weapon != PlayerStats.weapon_file:
			repeat = false
	PlayerStats.weapon.queue_free()
	var resource = load(random_weapon).instantiate()
	add_child(resource)


func _on_detect_body_entered(body: Node2D) -> void:
	stairs = true


func _on_detect_body_exited(body: Node2D) -> void:
	stairs = false
