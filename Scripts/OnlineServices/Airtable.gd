extends HTTPRequest

var headers = ["Content-Type: application/json", "Authorization: Bearer patA9a9DtO3bOqEmK.9e5d17edee61d66f0a6ba5746bfe64a943893054d168c5359f23b76e3fb7165c"]
var url = "https://api.airtable.com/v0/appyatJwaYPKtsdCM/Table%201"
#var base = Airtable({apiKey: 'YOUR_SECRET_API_TOKEN'}).base('appyatJwaYPKtsdCM').new()



# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Upload()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Upload(username, score, version):
	print("atempting")
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


func _on_nyan_debug_cmd_upload(username, score, version):
	Upload(username, score, version)
	pass # Replace with function body.
