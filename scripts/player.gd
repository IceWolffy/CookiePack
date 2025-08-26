extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_animated_sprite.play("idle")
	
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		if is_on_floor():
			_animated_sprite.play("move")
		else:
			_animated_sprite.play("idle")
	elif _animated_sprite.animation == "move":
		_animated_sprite.play("idle")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction == -1:
		_animated_sprite.flip_h = true
	if direction == 1:
		_animated_sprite.flip_h = false
		
	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	_animated_sprite.play("idle") # Replace with function body.
