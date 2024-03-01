extends Area2D

func _ready():
	var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]
	shaman_eagle.connect("shamans_attacked", self, "enable_area")

func enable_area():
	$CollisionShape2D.set_deferred("disabled", false)
