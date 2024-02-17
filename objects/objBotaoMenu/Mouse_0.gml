if (slider) && (estadoBotao==2) {
	var valorPosicaoMouse=round(((mouse_x-(x-sprite_xoffset))/sprite_width)*10)/10;
	sliderConfig=valorPosicaoMouse;
	switch (acaoBotao) {
		case acoesMenu.opcoes_volumeSom: audio_group_set_gain(audiogroup_sons,sliderConfig,0); break;
		case acoesMenu.opcoes_volumeMusica: audio_group_set_gain(audiogroup_musica,sliderConfig,0); break;
		case acoesMenu.opcoes_volumeInterface: audio_group_set_gain(audiogroup_interface,sliderConfig,0); break;
	}
}