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

const speed = 100

var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta): #Captura el input de movimiento y lo ejectuta. 
	if Input.is_action_pressed("ui_right"):
		current_dir = "right" #Le asignamos a Current_dir hacia donde el sprite deberia mirar.
		play_anim(1) #Ejecuta la función play_anim y le mandamos el (1) para significar que nos estamos moviendo.
		velocity.x = speed #En este momento solo se puede mover en direcciones especificas. Averiguar diagonales.
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0	
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed	
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed	
	else:
		play_anim(0) #Ejecuta la función play_anim y le mandamos el (0) para significar que no nos estamos moviendo.
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(movement): #Maneja las animaciones.
	var direction = current_dir
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false #Si estuviera True nos permite mirror la animación
		if movement == 1:
			animation.play("side_walking")
		elif movement == 0:
			animation.play("side_idle")

	if direction == "left":
		animation.flip_h = true #Si estuviera True nos permite mirror la animación
		if movement == 1:
			animation.play("side_walking")
		elif movement == 0:
			animation.play("side_idle")

	if direction == "down":
		animation.flip_h = false #Si estuviera True nos permite mirror la animación
		if movement == 1:
			animation.play("front_walking")
		elif movement == 0:
			animation.play("front_idle")

	if direction == "up":
		animation.flip_h = false #Si estuviera True nos permite mirror la animación
		if movement == 1:
			animation.play("back_walking")
		elif movement == 0:
			animation.play("back_idle")
