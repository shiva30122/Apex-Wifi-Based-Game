extends Node2D



@export var Famas : PackedScene
@export var Pistol : PackedScene
@export var Sniper : PackedScene
@export var Guns : Array[PackedScene] #= [Famas, Pistol,Sniper]
@onready var CanPick : bool



func _ready():
	
	CanPick = true
	#add_child(instance)
	




func _process(delta):
	
	
	pass


@onready var mul = $MultiplayerSpawner
func _on_area_2d_body_entered(body):
	
	#if body.has_method("Playerr"):
		if multiplayer.is_server():
			var random_index = randi_range(0, Guns.size() -1)
			var instance = Guns[random_index].instantiate()
			instance.position = $Label.position
			
			#var instance = Famas.instantiate()
			#body.get_node($GunRotation).
			var Authority = body.get_node(".").get_multiplayer_authority()
			instance.set_multiplayer_authority(Authority)
			#instance.set_multiplayer_authority(multiplayer.get_unique_id())
			print("   Gun   Authhority  :     ",body.multiplayer.get_unique_id())
			#body.get_node(".").add_child(instance)
			$MultiplayerSpawner.spawn(instance)
			$MultiplayerSpawner.add_child(instance)
		#$"../Snip-removebg-preview".add_child(instance)
		##body.rpc_id(body.set_multiplayer_authority())

		#await get_tree().create_timer(0.1).timeout
		
		CanPick = false
		$Timer.start()



func  Gun():
	return
#



func _on_timer_timeout():
	CanPick = true
	$Timer.stop()
	pass # Replace with function body.
