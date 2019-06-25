extends Sprite

func _ready():
	$anim.play("braking")
	$anim.connect("animation_finished", self, "destroy")

func destroy(animation):
	queue_free()
