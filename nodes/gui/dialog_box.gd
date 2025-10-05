extends CanvasLayer

@onready var textContent = $TextureRect/Text
@onready var textShiftedContent = $TextureRect/TextShifted

var Dialog: Resource
var AnimPlayer: AnimationPlayer
var Orientation: int = 0

var loadedDialog
var textIndex = 0
var currentLetter = 0
var actor = null

func _ready():
	if Orientation == -1: $TextureRect.position.y = 8
	var jsonString = FileAccess.get_file_as_string(Dialog.resource_path)
	var json = JSON.new()
	loadedDialog = json.parse(jsonString)
	loadedDialog = json.get_data()
	start_dialog()
	Global.haltPlayer = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_skip") and currentLetter < len(loadedDialog[textIndex].text) and !loadedDialog[textIndex].has("unskippable"):
		$Timer.stop()
		currentLetter = len(loadedDialog[textIndex].text)
		format_whole_text()
	if Input.is_action_just_pressed("ui_accept") and currentLetter == len(loadedDialog[textIndex].text):
		if !is_there_dialog(): queue_free()
		else: start_dialog()
		return
	if currentLetter == len(loadedDialog[textIndex].text) and loadedDialog[textIndex].has("autoskip"):
		if !is_there_dialog(): queue_free()
		else: start_dialog()

func set_text(a):
	textContent.text = a
	textShiftedContent.text = a

func _on_timer_timeout():
	if loadedDialog[textIndex].has("animation"): return
	if currentLetter < len(loadedDialog[textIndex].text):
		$Timer.wait_time = .05
		if loadedDialog[textIndex].text[currentLetter] != "¤":
			if is_current_letter_to_format(): set_text(textContent.text + loadedDialog[textIndex].text[currentLetter])
			$Timer.wait_time = .02
			play_burp()
		currentLetter += 1
		$Timer.start()
	elif len(actor) > 1:
		if FileAccess.file_exists("res://sprites/" + actor[0] + "/portraits/spr_face_" + actor[1] + "_d.png"):
			$TextureRect/portrait.texture = load("res://sprites/" + actor[0] + "/portraits/spr_face_" + actor[1] + "_d.png")

func play_burp():
	if $burpSounds.data.has(actor[0]) and loadedDialog[textIndex].text[currentLetter] not in $textFormat.DONBURP:
		$burp.stream = $burpSounds.data[actor[0]][randi_range(0, len($burpSounds.data[actor[0]])-1)]
		$burp.play()

func is_there_dialog():
	if textIndex != len(loadedDialog)-1:
		textIndex += 1
		return true
	Global.haltPlayer = false
	return false

func start_dialog():
	prepare_box()
	set_text("")
	currentLetter = 0
	$Timer.start()

func is_current_letter_to_format():
	if loadedDialog[textIndex].text[currentLetter] in $textFormat.FORMAT_SYMS:
		var k = loadedDialog[textIndex].text[currentLetter] + loadedDialog[textIndex].text[clamp(currentLetter+1, 0, len(loadedDialog[textIndex].text)-1)]
		if $textFormat.KEYWORDS.has(k):
			var j = str(loadedDialog[textIndex].text[currentLetter] + loadedDialog[textIndex].text[currentLetter+1])
			set_text(textContent.text + $textFormat.KEYWORDS[j])
			currentLetter += 1
			return false
	return true

func format_whole_text():
	set_text(loadedDialog[textIndex].text.replace("¤", ""))
	for x in $textFormat.KEYWORDS: set_text(textContent.text.replace(x, $textFormat.KEYWORDS[x]))

func prepare_box():
	if loadedDialog[textIndex].has("animation"):
		AnimPlayer.play(loadedDialog[textIndex].animation)
		if !is_there_dialog(): queue_free()
		else: start_dialog()
		return
	$TextureRect/portrait.visible = false
	textContent.visible = true
	textShiftedContent.visible = false
	override_font($fontsData.fontsData.determination.size, $fontsData.fontsData.determination.path)
	textContent.position.y = $fontsData.fontsData.determination.y
	textShiftedContent.position.y = $fontsData.fontsData.determination.y
	actor = [ "1" ]
	if loadedDialog[textIndex].has("actor"):
		actor = loadedDialog[textIndex].actor.split(":")
		$TextureRect/portrait.visible = true
		textContent.visible = not len(actor) > 1
		textShiftedContent.visible = len(actor) > 1
		if $fontsData.fontsData.has(actor[0]):
			override_font($fontsData.fontsData[actor[0]].size, $fontsData.fontsData[actor[0]].path)
			textContent.position.y = $fontsData.fontsData[actor[0]].y
			textShiftedContent.position.y = $fontsData.fontsData[actor[0]].y
		if len(actor) > 1: $TextureRect/portrait.texture = load("res://sprites/" + actor[0] + "/portraits/spr_face_" + actor[1] + ".png")
		else: $TextureRect/portrait.visible = false

func override_font(size, path):
	textContent.add_theme_font_size_override("normal_font_size", size)
	textShiftedContent.add_theme_font_size_override("normal_font_size", size)
	textContent.add_theme_font_override("normal_font", path)
	textShiftedContent.add_theme_font_override("normal_font", path)
