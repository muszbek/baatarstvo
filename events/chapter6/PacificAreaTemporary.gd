extends Area2D

func _ready():
	var atabeg = get_tree().get_nodes_in_group("atabeg")[-1]
	atabeg.connect("atabeg_exited", self, "disable_area")

func disable_area():
	$CollisionShape2D.set_deferred("disabled", true)
