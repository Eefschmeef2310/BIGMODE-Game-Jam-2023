extends HTTPRequest

var headers = ["Content-Type: application/json", "Authorization: Bearer patA9a9DtO3bOqEmK.9e5d17edee61d66f0a6ba5746bfe64a943893054d168c5359f23b76e3fb7165c"]

#var base = Airtable({apiKey: 'YOUR_SECRET_API_TOKEN'}).base('appyatJwaYPKtsdCM').new()

signal response(string)



# Called when the node enters the scene tree for the first time.
func _ready():
	request_completed.connect(_on_request_completed)
	#Upload()
	pass # Replace with function body.

func Upload(username, score, version): #DEPRECIAETD
	print("atempting")
	var url = "https://api.airtable.com/v0/appyatJwaYPKtsdCM/Table%201"
	var data = {"records": [
	{
	  "fields": {
		"Name": str(username),
		"Score": float(score),
		"Version": str(version)
	  }
	}]}
	var error = request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		print("http error")
	else:
		print("data sent!")
	pass

func PullAndUpload():
	var distance = GameManager.tank_position.x
	var gears = GameManager.gears
	var upgradeState = UpgradeManager.upgrade_state()
	var score = ScoreManager.calculateScore()
	var enimiesKilled = ScoreManager.enemiesKilled
	var progressScore = ScoreManager.progress_score
	var endReached = GameManager.end_reached
	UploadRun(score, distance, gears, upgradeState, progressScore, enimiesKilled, endReached)
	pass

func UploadRun(score : int, distance : float, gears : int, upgradeState : String, gameTime : float, enimiesKilled : int, endReached : bool):
	print("Uploading Run")
	var url = "https://api.airtable.com/v0/appyatJwaYPKtsdCM/Play%20Data"
	var data = {"records": [
	{
	  "fields": {
		"Score" : int(score),
		"Distance": float(distance - 2175.98), #im sorry T_T
		"Gears": int(gears),
		"Upgrade State": String(upgradeState),
		"Game Time": float(gameTime),
		"Enimies Killed" : int(enimiesKilled),
		"End Reached": bool(endReached)
	  }
	}]}
	var error = request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		print("HTTP Error D=")
	else:
		print("Run Data Sent!")
	return true


func _on_nyan_debug_cmd_upload(username, score, version):
	Upload(username, score, version)
	pass # Replace with function body.

func _on_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(JSON.stringify(json))
	response.emit(JSON.stringify(json))
	#print(str(json[1]))




## Final data to send
# - Run id (autonumber)
# - session ID
# - distance travelled
# - gears
# - gears spent
# - total gears
# - upgrades purchased
# - game time 
