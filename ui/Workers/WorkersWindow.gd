extends ConfirmationDialog


signal worker_quantity_updated

var WorkerControl = preload("res://ui/Workers/WorkerControl.tscn")
var workerContainers: Array
var temp_quantity_by_worker: Dictionary
var workers_sum: float
onready var grid: GridContainer = $MarginContainer/VBoxContainer/GridContainer


func _ready():
	Events.connect("workers_button_pressed", self, "_on_Events_workers_button_pressed")
	Events.connect("worker_number_changed", self, "_on_Events_worker_number_changed")
	self.get_cancel().connect("pressed", self, "cancelled")
	
	for worker in Global.workers:
		var new_worker = WorkerControl.instance()
		new_worker.get_node("WorkerName").text = worker.worker_name
		new_worker.get_node("MaxWorker").text = String(worker.previous_quantity * 1000)
		grid.add_child(new_worker)
		
	workerContainers = grid.get_children()


func _on_Events_worker_number_changed(target, new_text):
	var worker_name = target.get_node("WorkerName").text
	if float(new_text):
		target.get_node("LineEdit").text = new_text
		target.get_node("LineEdit").set_cursor_position(len(new_text))
		
		for worker in Global.workers:
			if worker.worker_name == worker_name:
				temp_quantity_by_worker[worker_name] = float(new_text) / 1000
	emit_signal("worker_quantity_updated")


func _on_Events_workers_button_pressed():
	# At the window opening
	temp_quantity_by_worker.clear()
	
	for container in workerContainers:
		for worker in Global.workers:
			if worker.worker_name == container.get_node("WorkerName").text:
				container.get_node("LineEdit").text = String(worker.quantity * 1000)
				container.get_node("MaxWorker").text = "(" + String(worker.previous_quantity * 1000) + ")" 
	calc_workers_sum()
	show()
	
	workerContainers[0].get_node("LineEdit").grab_focus()


func _on_WorkersWindow_confirmed():
	update_workers_quantity()


func _on_WorkersWindow_worker_quantity_updated():
	calc_workers_sum()
	
func calc_workers_sum():
	workers_sum = 0
	for worker in Global.workers:
		if temp_quantity_by_worker.has(worker.worker_name):
			workers_sum += temp_quantity_by_worker[worker.worker_name]
		else:
			workers_sum += worker.quantity
			
	$MarginContainer/VBoxContainer/HBoxContainer/ActivePeople.text = str(workers_sum * 1000)


func cancelled():
	print("closed")
	for child in grid.get_children():
		child.get_node("LineEdit").clear()


func update_workers_quantity():
	for worker in Global.workers:
		if temp_quantity_by_worker.has(worker.worker_name):
			worker.quantity = temp_quantity_by_worker[worker.worker_name]
