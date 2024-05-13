extends Node2D
#Aros de la cadena 6px en la position.y
var floor_detected = false
var ray_cast_init_value = 36 #pixeles targt_position.y
var safe_time_out = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$ray_cast_floor_detection.target_position.y = ray_cast_init_value
	$safeTime.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not floor_detected && safe_time_out:
		$ray_cast_floor_detection.target_position.y += 6
		if $ray_cast_floor_detection.is_colliding():
			floor_detected = true
			$ray_cast_floor_detection.target_position.y -= 6
			init_spikeball()
			print("Ha tocado el suelo:" , $ray_cast_floor_detection.target_position.y)
	$SpikedBall.rotation = self.rotation

func init_spikeball():
	print("Objetivo inicial: ",$ray_cast_floor_detection.target_position.y)
	var number_of_chain =($ray_cast_floor_detection.target_position.y - ray_cast_init_value) / 6
	print("División : ", number_of_chain)
	$SpikedBall.position.y += (number_of_chain * 6)
	
	for i in range(number_of_chain):
		var new_ring = preload("res://Scenes/Enemys/one_chain.tscn").instantiate()
		new_ring.position = Vector2(0, (6*(i+1)))
		self.add_child(new_ring)
	$Animation_rotation.play("regular_move")
	pass
	
func _on_safe_time_timeout():
	safe_time_out = true

func _on_area_collision_with_map_body_entered(body):
	#print(body)
	#invierto el movimeinto de la bola
	$Animation_rotation.speed_scale *= -1
