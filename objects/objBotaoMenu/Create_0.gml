estadoBotao = 0;
x = room_width / 2;
y = room_height + 64;
divisorVelocidade = 10;
image_alpha = 0;
sliderConfig = 0;
if (slider) {
	switch (acaoBotao) {
		case acoesMenu.opcoes_volumeSom: sliderConfig = audio_group_get_gain(audiogroup_sons); break;
		case acoesMenu.opcoes_volumeMusica: sliderConfig = audio_group_get_gain(audiogroup_musica); break;
		case acoesMenu.opcoes_volumeInterface: sliderConfig = audio_group_get_gain(audiogroup_interface); break;
	}
}