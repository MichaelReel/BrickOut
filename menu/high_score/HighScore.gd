extends GridContainer

var high_score_table : Array
export (String) var file_name = "highscores.json"

func _ready():
	load_high_scores()
	display_high_scores()

func load_high_scores():
	print ("'Loading' high scores")
	var scores_file = File.new()
	if not scores_file.file_exists("user://" + file_name):
		# No such file exists, create 'empty' table
		setup_mock_highscores()
		save_high_scores()
	else:
		scores_file.open("user://" + file_name, File.READ)
		high_score_table = parse_json(scores_file.get_line())

func insert_new_highscore(name : String, score : int, update_display := true):
	var date = OS.get_datetime()
	print ("Inserting highscore: " + name + " : " + str(score))
	place_sorted_highscore({ "name" : name, "date" : date, "score" : score })
	save_high_scores()
	if update_display:
		display_high_scores()

func save_high_scores():
	print ("'Saving' high scores")
	var scores_file = File.new()
	scores_file.open("user://" + file_name, File.WRITE)
	scores_file.store_line(to_json(high_score_table))
	scores_file.close()

func display_high_scores():
	for child in get_children():
		child.queue_free()
	for score_entry in high_score_table:
		var score_label = create_field(str(score_entry["score"]))
		var name_label = create_field(score_entry["name"])
		var date_label = create_field(date_format(score_entry["date"]))

func create_field(text : String):
	var label = RichTextLabel.new()
	label.size_flags_vertical = SIZE_EXPAND_FILL
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	label.text = text
	self.add_child(label)

func date_format(date : Dictionary):
	var format_string = "%04d/%02d/%02d %02d:%02d:%02d"
	return format_string % [ date["year"], date["month"], date["day"], date["hour"], date["minute"], date["second"] ]

func setup_mock_highscores():
	high_score_table = []
	var date = OS.get_datetime()
	insert_new_highscore("Frick Bace", 20000, false)
	insert_new_highscore("Card Hoded", 15000, false)
	insert_new_highscore("Mumbles", 10000, true)

func place_sorted_highscore(highscore : Dictionary):
	var ind = high_score_table.bsearch_custom(highscore, self, "high_score_sort")
	high_score_table.insert(ind, highscore)
	
func high_score_sort(a : Dictionary, b : Dictionary):
	var score_a = a["score"]
	var score_b = b["score"]
	return score_a > score_b