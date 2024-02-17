if (slider) {
	draw_set_color(c_white);
	draw_set_alpha(image_alpha);
	draw_rectangle(x-sprite_xoffset,y-16,x-sprite_xoffset+(sprite_width*sliderConfig),y+16,false);
}