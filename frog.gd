extends CharacterBody2D

const SPEED = 50
var player
var chase = false

func _physics_process(delta):
	# aplica gravidade
	velocity += get_gravity() * delta

	if chase:
		if get_node("AnimatedSprite2D").animation != 'death':
			get_node("AnimatedSprite2D").play("jump")
			player = get_node("../../Player/Player")
			var direction = (player.position - self.position).normalized()

			# vira o sprite de acordo com a direção
			get_node("AnimatedSprite2D").flip_h = direction.x > 0

			# move em direção ao player
			velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != 'death':
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0

	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_node("AnimatedSprite2D").play("death")
		await  get_node("AnimatedSprite2D").animation_finished;
		self.queue_free()


func _on_player_death_body_exited(body: Node2D) -> void:
	pass
