extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var allow_animation: bool = false
var leaved_floor : bool = false
var had_jump: bool = false
var max_jump: int = 2
var count_jump: int = 0
var double_jump: bool = false
var ray_cast_dimension: float = 11.5
var direction
var stuck_on_wall: bool = false
var healt: int = 100
var fruitCount: int = 0

func _ready():
	$animacionesFrog.play("appear")
	$rayCast_wallJump.target_position.x = ray_cast_dimension

func _physics_process(delta):
	
	if is_on_floor():
		#usar las variables para resetiar las que controlan el salto
		leaved_floor = false
		had_jump = false
		count_jump = 0
	
	# Add the gravity.
	if not is_on_floor():
		if not leaved_floor:
			$coyote_timer.start()
			leaved_floor = true
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and right_to_jump():
		if count_jump == 1:
			double_jump = true
		count_jump += 1
		
		#print(count_jump)
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#print(velocity)
	if $rayCast_wallJump.get_collider():
		if $rayCast_wallJump.get_collider().is_in_group("wall_jump"):
			if velocity.y > 0:
				velocity.y = 0
				#resetemos el conteno de salto para que me deje saltar cuando este pegado a la pared
				count_jump = 0
				stuck_on_wall = true
				#print("Tocando la zona amarilla")
			#print($rayCast_wallJump.get_collider())
		else: stuck_on_wall = false
	else: stuck_on_wall = false
			
	
	move_and_slide()
	decide_animation()
	

	
func decide_animation():
	
	if direction < 0:
		$animacionesFrog.flip_h = true
		$rayCast_wallJump.target_position.x = -ray_cast_dimension
		#print($rayCast_wallJump.target_position.x)
	elif direction > 0:
		$animacionesFrog.flip_h = false
		$rayCast_wallJump.target_position.x = ray_cast_dimension
		#print($rayCast_wallJump.target_position.x)

	#print("permitir salto: ", allow_animation)
	if double_jump:
		double_jump = false
		allow_animation = false
		#$animacionesFrog.flip_h = velocity.x < 0
		$animacionesFrog.play("double_jump")
	
	if not allow_animation : return
	
	if stuck_on_wall:
		$animacionesFrog.play("wall_jump")
		
	else:
	
		if velocity.x == 0:
			#idle
			$animacionesFrog.play("Idle")
		elif velocity.x < 0:
			#izquierda 
			$animacionesFrog.play("run")
		elif velocity.x > 0:
			#derecha
			$animacionesFrog.play("run")

		#Eje de las Y
		if velocity.y > 0:
			#Callendo
			$animacionesFrog.play("jump_down")
		if velocity.y < 0:
			#Salto
			$animacionesFrog.play("jump_up")


func collectFruit(fruitType: String):
	var auxString = fruitType + "Points"
	print("Recolete: ", fruitType, " variable: auxString: ", auxString, " Valor: ", GeneralRules[auxString])
	var gainedPoint = GeneralRules[auxString]
	fruitCount += gainedPoint
	print("Puntos recolectados: ",fruitCount)
	
func right_to_jump():
	if had_jump: 
		if count_jump < max_jump: return true
		else: return false
	if is_on_floor() || stuck_on_wall: 
		had_jump = true
		return true
	elif not $coyote_timer.is_stopped(): 
		had_jump = true
		return true
################
# Señales 
################
func _on_animaciones_frog_animation_finished():
	#print($animacionesFrog.animation)
	if $animacionesFrog.animation == "appear" || $animacionesFrog.animation == "double_jump":
		allow_animation = true # Replace with function body.

func _on_coyote_timer_timeout():
	#print("Inicio contador boom!")
	#print($coyote_timer.wait_time)
	pass
	
func _on_damage_detection_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#print(area_rid)
	print(area.name) # muestra el nombre del area que collisiono
	healt -= 10
	#print("Daño detectado: ", healt)
