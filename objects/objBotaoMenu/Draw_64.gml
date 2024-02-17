draw_set_font(fntGUI);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha);
if (slider) {
	draw_set_halign(fa_right);
	draw_text_fx(((x-sprite_xoffset)/room_width)*display_get_gui_width(),(y/room_height)*display_get_gui_height(),texto+" ");
} else {
	draw_set_halign(fa_center);
	draw_text_fx((x/room_width)*display_get_gui_width(),(y/room_height)*display_get_gui_height(),texto);
}