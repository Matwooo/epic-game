extends CharacterBody2D

@onready var player: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 750.0
const JUMP_VELOCITY = -875.0
const JUMP_PAD_HEIGHT: float = -1800.0

var jump_count = 0
var max_jumps = 2

func _physics_process(delta: float) -> void:
	# Reset jump count when grounded, otherwise apply gravity.
	if is_on_floor():
		jump_count = 0
	else:
		velocity += get_gravity() * delta

	# Handle single and double jumps.
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		if jump_count == 2:
			player.play("spin")


	# Handle horizontal movement.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip sprite based on direction.
	if velocity.x > 0:
		player.flip_h = true
	elif velocity.x < 0:
		player.flip_h = false
		 
	# Update animations.
	if not jump_count == 2:
		if not is_on_floor():
			player.play("jump")
		elif velocity.x == 0:
			player.play("idle")
		else:
			player.play("moving")
	
	move_and_slide()
