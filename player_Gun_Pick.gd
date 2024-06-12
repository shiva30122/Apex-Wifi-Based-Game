extends CharacterBody2D


signal Droped(drop:bool)

@export var button : TouchScreenButton



func _enter_tree():
	
	mul.rpc()
	
	

@rpc("any_peer","call_local")
func mul():
	$"..".set_multiplayer_authority(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#connect("Droped",Drop())
	
	
	

	Hide()
	#$player_F/TouchScreenButton.hide()
	ID = get_multiplayer_authority()
	

func Drop():
	pass

@onready var player = null
@export var pick_gun = false
@export var GunAuthority = false 

@export var syncPos = Vector2(0,0)
@export var syncRot = 0

@export var gravity = 30

@onready var ID 
@onready var vis :bool
func _process(delta):
	
	#print("   ", vis)
	if ! is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
	
	#print(get_multiplayer_authority(),"    selfffffffffffffffffffff  ",get_instance_id(),"    Gravity ",is_on_floor() )
	#player
	syncPos = global_position
	syncRot = rotation_degrees
	if ! player:
		#button.hide()
		$"..".set_multiplayer_authority(0)
		$player_F/Label.text = str("Authority For Gun Famas: ", get_multiplayer_authority(),"    Gravity  ", is_on_floor())
		$".".rotation = 0
		
		

		
	if player && GunAuthority== true:#and  Input.is_action_just_pressed("ui_up"):
			
			$"..".visible = GameManager.Vissible
				#$".".set_multiplayer_authority(player.get_multiplayer_authority())
			
			if player.is_multiplayer_authority():
				Hide()
			Gun_Pucked.rpc()
			#$".".global_position = player.global_position
			player
			
			
				#pick_gun = true
				#$Area2D/Coll.disabled = true
				#$".".position = player.position
				##get_tree().create_timer(22).timeout
			if player.health <= 0:
				player = null
				GunDrop.rpc()
				Hide()
#
					#
				#
				#
				##$"..".position = player.position
				#$Label.text = str("Authority For Gun Famas: ", player.get_node(".").get_multiplayer_authority())
				
				
				#if player.health <= 0:
					#pick_gun = false
					##self.set_multiplayer_authority(0)
					#$Area2D/Coll.disabled = false

	

var buttonplayer
func _on_area_2d_body_entered(body):
	if body.has_method("Playerr"):
		
		
		
		if body.is_multiplayer_authority():
			Show()
		
		#buttonplayer = body.get_node("CanvasLayer/GunPick")
		#buttonplayer.show()
		#Show.rpc()
		#var UiId = body.get_multiplayer_authority()
		#if UiId:
			#Show()
		#$player_F/TouchScreenButton.show()
		#Show.rpc()
		#if Input.is_action_just_pressed("ui_up"):
		player = body
		if GunAuthority == false:
			var pid = player.multiplayer.get_remote_sender_id()
			#if body.is_multiplayer_authority():
			#	Hide()
			#$player_F/TouchScreenButton.show()
		
		#if GunAuthority:
		
			#var Authority = body.get_multiplayer_authority()
			#set_multiplayer_authority(Authority)
			#pick_gun = true
			#$Area2D/Coll.disabled = true
			#GunAuthority = false

func _on_area_2d_body_exited(body):
	if body.has_method("Playerr"):
		 
	
		if body.is_multiplayer_authority():
		
			Hide()
	#Hide()
	
	#$player_F/TouchScreenButton.hide()
	

func Gun_Pick():
	return true

func _on_touch_screen_button_pressed() -> void:
	
		GunAuthority = true
		

var id : int

"       /////////////////////    I Spent 5 Days To Complete Gun System .....            ////////////             "

@rpc("any_peer","call_local","reliable",2)
func Gun_Pucked():
		
		$"..".visible = GameManager.Vissible
		
		$"..".set_multiplayer_authority(player.get_multiplayer_authority())
		$player_F/MultiplayerSynchronizer.set_multiplayer_authority(player.get_multiplayer_authority())
		call_deferred("POS")
		call_deferred("is_multiplayer_authority")
		#$".".glbal_position = player.global_position
		$player_F/Label.text = str("Authority For Gun Famas: ", player.get_multiplayer_authority() , "  Gravity ",is_on_floor() )
		#print($"..".get_multiplayer_authority(),"             RPC  Authority .....")
		#$player_F/Area2D/Coll.disabled = true
		$Area2D.monitoring = false
		$Coll.disabled = true
		gravity = 0
		

@rpc("any_peer","call_local","reliable",2)
func GunDrop():
	#Hide.rpc()
	$"..".rotation = 0
	GunAuthority = false
	$"..".set_multiplayer_authority(0)
	$Area2D.monitoring = true
	$Coll.disabled = false
	gravity = 30
	$"..".global_position = $"..".global_position
	

#@rpc("call_local")
func Hide():
	vis = false
	button.hide()
	

#@rpc("any_peer")
func Show():
		vis =true
		#var buttonplayer = body.get_node("CanvasLayer/GunPick")
		button.show()
	
	#button.show()

func POS():
	if player:
		button.hide()
		var gun_rotation_node = player.get_node("GunRotation/BulletSpawn")
		
		$"..".global_position = gun_rotation_node.global_position
		$".".global_position = $"..".global_position
		
		$"..".global_rotation_degrees = gun_rotation_node.global_rotation_degrees
		$".".global_rotation_degrees = $"..".global_rotation_degrees
		
		
	
		#$".".global_rotation_degrees = gun_rotation_node.global_rotation_degrees
	#$".".look_at(get_viewport().get_mouse_position())
	#var joy = player.get_node("CanvasLayer/Right")
	



