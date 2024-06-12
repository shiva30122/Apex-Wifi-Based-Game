extends Node2D

@export var PlayerScene : PackedScene
var multiplayer_spawner : MultiplayerSpawner
#@export var Gun = preload("res://Ability Objects/snake.tscn")
#
#@export var Famas = preload("res://Weapons/famas.tscn")
#
#@export var Fam2 = preload("res://Weapons/famas.tscn")

signal score_update


func _enter_tree() -> void:
		if multiplayer.is_server():
			RemovePlayers.rpc()


func _ready():
	
	var index = 0
	for i in GameManager.Players:
		RemovePlayers.rpc()
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			#if spawn.name == str(index):
				#currentPlayer.global_position = spawn.global_position
		#index += 1

		#print("                                ,,,,,,,,",GameManager.Players[i].id)
			var spawn_points = get_tree().get_nodes_in_group("PlayerSpawnPoint")
			if spawn_points.size() > 0:
				var random_index = randi() % spawn_points.size()
				var random_spawn = spawn_points[random_index]
				currentPlayer.global_position = random_spawn.global_position
			else:
				print("No PlayerSpawnPoint nodes found in the gr  oup.")
		RemovePlayers.rpc()
		if multiplayer.is_server():
			RemovePlayers.rpc()

	for i in GameManager.Players:
		
	
		#if !is_multiplayer_authority():return
		var score = Label.new()
		var id = GameManager.multiplayer.get_unique_id()
		score.text = str(GameManager.Players[i].name ,"   :", GameManager.Players[id]["score"])
		$VBoxContainer.add_child(score)
		print(i,"                                 ",GameManager.Players[id]["score"])
		#if $VBoxContainer.get_child_count()>1:
			#$VBoxContainer.remove_child(score)
	



@rpc("any_peer","call_local","reliable")
func RemovePlayers():
	var nulPlayers = get_tree().get_nodes_in_group("Player")
	for i in nulPlayers:
			if i.name == str("UnKnown_Person"):
				i.queue_free()
				




		#var s =Gun.instantiate()
		#add_child(s)

		#for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			#
			#if spawn.name == str(index):
				#currentPlayer.global_position = spawn.global_position
			#index += 1
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
		#$Label.text = str(ceil($Timer.time_left))






#func _on_timer_timeout():
	#
	#
	#
		## Iterate over nodes in the "Player" group
	#for i in GameManager.Players:
		#var score = null  # Initialize score variable
			#
		## Check if sc ore label already exists
		#if not score:
			## Create a new Label node
			#score = Label.new()
			#score.name = "score"  # Set the name of the label node
			#$VBoxContainer.add_child(score)  # Add the label as a child of VBoxContainer
		#
		## Accessing score label
		##score = $VBoxContainer.get_node("score")
		#
		## Update score text
		#score.text = str(GameManager.Players[i].name) + " : " + str(GameManager.Players[i]["score"])
		#print(GameManager.Players[i].name + " : " + str(GameManager.Players[i]["score"]))
 #
#
#
	#
	#
	#
	#
	#
	#
	#
	#
	#
	#
	#
	#
	#
	#
		##for i in GameManager.Players:
					##$Timer2.start()
					##
					##var score = null
					##if score != null:
						##score = Label.new()
##
					##$VBoxContainer.add_child(score)
					##score.text = str(GameManager.Players[i].name ,"     ",i,"  :     " , GameManager.Players[i]["score"])
					##print(GameManager.Players[i].name ,"   :", GameManager.Players[i]["score"])
					##if $VBoxContainer.get_child_count()> GameManager.Players.size() :
							##$VBoxContainer.remove_child(score)
					##if GameManager.Players[i]["score"] != GameManager.Players[i]["score"]:
						##$VBoxContainer.remove_child(score)
					#
					##cs = score
					##id = i
					##dis = true
					##cs.text = str(GameManager.Players[id].name ,"     ","  :     " , GameManager.Players[id]["score"])
					##

