#Owner: ParkSinYoung

extends TextureRect

export var dialogPath="res://dialog/dialog.json"
export(float) var textSpeed=0.05

var dialog

var phraseNum=0
var finished=false
var dialogFinished=false

func _ready():
	BackGroundMusic.play_storySceneMusic() #Play music on the story screen
	$Timer.wait_time=textSpeed
	#The speed of text when letters appear in order one by one
	dialog=getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(delta):
	#Show the indicator at the end of the character's line
	$Indicator.visible=finished
	#If the character's lines are over when you press the key, 
	#move on to the next line
	#if the character's lines are not finished When you press the key,  
	#show them all
	if Input.is_action_just_pressed("ui_accept"):
		if finished:  
			nextPhrase()
		else:
			$Text.visible_characters=len($Text.text)
	
	if dialogFinished:
		#If all the lines are finished, it will be changed to level 1 game scene
		get_tree().change_scene("res://Aisle/Aisle.tscn")

func getDialog() ->Array: #Read lines from json file
	var file=File.new()
	assert(file.file_exists(dialogPath), "File Path does not exist")
	
	file.open(dialogPath, File.READ)
	var json=file.get_as_text()
	
	var output=parse_json(json)
	
	if typeof(output) ==TYPE_ARRAY:
		return output
	else:
		return []
		

func nextPhrase()->void:
	if phraseNum >= len(dialog):
		#When all the lines are over, remove the dialog box
		dialogFinished=true
		queue_free()
		return
	
	finished=false
	
	$Name.bbcode_text=dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"]
	$Text.bbcode_text=dialog[phraseNum]["Text"]
	#Importing character names and lines from json file
	
	$Text.visible_characters=0
	
	var file=File.new()
	var img="res://Aisle/Image/Characters/"+ dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	#Importing the image corresponding to the character name
	if file.file_exists(img):
		$Portrait.texture=load(img)
	else:
		$Portrait.texture=null
	
	while $Text.visible_characters <len($Text.text):
		#Letters appear in the dialog box one by one
		$Text.visible_characters+=1
		
		$Timer.start()
		yield($Timer, "timeout") 
	
	finished=true
	phraseNum+=1
	return

