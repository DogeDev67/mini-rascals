extends Projectile

var damage_reduced : bool = false

func _ready():
	super()

func _physics_process(delta):
	super(delta)
	await get_tree().create_timer(0.05).timeout
	if !damage_reduced:
		damage *= 0.5
		damage_reduced = true
