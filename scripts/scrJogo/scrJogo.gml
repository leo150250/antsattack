global.debug = false;
global.timeJogador = 0;
global.tamanhoJanelaX = 0;
global.tamanhoJanelaY = 0;
global.jaExibiuInforme = false;
audio_group_load(audiogroup_musica);
audio_group_load(audiogroup_sons);
audio_group_load(audiogroup_interface);

#region Enums
enum formaComandos {
	manter,
	revidar,
	agredir
}
enum contextosTileset {
	nada,
	areia,
	cimento,
	concreto,
	folhas,
	folhasSecas,
	galhosSecos,
	grama,
	gramaSeca,
	muro,
	terra,
	tijolo
}
enum estadosJogo {
	emExecucao,
	emPausa,
	vitoria,
	derrota
}
enum estadosMenu {
	pressioneBotao,
	textoSPADE,
	menuPrincipal,
	comoJogar,
	opcoes,
	sair,
	selecionarFase,
	nenhum,
	iniciarFase
}
enum acoesMenu {
	nenhuma,
	sairJogo,
	comoJogar_jogo,
	comoJogar_unidades,
	comoJogar_estrategia,
	iniciar_fase01,
	iniciar_fase02,
	iniciar_fase03,
	iniciar_fase04,
	opcoes_volumeSom,
	opcoes_volumeMusica,
	opcoes_volumeInterface,
	opcoes_telaCheia
}
#endregion

#region Classes
/**
 * Function Description
 * @param {real} argX Description
 * @param {real} argY Description
 */
function Vector2(argX,argY) constructor {
	x = argX;
	y = argY;
	definido0 = false;
	/**
	 * Function Description
	 * @param {Id.Instance} argInstancia Description
	 */
	static focar = function(argInstancia) {
		if (instance_exists(argInstancia)) {
			x = argInstancia.x;
			y = argInstancia.y;
		}
	}
	static definir = function(argX,argY) {
		x = clamp(argX,16,room_width-16);
		y = clamp(argY,16,room_height-16);
	}
}

/**
 * Function Description
 * @param {Asset.GMSprite} argSprite Description
 * @param {real} argValor Description
 * @param {string} argNome Description
 * @param {Asset.GMObject} argObjeto Description
 */
function BotaoConstrutor(argSprite,argValor,argNome,argObjeto) constructor {
	sprite=argSprite;
	valor=argValor;
	nome=argNome;
	objeto=argObjeto;
}
#endregion

#region Funções
/**
 * Function Description
 * @param {mb_any} argBotao Description
 * @param {Id.Instance} argUnidade Description
 */
function mouseUpUnidade(argBotao,argUnidade) {
	if (mouse_check_button_released(argBotao)) {
		if (mouse_x>argUnidade.x-12)
		&& (mouse_x<argUnidade.x+12)
		&& (mouse_y>argUnidade.y-12)
		&& (mouse_y<argUnidade.y+12) {
			return true;
		} else {
			return false;
		}
	}
}
function selecionarUnidadesCaixa(argP1,argP2) {
	var listaUnidades=ds_list_create();
	var numUnidades=collision_rectangle_list(argP1.x,argP1.y,argP2.x,argP2.y,parUnidade,false,false,listaUnidades,false);
	if (numUnidades>0) {
		for (var i=0; i<numUnidades; i++) {
			if (listaUnidades[|i].velocidade>0) {
				listaUnidades[|i].emSelecaoCaixa=true;
			}
		}
	}
	ds_list_destroy(listaUnidades);
}
function identificarContexto(argTilemapIndice) {
	var arrayContextos=array_create(2,contextosTileset.nada);
	arrayContextos[2]="";
	switch (argTilemapIndice) {
		case 20: case 267: case 286: case 305: {
			arrayContextos[0]=contextosTileset.areia;
			arrayContextos[2]="Areia";
		} break;
		case 21: case 268: case 287: case 306: {
			arrayContextos[0]=contextosTileset.cimento;
			arrayContextos[2]="Cimento";
		} break;
		case 22: case 269: case 288: case 307: {
			arrayContextos[0]=contextosTileset.concreto;
			arrayContextos[2]="Concreto";
		} break;
		case 23: case 270: case 289: case 308: {
			arrayContextos[0]=contextosTileset.folhas;
			arrayContextos[2]="Folhas";
		} break;
		case 24: case 271: case 290: case 309: {
			arrayContextos[0]=contextosTileset.folhasSecas;
			arrayContextos[2]="Folhas secas";
		} break;
		case 25: case 272: case 291: case 310: {
			arrayContextos[0]=contextosTileset.galhosSecos;
			arrayContextos[2]="Galhos secos";
		} break;
		case 26: case 273: case 292: case 311: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[2]="Grama";
		} break;
		case 27: case 274: case 293: case 312: {
			arrayContextos[0]=contextosTileset.gramaSeca;
			arrayContextos[2]="Grama seca";
		} break;
		case 28: case 275: case 294: case 313: {
			arrayContextos[0]=contextosTileset.muro;
			arrayContextos[2]="Piso";
		} break;
		case 29: case 276: case 295: case 314: {
			arrayContextos[0]=contextosTileset.terra;
			arrayContextos[2]="Terra";
		} break;
		case 30: case 277: case 296: case 315: {
			arrayContextos[0]=contextosTileset.tijolo;
			arrayContextos[2]="Tijolo";
		} break;
		case 38: case 39: case 40: case 41: case 42:
		case 57: case 58: case 59: case 60: case 61:
		case 76: case 77: case 78: case 79: case 80: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[1]=contextosTileset.terra;
			arrayContextos[2]="Grama / terra";
		} break;
		case 43: case 44: case 45: case 46: case 47:
		case 62: case 63: case 64: case 65: case 66:
		case 81: case 82: case 83: case 84: case 85: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[1]=contextosTileset.folhas;
			arrayContextos[2]="Grama / folhas";
		} break;
		case 48: case 49: case 50: case 51: case 52:
		case 67: case 68: case 69: case 70: case 71:
		case 86: case 87: case 88: case 89: case 90: {
			arrayContextos[0]=contextosTileset.terra;
			arrayContextos[1]=contextosTileset.areia;
			arrayContextos[2]="Terra / areia";
		} break;
		case 95: case 96: case 97: case 98: case 99:
		case 114: case 115: case 116: case 117: case 118:
		case 133: case 134: case 135: case 136: case 137: {
			arrayContextos[0]=contextosTileset.tijolo;
			arrayContextos[1]=contextosTileset.cimento;
			arrayContextos[2]="Tijolo / cimento";
		} break;
		case 100: case 101: case 102: case 103: case 104:
		case 119: case 120: case 121: case 122: case 123:
		case 138: case 139: case 140: case 141: case 142: {
			arrayContextos[0]=contextosTileset.folhas;
			arrayContextos[1]=contextosTileset.folhasSecas;
			arrayContextos[2]="Folhas / folhas secas";
		} break;
		case 105: case 106: case 107: case 108: case 109:
		case 124: case 125: case 126: case 127: case 128:
		case 143: case 144: case 145: case 146: case 147: {
			arrayContextos[0]=contextosTileset.terra;
			arrayContextos[1]=contextosTileset.galhosSecos;
			arrayContextos[2]="Terra / galhos secos";
		} break;
		case 152: case 153: case 154: case 155: case 156:
		case 171: case 172: case 173: case 174: case 175:
		case 190: case 191: case 192: case 193: case 194: {
			arrayContextos[0]=contextosTileset.cimento;
			arrayContextos[1]=contextosTileset.concreto;
			arrayContextos[2]="Cimento / concreto";
		} break;
		case 157: case 158: case 159: case 160: case 161:
		case 176: case 177: case 178: case 179: case 180:
		case 195: case 196: case 197: case 198: case 199: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[1]=contextosTileset.gramaSeca;
			arrayContextos[2]="Grama / grama seca";
		} break;
		case 162: case 163: case 164: case 165: case 166:
		case 181: case 182: case 183: case 184: case 185:
		case 200: case 201: case 202: case 203: case 204: {
			arrayContextos[0]=contextosTileset.gramaSeca;
			arrayContextos[1]=contextosTileset.terra;
			arrayContextos[2]="Grama seca / terra";
		} break;
		case 209: case 210: case 211: case 212: case 213:
		case 228: case 229: case 230: case 231: case 232:
		case 247: case 248: case 249: case 250: case 251: {
			arrayContextos[0]=contextosTileset.muro;
			arrayContextos[1]=contextosTileset.cimento;
			arrayContextos[2]="Muro / cimento";
		} break;
		case 214: case 215: case 216: case 217: case 218:
		case 233: case 234: case 235: case 236: case 237:
		case 252: case 253: case 254: case 255: case 256: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[1]=contextosTileset.concreto;
			arrayContextos[2]="Grama / concreto";
		} break;
		case 219: case 220: case 221: case 222: case 223:
		case 238: case 239: case 240: case 241: case 242:
		case 257: case 258: case 259: case 260: case 261: {
			arrayContextos[0]=contextosTileset.grama;
			arrayContextos[1]=contextosTileset.cimento;
			arrayContextos[2]="Grama / cimento";
		} break;
	}
	if (arrayContextos[2]=="") {
		show_debug_message("Contexto não identificado: "+string(argTilemapIndice));
	}
	return arrayContextos;
}
function informacaoContexto(argContexto) {
	var arrayInformacao=array_create(2,0);
	// [0] = Velocidade
	// [1] = Defesa
	switch (argContexto) {
		case contextosTileset.areia: {
			arrayInformacao[0]=1.1;
			arrayInformacao[1]=0.8;
		} break;
		case contextosTileset.cimento: {
			arrayInformacao[0]=1.4;
			arrayInformacao[1]=0.6;
		} break;
		case contextosTileset.concreto: {
			arrayInformacao[0]=1.45;
			arrayInformacao[1]=0.6;
		} break;
		case contextosTileset.folhas: {
			arrayInformacao[0]=0.8;
			arrayInformacao[1]=1.1;
		} break;
		case contextosTileset.folhasSecas: {
			arrayInformacao[0]=0.6;
			arrayInformacao[1]=2;
		} break;
		case contextosTileset.galhosSecos: {
			arrayInformacao[0]=0.7;
			arrayInformacao[1]=1.4;
		} break;
		case contextosTileset.grama: {
			arrayInformacao[0]=1;
			arrayInformacao[1]=1;
		} break;
		case contextosTileset.gramaSeca: {
			arrayInformacao[0]=0.9;
			arrayInformacao[1]=0.9;
		} break;
		case contextosTileset.muro: {
			arrayInformacao[0]=1.6;
			arrayInformacao[1]=0.5;
		} break;
		case contextosTileset.terra: {
			arrayInformacao[0]=1.2;
			arrayInformacao[1]=0.8;
		} break;
		case contextosTileset.tijolo: {
			arrayInformacao[0]=1.5;
			arrayInformacao[1]=0.7;
		} break;
	}
	return arrayInformacao;
}
#endregion

#region Funções DRAW
function draw_text_fx(argX,argY,argTexto) {
	draw_set_color(c_black);
	draw_text(argX+2,argY+2,argTexto);
	draw_set_color(c_white);
	draw_text(argX,argY,argTexto);
}
function verificarTamanhoJanela(argForcar=false) {
	if ((window_get_width()!=global.tamanhoJanelaX)
	|| (window_get_height()!=global.tamanhoJanelaY))
	|| (argForcar) {
		global.tamanhoJanelaX=window_get_width();
		global.tamanhoJanelaY=window_get_height();
		display_set_gui_size(global.tamanhoJanelaX,global.tamanhoJanelaY);
		camera_set_view_size(view_camera[0],global.tamanhoJanelaX/1.5,global.tamanhoJanelaY/1.5);
		view_hport[0]=global.tamanhoJanelaY;
		view_wport[0]=global.tamanhoJanelaX;
	}
}
function draw_caixaGUI(argBordaX,argBordaY,argTexto,argHAlign=fa_center,argVAlign=fa_middle) {
	draw_set_alpha(0.75);
	draw_set_color(c_black);
	draw_rectangle(argBordaX,argBordaY,display_get_gui_width()-argBordaX,display_get_gui_height()-argBordaY,false);
	draw_set_halign(argHAlign);
	draw_set_valign(argVAlign);
	draw_set_color(c_white);
	draw_set_alpha(1);
	var posX=display_get_gui_width()/2;
	var posY=display_get_gui_height()/2;
	if (argHAlign==fa_left) {
		posX=argBordaX+32;
	}
	if (argHAlign==fa_right) {
		posX=display_get_gui_width()-(argBordaX*2)-64;
	}
	if (argVAlign==fa_top) {
		posY=argBordaY+32;
	}
	if (argVAlign==fa_bottom) {
		posY=display_get_gui_height()-(argBordaY*2)-64;
	}
	draw_text_ext(posX,posY,argTexto,-1,display_get_gui_width()-(argBordaX*2)-64);
}
#endregion

#region Funções Audio
function executarMusica(argMusica) {
	if (!instance_exists(ctrlSFX)) {
		instance_create_layer(0,0,layer,ctrlSFX);
	}
	audio_stop_sound(ctrlSFX.musicaAtual);
	ctrlSFX.musicaAtual = argMusica;
	audio_play_sound(argMusica,1,true,1,0,1.5);
	ctrlSFX.alarm[0]=1;
}
function definirVolumeMusica(argVolume) {
	audio_group_set_gain(audiogroup_musica,argVolume,0);
}
function definirVolumeSons(argVolume) {
	audio_group_set_gain(audiogroup_sons,argVolume,0);
}
function definirVolumeInterface(argVolume) {
	audio_group_set_gain(audiogroup_interface,argVolume,0);
}
function executarMusicaFase() {
	var musicaSelecionada = noone;
	switch (irandom(2)) {
		case 0: musicaSelecionada=musAtLaunch; break;
		case 1: musicaSelecionada=musClashDefiant; break;
		case 2: musicaSelecionada=musCorruption; break;
	}
	executarMusica(musicaSelecionada);
	return musicaSelecionada;
}
#endregion