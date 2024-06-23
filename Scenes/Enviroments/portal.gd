extends Node2D

#var send_ninja_to = Vector2()
var otroPortal
# Called when the node enters the scene tree for the first time.

@export var grupo_portal = 1
var permiso = true:
	set(value):
		if permiso:
			$Timer.start()
		permiso = value
		

func _ready():
	$AnimatedSprite2D.visible = false
	var portals = get_tree().get_nodes_in_group("portal")
	for i in range (portals.size()):
		if portals[i].position != position:
			if portals[i].grupo_portal == self.grupo_portal:
				print("El portal con posición: ", position, " ha detetado el otro portal con posición: ", portals[i].position)
				otroPortal = portals[i]
	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_teletransport_area_entered(area):
	if area.get_parent().is_in_group("ninja") && permiso:
		print(area.get_parent().position)
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("on")
		area.get_parent().position = otroPortal.position
		otroPortal.permiso = false
		print("hola ninja")
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.visible = false
	pass # Replace with function body.

func _on_timer_timeout():
	permiso = true
	pass # Replace with function body.
