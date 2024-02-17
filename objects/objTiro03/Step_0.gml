event_inherited();

if (ctrlFase.estadoJogo==estadosJogo.emExecucao) {
	image_angle+=velocidadeAngulo;
}
var distanciaInicio=point_distance(x,y,xstart,ystart);
var distanciaFim=point_distance(x,y,pontoDestinoTiro.x,pontoDestinoTiro.y);
var distanciaTotal=point_distance(xstart,ystart,pontoDestinoTiro.x,pontoDestinoTiro.y);
if (distanciaInicio<distanciaFim) {
	image_xscale=1+(distanciaInicio/(distanciaTotal/2));
} else {
	image_xscale=(distanciaFim/(distanciaTotal/2))+1;
}
if (distanciaFim<32) {
	atingir=true;
}
image_yscale=image_xscale;