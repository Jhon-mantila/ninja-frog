extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var appeared: bool = false

func _ready():
	$animacionesFrog.play("appear")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#print(velocity)
	move_and_slide()
	decide_animation()
	
func decide_animation():
	
	if not appeared : return
	
	if velocity.x == 0:
		#idle
		$animacionesFrog.play("Idle")
	elif velocity.x < 0:
		#izquierda 
		$animacionesFrog.flip_h = true
		$animacionesFrog.play("run")
	elif velocity.x > 0:
		#derecha
		$animacionesFrog.flip_h = false
		$animacionesFrog.play("run")

	#Eje de las Y
	if velocity.y > 0:
		#Callendo
		$animacionesFrog.play("jump_down")
	if velocity.y < 0:
		#Salto
		$animacionesFrog.play("jump_up")
		pass

func _on_animaciones_frog_animation_finished():
	print($animacionesFrog.animation)
	if $animacionesFrog.animation == "appear":
		appeared = true # Replace with function body.
