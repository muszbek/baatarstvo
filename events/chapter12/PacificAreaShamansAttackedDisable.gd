extends Area2D

func _ready():
	var shaman_eagle = get_tree().get_nodes_in_group("shaman_eagle")[-1]
	shaman_eagle.connect("shamans_attacked", self, "disable_area")

func disable_area():
	$CollisionShape2D.set_deferred("disabled", true)
