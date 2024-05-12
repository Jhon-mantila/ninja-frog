extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var appeared: bool = false
var leaved_floor : bool = false
var had_jump: bool = false

func _ready():
	$animacionesFrog.play("appear")

func _physics_process(delta):
	
	if is_on_floor():
		leaved_floor = false
		had_jump = false
	
	# Add the gravity.
	if not is_on_floor():
		if not leaved_floor:
			$coyote_timer.start()
			leaved_floor = true
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and right_to_jump():
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

func right_to_jump():
	if had_jump: return false
	if is_on_floor(): 
		had_jump = true
		return true
	elif not $coyote_timer.is_stopped(): 
		had_jump = true
		return true
################
# Señales 
################
func _on_animaciones_frog_animation_finished():
	print($animacionesFrog.animation)
	if $animacionesFrog.animation == "appear":
		appeared = true # Replace with function body.

func _on_coyote_timer_timeout():
	print("Inicio contador boom!")
	print($coyote_timer.wait_time)
	
