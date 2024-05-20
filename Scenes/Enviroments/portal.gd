extends Node2D

var send_ninja_to = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.visible = false
	var portals = get_tree().get_nodes_in_group("portal")
	for i in range (portals.size()):
		if portals[i].position != position:
			print("El portal con posición: ", position, " ha detetado el otro portal con posición: ", portals[i].position)
			send_ninja_to = portals[i].position
	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_teletransport_area_entered(area):
	if area.get_parent().is_in_group("ninja"):
		print(area.get_parent().position)
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("on")
		area.get_parent().position = send_ninja_to
		print("hola ninja")
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.visible = false
	pass # Replace with function body.
