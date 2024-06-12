extends Node

var Players = {}
@onready var Score : int
@onready var PID : int

@onready var Vissible : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	PID = get_multiplayer_authority()
	print("                               JSNCOC SNOSI COICJOISJCOISJCOISIJCOISIJCOIISJC  ", PID)
	Vissible = true
	pass

@onready var bunt : bool = false
@onready var Fire : bool

@onready var Touch : bool = false
@onready var TouchedNode : Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	#for Players in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
		#
		#print(" Players : ",Players.multiplayer.get_unique_id())
		
	
	pass

func ChangePosition():
	pass


