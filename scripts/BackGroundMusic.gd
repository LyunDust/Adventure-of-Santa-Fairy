extends Node2D

var startScreenMusic = load("res://sound/this-christmas-126736.mp3")
var endingMusic = load("res://sound/we-wish-you-a-merry-christmas-125995.mp3")
var storyMusic = load("res://sound/happy-christmas-127093.mp3")
var level1SoundVolume = 0

func _ready():
	$StartScreenMusic.stream = startScreenMusic
	$EndingScreenMusic.stream = endingMusic
	$StorySceneMusic.stream = storyMusic

func play_startScreenmusic():
	if !$StartScreenMusic.is_playing():
		$StartScreenMusic.play()

func play_endingScreenmusic():
	if !$EndingScreenMusic.is_playing():
		$EndingScreenMusic.play()

func pause_startScreenmusic():
	if $StartScreenMusic.is_playing():
		$StartScreenMusic.stop()
		
func pause_endingScreenmusic():
	if $EndingScreenMusic.is_playing():
		$EndingScreenMusic.stop()
		
func play_storySceneMusic():
	if !$StorySceneMusic.is_playing():
		$StorySceneMusic.play()
		
func pause_storySceneMusic():
	if $StorySceneMusic.is_playing():
		$StorySceneMusic.stop()
		
func set_startScreenmusicVol(vol):
	$StartScreenMusic.volume_db = vol

func get_startScreenmusicVol() -> float:
	return $StartScreenMusic.volume_db
	
func set_storyScreenmusicVol(vol):
	$StorySceneMusic.volume_db = vol

func get_storyScreenmusicVol() -> float:
	return $StorySceneMusic.volume_db
	
func set_level1MusicVol(vol):
	level1SoundVolume = vol

func get_level1MusicVol() ->float:
	return level1SoundVolume

