extends "res://Scripts/Editor/GL_Wiki.gd"

func _show_page(content: String) -> void:
	var parsed = _parse_controller_icons(content)
	super._show_page(parsed)

func _parse_controller_icons(raw_text: String) -> String:
	var icon_set: int = 0
	var pause_menu = get_tree().get_first_node_in_group("Pause Menu")
	if pause_menu and pause_menu.currentSettings.has("controller_icons"):
		icon_set = pause_menu.currentSettings.get("controller_icons", 0)

	var aliases = {
		"Right Stick Click": "R3",
		"Left Stick Click": "L3",
		"Right Shoulder Button": "RB",
		"Left Shoulder Button": "LB",
		"Joystick Left": "LstickL",

		"Dpad Up": "Dpad_Up",
		"Dpad Down": "Dpad_Down",
		"Dpad Left": "Dpad_Left",
		"Dpad Right": "Dpad_Right",
		"D-Pad Up": "Dpad_Up",
		"D-Pad Down": "Dpad_Down",
		"D-Pad Left": "Dpad_Left",
		"D-Pad Right": "Dpad_Right"
	}

	var parsed = raw_text

	# 1. normalize all alias tags to standard ICON_MAP keys
	for alias in aliases.keys():
		parsed = parsed.replace("{" + alias + "}", "{" + aliases[alias] + "}")

	# 2. swap keys with [img] tags
	for key in ControllerIcon.ICON_MAP.keys():
		var paths: Array = ControllerIcon.ICON_MAP[key]
		var idx = clamp(icon_set, 0, paths.size() - 1)
		var img_tag = "[img=22]" + ControllerIcon.BASE + paths[idx] + "[/img]"
		parsed = parsed.replace("{" + key + "}", img_tag)

	return parsed
