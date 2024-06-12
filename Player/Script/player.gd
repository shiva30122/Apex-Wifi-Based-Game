extends CharacterBody2D
class_name Player

signal HealthChanged

@export var Max_health = 8
@export var health = 8
@export var Lives = 8
@export var speed : int
const SPEED = 300.0
const JUMP_VELOCITY = -200.0
@export var Right_JoyStick : Node
@export var joystick_left : Node

var gravity = 350
var syncPos = Vector2(0,0)
var syncRot = 0
@onready var bullet = preload("res://Weapons/Bullet.tscn")
@onready var self_bullet = preload("res://Weapons/PlayerBullet.tscn")
var unique_id = randi() 
@export var Score : PackedScene
@onready var id 
@onready var Current_health
@onready var move_vector := Vector2.ZERO

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

var alive = 0
func _ready():
	#var Global = get_node("/root/GameManager")
	#var id = get_multiplayer_authority()
	#Global.set_multiplayer_authority(multiplayer.get_unique_id())
	set_multiplayer_authority(str(name).to_int())
	Current_health = health
	id =multiplayer.get_unique_id()
	$Camera2D.enabled = false
	alive = GameManager.Players.size()
	joyv()

func joyv():
	if is_multiplayer_authority():
		$CanvasLayer/Left.show()
		$CanvasLayer/Right.show()

func _physics_process(delta: float) -> void:
	
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		
		
		move_vector = Vector2.ZERO
		move_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		move_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		#$CanvasLayer/GunPick.show()
		if Input.is_action_just_pressed("ui_up"):
			$CanvasLayer/GunPick.show()
			
		#else :
			#$CanvasLayer/GunPick.hide()
	#if not is_multiplayer_authority(): return
		#print($".".global_position)

		if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
			$GunRotation.global_rotation = Right_JoyStick.output.angle()
			#$GunRotation.look_at(get_viewport().get_mouse_position())
			
			$Camera2D.enabled = true
			Current_health = health
			$Label.text = str("  Remaining Lives  :  ",Lives, "   Health : ", health , "    -> ", GameManager.Players[id]["name"], " Score : ",GameManager.Players[id]["score"] )
			$Name.text = str(GameManager.Players[id]["name"],"  :",id)
			#"   Score :",GameManager.Players[id]["score"], "Name : ",

			# Add the gravity.
			
			if not is_on_floor() :
				velocity.y += 220 * delta
				
			#$GunRotation.look_at(get_viewport().get_mouse_position())
			# Handle Jump.
			#if Input.is_action_pressed("ui_accept") :#and is_on_floor():
				#velocity.y = JUMP_VELOCITY
			#print($CanvasLayer/Left.output)
			syncPos = global_position
			syncRot = rotation_degrees

				
			if Input.is_action_pressed("ui_up"):
				
				velocity.y -=12
				
				print("Shooter ID : ",multiplayer.get_unique_id())
				#if Input.is_action_pressed("ui_up") && Current_ammo>0 && Can_Shoot == true && is_multiplayer_authority() :
				print("Shooter ID  Famas : ",multiplayer.get_unique_id())
				#Current_ammo -=1
				#print("  Total Ammo  := ",Max_Ammo_for_Gun ,"  Current Ammo :=",Current_ammo, "  Max Ammo :=",Gun_Max_Ammo)
				#fire.rpc()
				#Fire_Self()
				#Can_Shoot = false
				#$Timer.start()
				#fire.rpc()
				#Fire_Self()
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			#var direction = Input.get_axis("ui_left", "ui_right")
			#if direction:
				#velocity.x = direction * SPEED
			#else:
				#velocity.x = move_toward(velocity.x, 0, SPEED)
			
				
			
		
		
			move_and_slide()
		else:
			global_position = global_position.lerp(syncPos, .5)
			rotation_degrees = lerpf(rotation_degrees, syncRot, .5)
		
		#if joystick_left and joystick_left.is_pressed:
		
		position += $CanvasLayer/Left.output * speed * delta
		
			
		if Lives<=0:
			lobby.rpc()
			lobby()
			
		"                    ANIMATION ->                               "
		
		
		if  move_vector.length() == 0 : #  and is_on_floor():
			%Animation.play("Idle")
		elif move_vector.length() > 0  and Input.is_action_pressed("ui_right") and is_on_floor():
			%Animation.play("Run")
		elif  move_vector.length() > 0  and Input.is_action_pressed("ui_left") and is_on_floor():
			%Animation.play("Run")
			
		else :
			if health >0:
				%Animation.play("Idle")
		
		if health <=0:
			position += Vector2.ZERO
			%Animation.play("Die")

			#%Animation.animation_finished.play("Idle")
		
		
		"          Flip_Player                    "
		
		if Input.is_action_pressed("GunRight") or Input.is_action_pressed("ui_right"):
			%Animation.flip_h = true
			
		elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("GunLeft"):
			%Animation.flip_h = false
		
		


@rpc("any_peer","call_local")
func fire():

	var b = bullet.instantiate()
	b.set_multiplayer_authority(get_multiplayer_authority())
	
	b.global_position = $GunRotation/BulletSpawn.global_position
	b.rotation_degrees = $GunRotation.rotation_degrees
	get_tree().root.add_child(b)
	


func Fire_Self():
	var b = self_bullet.instantiate()
	b.global_position = $GunRotation/BulletSpawn.global_position
	b.rotation_degrees = $GunRotation.rotation_degrees
	get_tree().root.add_child(b)
	print(health,"health Self  bu Player", multiplayer.get_unique_id())

func Playerr():
	return




@rpc("any_peer","call_local")
func receive_damage(damage):
	print("                       Dmaged!!!!!!", damage)
	if health >0: 
		health -= damage
	HealthChanged.emit()
	
	print("health - damage : ", health)
	if health <= 0:
		Spawn()
		$CanvasLayer/Left.output = Vector2.ZERO
		addsccore.rpc()
		await get_tree().create_timer(0.1).timeout 
		DieRespawn.rpc()
		await get_tree().create_timer(3).timeout 
		LifeRespawn.rpc()
		health = 100
		


@rpc("any_peer","call_local")
func DieRespawn():
	
	
	$CanvasLayer.hide()
	#$".".hide()
	#$CollisionShape2D.disabled = true
	$Area2D.monitoring = false
	
	

@rpc("any_peer","call_local")
func LifeRespawn():

	

	$CanvasLayer.show()
	#$".".show()
	#$CollisionShape2D.disabled = false
	
	$Area2D.monitoring = true
	

@rpc("any_peer","call_local")
func addsccore():
		Lives = Lives - 1
		#health = health - dmage
		print("Player_Lives : ", Lives," Player_UniqueId : ",unique_id)
		


		
@rpc("any_peer","call_local")
func lobby():
			alive =alive -1
			$".".hide()
			$".".queue_free()
			



@rpc("any_peer")
func sp():
			var id =multiplayer.get_unique_id()
	#if GameManager.Players.has(id):
		#if health<=0:
			
			GameManager.Players[id]["score"] += 1
			print("Score for player ", id, " is now ", GameManager.Players[id]["score"])



func take_damage(damage):
	health-=damage
	
	if health<=0:
		#await get_tree().create_timer(0.1).timeout 
		health = Max_health

@rpc("any_peer","call_local")
func invisible():
	$".".hide()
	$".".visible = false
	GameManager.Vissible = false
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
	#if is_multiplayer_authority():
		$".".show()
		GameManager.Vissible = true
		
		
	await get_tree().create_timer(5).timeout 
	$".".visible = true 
	GameManager.Vissible = true
	$".".show()
	
	
func AddGun(gun):
	var G = gun.instantiate()
	G.add_child(G)
	
	
@export var Famas : PackedScene
@export var Pistol : PackedScene
@export var Sniper : PackedScene
@onready var Guns : Array[PackedScene] = [Famas, Pistol,Sniper]





func san():
		var random_index = randi_range(0, Guns.size() -1)
		var instance = Guns[random_index].instantiate()
		#var instance = Pistol.instantiate()
		#body.get_node($GunRotation).
		var Authority = get_node(".").get_multiplayer_authority()

		$GunRotation/BulletSpawn.global_position = instance.global_position
		instance.set_multiplayer_authority(Authority)
		print("   Guns   Authhority  : ", multiplayer.get_unique_id())
		var mul =$MultiplayerSpawner
		#get_tree().root.add_child(instance)
		get_node(".").add_child(instance)
		
		instance.global_position = $GunRotation.global_position 

func _on_area_2d_body_entered(body):
	
	if is_multiplayer_authority():
	
		if body.has_node("Famas"):
		#has_method("Gun_Pick"):
			#print("GUNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN")
			#$CanvasLayer/GunPick.show()
			pass
		else :
			$CanvasLayer/GunPick.hide()
			#san()

		#body.rpc_id(body.set_multiplayer_authority())
		
		#queue_free()
	#pass # Replace with function body.

func Spawn():
		%Animation.play("Idle")
		var spawn_points = get_tree().get_nodes_in_group("PlayerSpawnPoint")
		if spawn_points.size() > 0:
			var random_index = randi() % spawn_points.size()
			var random_spawn = spawn_points[random_index]
			await  get_tree().create_timer(2).timeout
			$".".global_position = random_spawn.global_position
		else:
			print("No PlayerSpawnPoint nodes found in the group.")

