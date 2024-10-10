extends CharacterBody2D

#Código inicial de Personaje.
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

const SPEED = 100


var current_dir = "none"
var direction = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta): #Captura el input de movimiento y lo ejectuta. 
	#delta tiene el tiempo que se demoro en procesar el ultimo proceso.
	#Obtener la dirección de movimiento a partir de las entradas
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	
	
	# Normalizar el vector de dirección para mantener una velocidad constante
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
		
	# Aplicar la velocidad al personaje
	velocity = direction * SPEED
	
	play_anim()
	
	#if velocity != Vector2.ZERO:
		#
	#else:
		#play_anim(0)
	# Mover al personaje y manejar colisiones
	move_and_slide()




func play_anim(): #Maneja las animaciones.
	var animation = $AnimatedSprite2D
	print(velocity == Vector2.ZERO," ", velocity != Vector2.ZERO)
	
	if direction.y > 0:
		if velocity != Vector2.ZERO:
			animation.play("front_walking")
		elif velocity.is_equal_approx(Vector2.ZERO):
			animation.play("front_idle")
	elif direction.y < 0:
		if velocity != Vector2.ZERO:
			animation.play("back_walking")
		elif velocity.is_equal_approx(Vector2.ZERO):
			animation.play("back_idle")
	elif direction.x > 0: #Right
		if velocity != Vector2.ZERO:
			animation.flip_h = false
			animation.play("side_walking")
		elif velocity.is_equal_approx(Vector2.ZERO):
			animation.play("side_idle")
	elif direction.x < 0: #Left
		if velocity != Vector2.ZERO:
			animation.flip_h = true
			animation.play("side_walking")
		elif velocity.is_equal_approx(Vector2.ZERO):
			animation.play("side_idle")
