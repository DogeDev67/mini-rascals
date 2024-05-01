extends GPUParticles2D

var lifetime_max : float = 22.0 # serves ZERO purpose

func _ready():
	emitting = true
	
func _physics_process(delta):

	self_modulate.a -= 0.0005

func _on_finished():
	queue_free()
