extends Node2D


@export var Max_Ammo_for_Gun : int
@export var Gun_Max_Ammo : int
@export var Current_ammo : int

@export var Bullet_Delay : float
@export var Current_bullet_Dmage : int
@export var Reaload_Time : float

@export var Mark : Node2D
@export var Gun_Position : Node2D

@onready var Can_Shoot : bool
@onready var Multiplayer

#@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
var root
func _ready():


	$Timer.wait_time = Bullet_Delay
	Can_Shoot = true
	
	Multiplayer = $MultiplayerSpawner
	$Shoot_Delay.wait_time = Reaload_Time
	#set_multiplayer_authority(str(name).to_int())
	#root = get_tree().root.get_multiplayer_authority()
	#print("RRRRRRRRRRRRRRRRRRRRR",root)







var Click = false


func _process(delta):
	
	if is_multiplayer_authority():
		
			
		$"../Label".text = str("     \n            Authority for Gun  ",get_multiplayer_authority())
		

		
		#$".".queue_free()
		#print(" Pick_Uped Gun !>>")
		#if Input.is_action_pressed("ui_up") && Current_ammo>0 && Can_Shoot == true :
		if GameManager.Fire == true && Current_ammo>0 && Can_Shoot == true :
			
			print("Shooter ID   : ",multiplayer.get_unique_id())
			Current_ammo -=1
			#print("  Total Ammo  := ",Max_Ammo_for_Gun ,"  Current Ammo :=",Current_ammo, "  Max Ammo :=",Gun_Max_Ammo)
			fire.rpc()
			Fire_Self()
			Can_Shoot = false
			$Timer.start()
			print("Can Shoot False  ",Can_Shoot)
		#if Current_ammo<=0 && Max_Ammo_for_Gun > 0  or  Current_ammo<=0 && Max_Ammo_for_Gun > 0 and Input.is_action_just_pressed("Reload"):
			#
			##await get_tree().create_timer(Reaload_Time).timeout 
			#Gun_Max_Ammo+=Current_ammo
			#Max_Ammo_for_Gun -= Gun_Max_Ammo
			##print("  Max Ammo  := ",Max_Ammo_for_Gun ,"  Current Ammo :=",Current_ammo)
			#
		#if  Max_Ammo_for_Gun > 0 and Gun_Max_Ammo > 0 and Input.is_action_just_pressed("Reload"):
			#
			##await get_tree().create_timer(Reaload_Time).timeout 
			#Gun_Max_Ammo+=Current_ammo
			#Max_Ammo_for_Gun -= Gun_Max_Ammo
			##print("  Max Ammo  := ",Max_Ammo_for_Gun ,"  Current Ammo :=",Current_ammo)

		if Current_ammo != Gun_Max_Ammo and Max_Ammo_for_Gun > 0 and Input.is_action_just_pressed("Reload") and Reaload == true:
			Reaload = false
			$Shoot_Delay.start()

		if Current_ammo <= 0 and Max_Ammo_for_Gun > 0 :
			Reaload = false
			$Shoot_Delay.start()
			#await get_tree().create_timer(Reaload_Time).timeout 
			Max_Ammo_for_Gun -= Gun_Max_Ammo
			Current_ammo = Gun_Max_Ammo
			
			if Max_Ammo_for_Gun<=0:
				Max_Ammo_for_Gun = 0
			# Reset current ammo to the maximum ammo for the gun
			#print("  Max Ammo  := ",Max_Ammo_for_Gun ,"  Current Ammo :=",Current_ammo)
		#$Label2.text = str(" Authority Cureent Gun : ", root)
	$"../Label".text = str("  Total Ammo  :=  ",Max_Ammo_for_Gun ,"   Current Ammo :=",Current_ammo, "    Max Ammo :=",Gun_Max_Ammo)



@export var RPCBullet : PackedScene
@export var  PlayerBullet :PackedScene

@rpc("any_peer","call_local","reliable")
func fire():
	
	
	
	var bb = RPCBullet.instantiate()
	bb.set_multiplayer_authority(get_multiplayer_authority())
	bb.global_position = Mark.global_position
	bb.global_transform = Mark.global_transform
	bb.damage = Current_bullet_Dmage
	Multiplayer.add_child(bb)


func Fire_Self():
	var b = PlayerBullet.instantiate()
	b.global_position = Mark.global_position
	b.global_transform = Mark.global_transform
	b.damage = Current_bullet_Dmage
	
	Multiplayer.add_child(b)





func _on_timer_timeout():
	Can_Shoot = true
	#print("Can Shoot True  ",Can_Shoot)
	$Timer.stop()
	
	pass # Replace with function body.



@onready var Reaload = true

func _on_shoot_delay_timeout() -> void:
	Reaload = true
	Max_Ammo_for_Gun -= Gun_Max_Ammo
	Current_ammo = Gun_Max_Ammo
	pass # Replace with function body.
