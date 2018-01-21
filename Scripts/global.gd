extends Node2D

var currentScene = null

# Inventory of user
# Is empty in the beggining
var inventory = []
func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	
func setScene(scene):
	currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	
#func createItem(_Name, _Description, _Sprite, _ID):
#	return { Name: _Name, Description: _Description, Sprite: _Sprite, ID: _ID }
#	
#func hasItem(ID):
#	for item in inventory:
#		if (item.id == ID):
#			return true
#	return false