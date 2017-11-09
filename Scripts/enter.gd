extends Area2D

export var moveToScene = ""




func _on_enter_home_body_enter( body ):
	get_tree().get_root().get_node("testWorld").queue_free()
	get_tree().get_root().add_child(load(moveToScene).instance())
	
	
