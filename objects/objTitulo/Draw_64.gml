draw_set_font(fntGUI);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
x=room_width/2;
y=room_height/2;
switch (estado) {
	case estadosMenu.pressioneBotao: {
		if (sin(current_time/120)>0) {
			draw_set_alpha(1);
			draw_text_fx(display_get_gui_width()/2,display_get_gui_height()-64,"Pressione qualquer botão para iniciar");
		}
	} break;
	case estadosMenu.textoSPADE: {
		draw_caixaGUI(128,128,"Bem-vindo ao \"Ants Attack!\"\n\nEste é um jogo de estratégia (RTS), e todos os cenários deste foram elaborados com o auxílio da SPADE (NVIDIA), um modelo baseado no pix2pixHD, que gera imagens de acordo com um mapa semântico.\n\nAqui, os cenários foram construídos usando um tileset que possui apenas informações semânticas, e que também é usado no comportamento das unidades. Posteriormente, foram enviados à GAN, para geração das imagens de cada cenário presente neste jogo.\n\nAs demais imagens de IA (retratos de unidades e imagem de fundo do menu) foram geradas pela DALLE-3, disponibilizada pela plataforma Microsoft Designer.\n\nEspero que você goste do resultado e, caso queira, você pode entrar em contato pelo meu site: leandrogabriel.net",fa_left,fa_top);
		x=display_get_gui_width()-256;
		y=128;
		image_xscale=0.25;
		image_yscale=0.25;
	} break;
	case estadosMenu.sair: {
		draw_caixaGUI(256,display_get_gui_height()/3,"Tem certeza de que deseja sair?");
		y=display_get_gui_height()/3;
		image_xscale=0.25;
		image_yscale=0.25;
	} break;
	case estadosMenu.opcoes: {
		draw_caixaGUI(128,128,"Opções",fa_left,fa_top);
		x=display_get_gui_width()-256;
		y=128;
		image_xscale=0.25;
		image_yscale=0.25;
	} break;
	case estadosMenu.comoJogar: {
		x=display_get_gui_width()-256;
		y=128;
		image_xscale=0.25;
		image_yscale=0.25;
		switch (estadoComoJogar) {
			case 0: {
				draw_caixaGUI(128,128,"O jogo\n\n\"Ants Attack!\" é um jogo de estratégia (RTS), em que você controla uma colônia de formigas, e deve destruir as colônias inimigas.\n\nPara isto, através do formigueiro você pode construir novas unidades (ao custo da moeda, que fica se regenerando) e elaborar sua estratégia para destruição das colônias inimigas.\n\nA colônia que restar sozinha será a vitoriosa!\n\nTodos os comandos são obtidos pelo mouse (esquerda: Seleciona, direita: Comanda).\nA tecla S alterna entre exibição comum e exibição semântica.",fa_left,fa_top);
			} break;
			case 1: {
				draw_caixaGUI(128,128,"Unidades\n\nFormiga (Custo: 100)\nA Formiga é uma unidade rápida, com um alcance médio. Seu ataque é ataque fraco, mas bastante efetivo se usado em grupo. Além disto, a formiga é capaz de construir novos formigueiros.\n\nFormigão (Custo: 175)\nO Formigão é lento, de alcance curto, mas de ataque poderoso. Uma boa estrátégia pode ser usada para destruir grupos problemáticos de forma rápida.\n\nBesouro (Custo: 250)\nDe alcance longo e poderoso, mas extremamente lento, o Besouro é capaz de criar emboscadas, e derrotar formigueiros com facilidade.",fa_left,fa_top);
			} break;
			case 2: {
				draw_caixaGUI(128,128,"Estratégias\n\nOlhe onde pisa\nAs unidades sofrem modificações de acordo com o terreno em que se encontram. Terrenos abertos, como concreto/tijolos/cimento tornam as unidades mais rápidas, mas reduzem suas defesas. Terrenos mais desnivelados, como grama, folhas, e coberturas como folhas secas contribuem para defesa, mas as torna mais lentas.\n\nMais formigueiros = mais dinheiro\nA velocidade da regeneração da moeda é relativa à quantidade de formigueiros que uma colônia possui.",fa_left,fa_top);
			} break;
		} 
	}
	case estadosMenu.selecionarFase: {
		x=display_get_gui_width()/2;
		y=128;
		image_xscale=0.25;
		image_yscale=0.25;
	}
}
draw_sprite_ext(sprite_index,image_index,(x/room_width)*display_get_gui_width(),(y/room_height)*display_get_gui_height(),image_xscale,image_yscale,image_angle,image_blend,image_alpha);
draw_set_alpha(fadeTela);
draw_set_color(c_black);
draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),false);