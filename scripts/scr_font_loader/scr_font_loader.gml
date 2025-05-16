/// Script for loading in bitmap fonts from sprites

// Loads in all the fonts to global variables
function scr_font_load_all()
{
	// Creates score font from sprite and sets to global variable
	global.font_score = font_add_sprite_ext(spr_ui_font_score_8x8, " 0123456789", true, 0);

	// Creates text font from sprite and sets to global variable
	global.font_text = font_add_sprite_ext(spr_ui_font_text_gold_8x8, " !\"#$%&'()*+,-./0123456789:;<=>?ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	
	// Creates white text font from sprite and sets to global variable
	global.font_text_white = font_add_sprite_ext(spr_ui_font_text_en_white_8x8, " !\"#$%&'()*+,-./0123456789:;<=>?ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
}