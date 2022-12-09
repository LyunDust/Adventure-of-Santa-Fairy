#Owner: ParkSinYoung
extends Node2D

#Set up autoload to manage music in other scenes

var startScreenMusic = load("res://sound/this-christmas-126736.mp3")
var endingMusic = load("res://sound/we-wish-you-a-merry-christmas-125995.mp3")
var storyMusic = load("res://sound/cinematic-fairy-tale-story-main-8697.mp3")
var level2Music = load("res://sound/happy-christmas-127093.mp3")
var level1SoundVolume = 0

func _ready():
	#Load the music for each scene and set the stream
	$StartScreenMusic.stream = startScreenMusic
	$EndingScreenMusic.stream = endingMusic
	$StorySceneMusic.stream = storyMusic
	$Level2SceneMusic.stream = level2Music
	
#play_music() : if the music is not playing, the music plays.
#pause_music() : if the music is playing, the music stops.
#set_musicVol(vol) : Set the music volume to the value you set 
#                    in the slider on the Options screen
#get_musicVol() ->float : Returns the current music volume value 
#                         to set the value of the slider on the Options screen

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
	
func play_level2SceneMusic():
	if !$Level2SceneMusic.is_playing():
		$Level2SceneMusic.play()
		
func pause_level2SceneMusic():
	if $Level2SceneMusic.is_playing():
		$Level2SceneMusic.stop()
		
func set_level2SceneMusicVol(vol):
	$Level2SceneMusic.volume_db = vol

func get_level2SceneMusicVol() -> float:
	return $Level2SceneMusic.volume_db

