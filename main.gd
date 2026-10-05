extends Node


@export var mob_scene: PackedScene # Adding Mob Scene to inspector
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Signal from hit on Player Scene to stop game when hit
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

# Restart the game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

# Signal from MobTimer
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

# Signal from ScoreTimer
func _on_score_timer_timeout():
	score = score + 1 # Incrementing score as time pass

# Signal from StartTimer
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
