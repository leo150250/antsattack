draw_sprite_ext(sprite_index,image_index,x+2,y+2,image_xscale+0.2,image_yscale+0.2,image_angle,c_black,0.4);
if (selecionado) {
	draw_set_color(c_lime);
	draw_set_alpha(1);
	draw_circle(x,y,(sprite_get_width(sprite_index)+sprite_get_height(sprite_index))/3,true);
	draw_line(x,y,pontoDestinoMover.x,pontoDestinoMover.y);
	draw_circle(pontoDestinoMover.x,pontoDestinoMover.y,8,false);
	//DEBUG:
	if (global.debug) {
		var tamanhoLinhaDebug = 4;
		draw_set_color(c_black);
		for (var i = -tamanhoLinhaDebug; i < tamanhoLinhaDebug; i++) {
			draw_line(x-(x%32)-(tamanhoLinhaDebug*32),y-(y%32)+(i*32),x-(x%32)+(tamanhoLinhaDebug*32),y-(y%32)+(i*32));
			draw_line(x-(x%32)+(i*32),y-(y%32)-(tamanhoLinhaDebug*32),x-(x%32)+(i*32),y-(y%32)+(tamanhoLinhaDebug*32));
		}
	}
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
if (spriteCanhao!=noone) {
	draw_sprite_ext(spriteCanhao,0,x+3,y+3,image_xscale+0.3,image_yscale+0.3,direcaoAtaque,c_black,0.4);
	draw_sprite_ext(spriteCanhao,0,x,y,image_xscale,image_yscale,direcaoAtaque,image_blend,image_alpha);
}