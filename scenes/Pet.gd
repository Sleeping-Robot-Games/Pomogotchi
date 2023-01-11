extends Node2D

var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	animate('Idle')


func animate(anim):
	## TODO: Refactor random variations :|
	if 'Study' in anim:
		var n = random.randi_range(1, 3)
		anim = anim + str(n)
	if 'Play' in anim:
		var n = random.randi_range(1, 2)
		anim = anim + str(n)
	if 'Exercise' in anim:
		var n = random.randi_range(1, 2)
		anim = anim + str(n)
	$AnimationPlayer.play(anim)
