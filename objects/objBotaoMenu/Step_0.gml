if (objTitulo.estado==menuPertencente) {
	x += (xstart - x) / divisorVelocidade;
	y += (ystart - y) / divisorVelocidade;
	image_alpha += (1 - image_alpha) / (divisorVelocidade/5);
} else {
	estadoBotao = 0;
	x += (xstart - x) / divisorVelocidade;
	y += ((room_height + 64) - y) / divisorVelocidade;
	image_alpha += (0 - image_alpha) / (divisorVelocidade/5);
}