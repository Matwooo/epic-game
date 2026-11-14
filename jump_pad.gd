extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "JUMP_PAD_HEIGHT" in body:
		body.velocity.y = +body.JUMP_PAD_HEIGHT
		
		if "jump_count" in body:
			body.jump_count = 0
		
		$Sprite2D/AnimationPlayer.play("activate")
