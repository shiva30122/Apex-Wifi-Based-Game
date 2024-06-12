extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var pick = false

func _ready() -> void:
	
	pass
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	$player_F.global_position = $".".global_position 
	if not is_on_floor():# && pick == false:
		
		velocity += get_gravity() * delta
	#if pick == true:
		#if player.health<=0:
			#pick = false
	#print(get_multiplayer_authority()," rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")



	#move_and_slide()


func _on_touch_screen_button_pressed() -> void:
	pick = true
	pass # Replace with function body.

var player = null

func _on_area_2d_body_entered(body) -> void:
	player = body
	pass # Replace with function body.
