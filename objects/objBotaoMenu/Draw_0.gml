if (imagemBotao!=noone) {
	draw_set_alpha(image_alpha);
	draw_sprite_stretched(imagemBotao,0,x-sprite_xoffset,y-sprite_yoffset,sprite_width,sprite_height);
}
if (slider) {
	draw_set_color(c_white);
	draw_set_alpha(image_alpha);
	draw_rectangle(x-sprite_xoffset,y-4,x-sprite_xoffset+sprite_width,y+4,true);
}
if (objTitulo.estado==menuPertencente) {
	draw_set_color(c_lime);
	if (estadoBotao==0) {
		draw_set_alpha(0);
	}
	if (estadoBotao==1) {
		draw_set_alpha(0.2);
	}
	if (estadoBotao==2) {
		draw_set_alpha(0.5);
	}
	draw_rectangle(x-sprite_xoffset,y-sprite_yoffset,x-sprite_xoffset+sprite_width,y-sprite_yoffset+sprite_height,false);
}