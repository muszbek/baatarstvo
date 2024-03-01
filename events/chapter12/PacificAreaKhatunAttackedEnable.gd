extends Area2D

func on_khatun_attacked():
	$CollisionShape2D.set_deferred("disabled", false)
