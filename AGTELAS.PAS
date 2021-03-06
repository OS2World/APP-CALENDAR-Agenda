unit agtelas; (* telas da agenda *)

(*                    A G E N D A                 *)
(*                vers�o 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licen�a GPL. *)

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
  writeln('�����������������������������������������������������ͻ');
  writeln('�                                                     �');
  writeln('�     �����ͻ                            �            �');
  writeln('�     �     �                            �            �');
  writeln('�     �����͹  ����ͻ  ���ͻ  ���ͻ  ���͹  ���ͻ     �');
  writeln('�     �     �  �    �  ���ͼ  �   �  �   �  �   �     �');
  writeln('�     �     �  ����͹  �����  �   �  �����  ������    �');
  writeln('�                   �                                 �');
  writeln('�               ���ͼ                                 �');
  writeln('�     vers�o 2.3.3                            2001    �');
  writeln('�����������������������������������������������������ͼ');
  textbackground(black);
  window(1,1,80,25);
end; (* tela_de_apresenta��o *)

procedure fundoTelas;
begin
  window(11,5,80,21);
  textcolor(white);
  write('      ��������������������������������������������������������������Ŀ');
  write('    ��������������������������������������������������������������Ŀ �');
  write('  ��������������������������������������������������������������Ŀ � �');
  write('��������������������������������������������������������������Ŀ � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � � �');
  write('�                                                              � � ���');
  write('�                                                              � ���  ');
  write('�                                                              ���    ');
  write('����������������������������������������������������������������      ');
end; (* fundoTelas *)

procedure menu;
begin
  window(20,7,60,18);
  textcolor(white);
  textbackground(blue);
  write('���������������������������������������ͻ');
  write('�       A    G    E    N    D    A      �');
  write('��������������� MENU GERAL ������������͹');
  write('�                                       �');
  write('�  Selecione uma das seguintes op��es:  �');
  write('�                                       �');
  write('�       * compromissos do dia           �');
  write('�       * endere�o/telefone             �');
  write('�       * abandona agenda               �');
  write('�                                       �');
  write('���������������������������������������ͼ');
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
  write('���������������������������������������ͻ');
  write('�       A    G    E    N    D    A      �');
  write('��������� ENDERE�OS & TELEFONES �������͹');
  write('�                                       �');
  write('�  Selecione uma das seguintes op��es:  �');
  write('�       * altera um nome                �');
  write('�       * pesquisa um nome              �');
  write('�       * consulta geral                �');
  write('�       * retorno ao menu geral         �');
  write('�                                       �');
  write('���������������������������������������ͼ');
  gotoxy(9,2);
  textcolor(yellow);
  write('A    G    E    N    D    A');
  textbackground(black);
  window(1,1,80,25);
end; (* endtele *)

{  Reservado para vers�es futuras
procedure consulta;
begin
  write('AGENDA                                                                  CONSULTA');
  write('             ����������������������������������������������������������������Ŀ');
  write('          �����������������������������������������������������������������Ŀ �');
  write('       ������������������������������������������������������������������Ŀ � �');
  write('     ������������������������������������������������������������������Ŀ � � �');
  write('     � ��������������������������������������������������������������ͻ � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � � �');
  write('     � � Nome: _____________________________________  fone: _________ � � � ���');
  write('     � � Nome: _____________________________________  fone: _________ � � ���  ');
  write('     � ��������������������������������������������������������������ͼ ���    ');
  write('     ��������������������������������������������������������������������      ');
  write('                      Pressione: ESC p/ retornar ao menu                       ');                           
  write('                                 ENTER p/ continuar'                            );
end; (* consulta *)
}
procedure entratel;
begin
  fundoTelas;
  window(14,9,71,20);
  textbackground(blue);
  write('��������������������������������������������������������ͻ');
  write('�        E N D E R E � O S  &  T E L E F O N E S         �');
  write('�                                                        �');
  write('�                                                        �');
  write('�   Nome:______________________________ Fone:__________  �');
  write('�   Endere�o: _________________________________________  �');
  write('�   Numero: _____          Bairro: ____________________  �');
  write('�   Cidade: _________________________        Estado: __  �');
  write('�      CEP: _____                                        �');
  write('�                                                        �');
  write('��������������������������������������������������������ͼ');
  textbackground(black);
  window(1,1,80,25);
end; (* entratel *)

procedure comprom;
begin
  window(20,7,60,18);
  textcolor(red);
  textbackground(lightgray);
  write('���������������������������������������ͻ');
  write('�                                       �');
  write('�������������� COMPROMISSOS �����������͹');
  write('�                                       �');
  write('�  Selecione uma das seguintes op��es:  �');
  write('�                                       �');
  write('�       * incluir dados                 �');
  write('�       * consulta ao banco de dados    �');
  write('�       * retorno ao menu geral         �');
  write('�                                       �');
  write('���������������������������������������ͼ');
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
  write('��������������������������������������������������������ͻ');
  write('�                  COMPROMISSOS DO DIA                   �');
  write('�                                                        �');
  write('�                                      Data:__/__/__     �');
  write('�    __________________________________________________  �');
  write('�    __________________________________________________  �');
  write('�    __________________________________________________  �');
  write('�    __________________________________________________  �');
  write('�    __________________________________________________  �');
  write('�                                                        �');
  write('��������������������������������������������������������ͼ');
  textbackground(black);
  window(1,1,80,25);
end; (* entracom *)

{  Reservado para vers�es futuras}
procedure notas;
begin
   write('AGENDA                                                          Consulta/Inclus�o');
   writeln('   �������������������������������������������������������������������������Ŀ');
   writeln('��������������������������������������������������������������������������Ŀ �');
   writeln('�  ��������������������������������������������������������������������ͻ  � �');
   writeln('�  �                         A N O T A � � E S                          �  � �');
   writeln('�  ��������������������������������������������������������������������͹  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  �                                                                    �  � �');
   writeln('�  ��������������������������������������������������������������������ͼ  ���');
   writeln('����������������������������������������������������������������������������');
end; (* notas *)


end.
