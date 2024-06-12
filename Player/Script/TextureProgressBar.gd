extends ProgressBar

@export var Health : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Health.HealthChanged.connect(health)
	health()
	

func _process(delta):
	
	health.rpc()
	health()
	

@rpc("any_peer")
func health():
	value = Health.health * 100 / Health.Max_health

