extends ColorRect

#export var dialogPath="C:/Users/syp13/GitHub/Adventure-of-Santa-Fairy/dialog2.json"
export var dialogPath="res://dialog/dialog2.json"
export(float) var textSpeed=0.05

var dialog

var phraseNum=0
var finished=false
var dialogFinished=false

func _ready():
	BackGroundMusic.play_storySceneMusic()
	$Timer.wait_time=textSpeed
	dialog=getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(delta):
	$Indicator.visible=finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:  
			nextPhrase()
		else:
			$Text.visible_characters=len($Text.text)
	
	if dialogFinished:
		get_tree().change_scene("res://scene/Level 2.tscn")

func getDialog() ->Array:
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
		dialogFinished=true
		queue_free()
		return
	
	finished=false
	
	$Name.bbcode_text=dialog[phraseNum]["Name"]
	$Text.bbcode_text=dialog[phraseNum]["Text"]
	
	
	$Text.visible_characters=0
	
	var file=File.new()
	var img= "res://Images/" + dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	
	if file.file_exists(img):
		$Portrait.texture=load(img)
	else:
		$Portrait.texture=null
	
	while $Text.visible_characters <len($Text.text):
		$Text.visible_characters+=1
		
		$Timer.start()
		yield($Timer, "timeout") #until timeout signal, loop 
	
	finished=true
	phraseNum+=1
	return

