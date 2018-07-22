extends Area2D

func _on_moeda_body_enter( body ):
	get_node("anim").play("coletar")
	get_node("shap").queue_free()
	yield(get_node("anim"),"finished")
	queue_free()