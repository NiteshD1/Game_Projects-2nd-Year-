extends HTTPRequest

signal connection_success
signal error_connection_failed(code, message)
signal error_ssl_handshake
var connection = false
var check_timer = null

func _ready():
#	yield(utils.create_timer(1.5),"timeout")
	
	check_timer = Timer.new()
	check_timer.autostart = false
	check_timer.one_shot = false
	check_timer.wait_time = 1
	check_timer.connect("timeout", self, "_check_connection")
	add_child(check_timer)
	yield(utils.create_timer(0.5),"timeout")
	check_timer.start()
	connect("request_completed", self, "on_request_result")

func stop_check():
	if not check_timer.is_stopped():
		check_timer.stop()

func start_check():
	if check_timer.is_stopped():
		check_timer.start()

func _check_connection():
	request("http://www.google.com") # This address is only for test. You need to change your trusted and believing return success address...

func on_request_result(result, response_code, headers, body):
	if result == RESULT_SUCCESS:
			connection = true
			emit_signal("connection_success")
	elif result == RESULT_CHUNKED_BODY_SIZE_MISMATCH:
			emit_signal("error_connection_failed", RESULT_CHUNKED_BODY_SIZE_MISMATCH, "RESULT_CHUNKED_BODY_SIZE_MISMATCH")
	elif result == RESULT_CANT_CONNECT:
			emit_signal("error_connection_failed", RESULT_CANT_CONNECT, "RESULT_CANT_CONNECT")
	elif result == RESULT_CANT_RESOLVE:
			emit_signal("error_connection_failed", RESULT_CANT_RESOLVE, "RESULT_CANT_RESOLVE")
	elif result == RESULT_CONNECTION_ERROR:
			emit_signal("error_connection_failed", RESULT_CONNECTION_ERROR, "RESULT_CONNECTION_ERROR")
	elif result == RESULT_SSL_HANDSHAKE_ERROR:
			emit_signal("error_ssl_handshake")
	elif result == RESULT_NO_RESPONSE:
			emit_signal("error_connection_failed", RESULT_NO_RESPONSE, "RESULT_NO_RESPONSE")
	elif result == RESULT_BODY_SIZE_LIMIT_EXCEEDED:
			emit_signal("error_connection_failed", RESULT_BODY_SIZE_LIMIT_EXCEEDED, "RESULT_BODY_SIZE_LIMIT_EXCEEDED")
	elif result == RESULT_REQUEST_FAILED:
			emit_signal("error_connection_failed", RESULT_REQUEST_FAILED, "RESULT_REQUEST_FAILED")
	elif result == RESULT_DOWNLOAD_FILE_CANT_OPEN:
			emit_signal("error_connection_failed", RESULT_DOWNLOAD_FILE_CANT_OPEN, "RESULT_DOWNLOAD_FILE_CANT_OPEN")
	elif result == RESULT_DOWNLOAD_FILE_WRITE_ERROR:
			emit_signal("error_connection_failed", RESULT_DOWNLOAD_FILE_WRITE_ERROR, "RESULT_DOWNLOAD_FILE_WRITE_ERROR")
	elif result == RESULT_REDIRECT_LIMIT_REACHED:
			emit_signal("error_connection_failed", RESULT_REDIRECT_LIMIT_REACHED, "RESULT_REDIRECT_LIMIT_REACHED")