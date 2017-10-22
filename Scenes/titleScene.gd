extends TextureFrame

func _ready():
	set_process(true)
	
func _process(delta):
	if (Input.is_key_pressed(KEY_SPACE)):
		get_node("/root/globals").setScene("res://Scenes/testWorld.scn")
