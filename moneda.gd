extends Area2D


func _on_moneda_body_entered(body):
	if body.name == "Player" or body.name == "Player2":
		body.moeda()
		queue_free()
	
	