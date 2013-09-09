unit agtelas; (* telas da agenda *)

(*                    A G E N D A                 *)
(*                versฦo 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licena GPL. *)

interface

procedure tela_de_apresentacao;
procedure comprom;
procedure entracom;
procedure menu;
procedure endtele;
procedure entratel;
procedure notas;


implementation

uses crt;

procedure tela_de_apresentacao;
begin
  clrscr;
  window(12,8,67,19);
  textcolor(white);
  textbackground(cyan);
  writeln('ษอออออออออออออออออออออออออออออออออออออออออออออออออออออป');
  writeln('บ                                                     บ');
  writeln('บ     ษอออออป                            บ            บ');
  writeln('บ     บ     บ                            บ            บ');
  writeln('บ     ฬอออออน  ษออออป  ษอออป  ษอออป  ษอออน  ษอออป     บ');
  writeln('บ     บ     บ  บ    บ  ฬอออผ  บ   บ  บ   บ  บ   บ     บ');
  writeln('บ     บ     บ  ศออออน  ศออออ  ศ   ศ  ศอออส  ศอออสอ    บ');
  writeln('บ                   บ                                 บ');
  writeln('บ               ออออผ                                 บ');
  writeln('บ     versฦo 2.3.3                            2001    บ');
  writeln('ศอออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
  textbackground(black);
  window(1,1,80,25);
end; (* tela_de_apresentaฦo *)

procedure fundoTelas;
begin
  window(11,5,80,21);
  textcolor(white);
  write('      ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ');
  write('    ฺฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ');
  write('  ฺฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ ณ');
  write('ฺฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ ณ ณ');
  write('ณ                                                              ณ ณ รฤู');
  write('ณ                                                              ณ รฤู  ');
  write('ณ                                                              รฤู    ');
  write('ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู      ');
end; (* fundoTelas *)

procedure menu;
begin
  window(20,7,60,18);
  textcolor(white);
  textbackground(blue);
  write('ษอออออออออออออออออออออออออออออออออออออออป');
  write('บ       A    G    E    N    D    A      บ');
  write('ฬออออออออออออออ MENU GERAL อออออออออออออน');
  write('บ                                       บ');
  write('บ  Selecione uma das seguintes opไes:  บ');
  write('บ                                       บ');
  write('บ       * compromissos do dia           บ');
  write('บ       * endereo/telefone             บ');
  write('บ       * abandona agenda               บ');
  write('บ                                       บ');
  write('ศอออออออออออออออออออออออออออออออออออออออผ');
  gotoxy(9,2);
  textcolor(yellow);
  write('A    G    E    N    D    A');
  textbackground(black);
  window(1,1,80,25);
end; (* menu *)

procedure endtele;
begin
  window(20,7,60,18);
  textcolor(blue);
  textbackground(lightgray);
  write('ษอออออออออออออออออออออออออออออออออออออออป');
  write('บ       A    G    E    N    D    A      บ');
  write('ฬออออออออ ENDERE€OS & TELEFONES ออออออออน');
  write('บ                                       บ');
  write('บ  Selecione uma das seguintes opไes:  บ');
  write('บ       * altera um nome                บ');
  write('บ       * pesquisa um nome              บ');
  write('บ       * consulta geral                บ');
  write('บ       * retorno ao menu geral         บ');
  write('บ                                       บ');
  write('ศอออออออออออออออออออออออออออออออออออออออผ');
  gotoxy(9,2);
  textcolor(yellow);
  write('A    G    E    N    D    A');
  textbackground(black);
  window(1,1,80,25);
end; (* endtele *)

{  Reservado para versไes futuras
procedure consulta;
begin
  write('AGENDA                                                                  CONSULTA');
  write('             ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ');
  write('          ฺฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ');
  write('       ฺฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ ณ');
  write('     ฺฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ ณ ณ');
  write('     ณ ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ ณ ณ');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ ณ รฤู');
  write('     ณ บ Nome: _____________________________________  fone: _________ บ ณ รฤู  ');
  write('     ณ ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ รฤู    ');
  write('     ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู      ');
  write('                      Pressione: ESC p/ retornar ao menu                       ');                           
  write('                                 ENTER p/ continuar'                            );
end; (* consulta *)
}
procedure entratel;
begin
  fundoTelas;
  window(14,9,71,20);
  textbackground(blue);
  write('ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
  write('บ        E N D E R E € O S  &  T E L E F O N E S         บ');
  write('บ                                                        บ');
  write('บ                                                        บ');
  write('บ   Nome:______________________________ Fone:__________  บ');
  write('บ   Endereo: _________________________________________  บ');
  write('บ   Numero: _____          Bairro: ____________________  บ');
  write('บ   Cidade: _________________________        Estado: __  บ');
  write('บ      CEP: _____                                        บ');
  write('บ                                                        บ');
  write('ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
  textbackground(black);
  window(1,1,80,25);
end; (* entratel *)

procedure comprom;
begin
  window(20,7,60,18);
  textcolor(red);
  textbackground(lightgray);
  write('ษอออออออออออออออออออออออออออออออออออออออป');
  write('บ                                       บ');
  write('ฬอออออออออออออ COMPROMISSOS ออออออออออออน');
  write('บ                                       บ');
  write('บ  Selecione uma das seguintes opไes:  บ');
  write('บ                                       บ');
  write('บ       * incluir dados                 บ');
  write('บ       * consulta ao banco de dados    บ');
  write('บ       * retorno ao menu geral         บ');
  write('บ                                       บ');
  write('ศอออออออออออออออออออออออออออออออออออออออผ');
  gotoxy(9,2);
  textcolor(yellow);
  write('A    G    E    N    D    A');
  textbackground(black);
  window(1,1,80,25);
end; (* comprom *)

procedure entracom;
begin
  fundoTelas;
  window(14,9,71,20);
  textbackground(red);
  write('ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
  write('บ                  COMPROMISSOS DO DIA                   บ');
  write('บ                                                        บ');
  write('บ                                      Data:__/__/__     บ');
  write('บ    __________________________________________________  บ');
  write('บ    __________________________________________________  บ');
  write('บ    __________________________________________________  บ');
  write('บ    __________________________________________________  บ');
  write('บ    __________________________________________________  บ');
  write('บ                                                        บ');
  write('ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
  textbackground(black);
  window(1,1,80,25);
end; (* entracom *)

{  Reservado para versไes futuras}
procedure notas;
begin
   write('AGENDA                                                          Consulta/Inclusฦo');
   writeln('   ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ');
   writeln('ฺฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ');
   writeln('ณ  ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป  ณ ณ');
   writeln('ณ  บ                         A N O T A € ๅ E S                          บ  ณ ณ');
   writeln('ณ  ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  บ                                                                    บ  ณ ณ');
   writeln('ณ  ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ  รฤู');
   writeln('ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู');
end; (* notas *)


end.
