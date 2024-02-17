if (ctrlFase.estadoJogo==estadosJogo.emExecucao) {
	if (abs(pontoDestinoTiro.x - x)<8)
	&& (abs(pontoDestinoTiro.y - y)<8) {
		instance_destroy();
	}
	x+=lengthdir_x(clamp(point_distance(x,y,pontoDestinoTiro.x,pontoDestinoTiro.y),0,velocidade),point_direction(x,y,pontoDestinoTiro.x,pontoDestinoTiro.y));
	y+=lengthdir_y(clamp(point_distance(x,y,pontoDestinoTiro.x,pontoDestinoTiro.y),0,velocidade),point_direction(x,y,pontoDestinoTiro.x,pontoDestinoTiro.y));
	if (fxMuzzle>0) {
		fxMuzzle/=2;
	}
}