extends Control
class_name RenControl

onready var rnode : = RenNodeCore.new()

export(bool) var auto_define : = false
export(String) var node_id : = ""
export(NodePath) var camera : = NodePath("")

func _ready() -> void:
	Ren.connect("show", self, "_on_show")
	Ren.connect("hide", self, "_on_hide")
		
	if node_id.empty():
		node_id = name

	if auto_define:
		Ren.node_link(self, node_id)

func _on_show(node_id : String , state : String, show_args : Dictionary) -> void:
	if self.node_id != node_id:
		return
	
	rect_position = rnode.show_at(Vector2(0, 0), show_args)
	
	on_state(state)

	if not self.visible:
		show()


func on_state(state : String) -> void:
	pass

func _on_hide(_node_id : String) -> void:
	if _node_id != node_id:
		return
		
	hide()

func _exit_tree() -> void:
	Ren.variables.erase(node_id)
