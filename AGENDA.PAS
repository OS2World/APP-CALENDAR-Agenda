program agenda;

(*                    A G E N D A                 *)
(*                vers∆o 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licenáa GPL. *)

{$V-}

uses crt,                          
     dos,                          
     mylib,                        

     agtelas,
     agendtel,
     agcomp,
     agoutros;

var  hora,
     hor,
     min,
     mi,
     seg,
     se,
     centseg : word;


procedure mostraopcao(opcao : integer);
begin
  menu;
  gotoxy(28,12+opcao);
  textbackground(white);
  textcolor(black);
  case opcao of
    1 : write('* compromissos do dia');
    2 : write('* endereáo/telefone  ');
    3 : write('* abandona agenda    ');
  end;
  nocursor;
end; (* mostraopcao *)

procedure seleciona(var opcao : byte);

const ultima = 3;
      esp    = 32;

var tecla    : integer;

begin
  mostraopcao(opcao);
  repeat
    tecla:=key;
    case tecla of
      setacima      : begin
                        opcao:=opcao-1;
                        if opcao < 1 then
                          opcao:=ultima;
                      end;
      setabaixo,esp : begin
                        opcao:=opcao+1;
                        if opcao > ultima then
                          opcao:=1;
                      end;
      f1            : opcao:=1;
      f2            : opcao:=2;
      esc           : opcao:=ultima;
    end; (* case tecla *)
    mostraopcao(opcao)
  until tecla in [enter,f1..f2,esc];
end; (* seleciona *)

procedure finaliza(var conf : boolean);

var confirma : char;

begin
  gotoxy(28,23);
  textbackground(black);
  textcolor(white);
  write('Abandonar AGENDA (s/n)? ',bs);
  repeat
    confirma:=upcase(chr(key));
  until confirma in ['S','N',chr(ENTER)];
  gotoxy(28,23);
  clreol;
  if confirma = 'S' then
  begin
    clrscr;
    gettime(hor,mi,se,centseg);
    write('Agenda ativa por ');
    tempo_gasto(hora,min,seg,hor,mi,se);
    textcolor(lightgray);
    writeln;
    conf:=true;
  end
  else
    conf:=false;
end; (* finaliza *)

procedure menugeral;

var opcao : byte;
    conf  : boolean;

begin
  conf:=false;
  opcao:=1;
  repeat
     seleciona(opcao);
     case opcao of
       1 : compromissos;
       2 : endtel;
{      3 : anota; }
       3 : finaliza(conf);
     end; (* case *)
  until conf
end; (* menugeral *)


begin
  gettime(hora,min,seg,centseg);
  esp:=95;
  if (paramcount <> 0) and (paramstr(1) ='/v') then
  begin
    if not(algo_para_hoje) then
      halt ;
  end
  else
  begin
{   senha; }
    apresentacao;
  end;
  menugeral;
end. (* agenda *)