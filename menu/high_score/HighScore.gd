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

func insert_new_highscore(name : String, score : int):
	print ("Inserting highscore: " + name + " : " + str(score))
	place_sorted_highscore({ "name" : name, "date" : "beginning of time", "score" : score })
	save_high_scores()
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
		var name_label = create_field(score_entry["name"])
		var date_label = create_field(score_entry["date"])
		var score_label = create_field(str(score_entry["score"]))

func create_field(text : String):
	var label = RichTextLabel.new()
	label.size_flags_vertical = SIZE_EXPAND_FILL
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	label.text = text
	self.add_child(label)

func setup_mock_highscores():
	high_score_table = []
	place_sorted_highscore({ "name" : "Frick Bace", "date" : "beginning of time", "score" : 20000 })
	place_sorted_highscore({ "name" : "Card Hoded", "date" : "beginning of time", "score" : 15000 })
	place_sorted_highscore({ "name" : "Mumbles", "date" : "beginning of time", "score" : 10000 })

func place_sorted_highscore(highscore : Dictionary):
	var ind = high_score_table.bsearch_custom(highscore, self, "high_score_sort")
	high_score_table.insert(ind, highscore)
	
func high_score_sort(a : Dictionary, b : Dictionary):
	var score_a = a["score"]
	var score_b = b["score"]
	return score_a > score_b