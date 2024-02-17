event_inherited();

if (ctrlFase.estadoJogo==estadosJogo.emExecucao) {
	image_xscale+=0.1;
	image_yscale+=0.1;
	potencia-=0.1;
	if (potencia==0) {
		instance_destroy();
	}
}