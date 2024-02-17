/// @description Burrice Artificial
if (time!=global.timeJogador) {
	alarm[0]=60+random(600);
	if (!emMovimento) {
		pontoDestinoMover.definir(x+lengthdir_x(random(512),random(360)),y+lengthdir_y(random(512),random(360)));
	}
	if (construtor) {
		if (irandom(10)==0) {
			construirUnidade(unidadesConstruir[|irandom(ds_list_size(unidadesConstruir)-1)]);
		}
	}
}