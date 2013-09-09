unit agoutros; (* rotinas diversas *)

(*                    A G E N D A                 *)
(*                vers∆o 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licenáa GPL. *)

interface

uses crt,
     mylib,
     agtelas;

const enter     = 13;
      esc       = 27;
      f1        = 59;
      f2        = 60;
      f3        = 61;
      setacima  = 72;
      setabaixo = 80;


function verificaerro(cod : integer) : boolean;
function key : integer;
procedure senha;
procedure apresentacao;
function cripto(seq : string) : string;

implementation

function verificaerro(cod : integer) : boolean;

var mens    : string[80];

begin
  if cod <> 0 then
  begin
    window(1,1,80,25);
    textbackground(black);
    gotoxy(1,24);
    delline;
    case cod of
      2   : mens:='ARQUIVO DE DADOS N«O ENCONTRADO';
      100 : mens:='ERRO DE LEITURA EM DISCO';
      101 : mens:='DISCO CHEIO';
      152 : mens:='DISCO AUSENTE';
      else mens:= 'ERRO DE E/S';
    end; (* case *)
    textcolor(white);
    gotoxy(20,24);
    write(mens);
    textcolor(blink+white);
    gotoxy(52,24);
    write('Pressione ESC');
    textcolor(black);
    write(' ',bs);
    beep;
    waitesc;
    gotoxy(20,24);
    clreol; 
    verificaerro:=true;
  end
  else
    verificaerro:=false;
end; (* verifica erro *)

function key : integer;

var k : integer;

begin
  k:=ord(readkey);
  if k=0 then
    k:=ord(readkey);
  key:=k;
end; (* key *)

function cripto(seq : string) : string;

var cont   : byte;

begin
  for cont:= 1 to length(seq) do
    seq[cont]:= chr(ord(seq[cont]) + length(seq) + cont);
  cripto:= seq;
end;

procedure senha;

type tipsenha = string[60];

var j,
    senha   : tipsenha;
    x,
    coluna,
    linha   : integer;
    a       : char;
    f       : file of tipsenha;

begin
  assign(f,'senha.sss');     {$I-}
  reset(f);                  {$I+}
  if ioresult <> 0 then
  begin
     write('Senha inexistente');
     beep;
     halt;
  end;
  read(f,senha);
  writeln;
  writeln('AGENDA - vers∆o 2.3');
  write('Entre senha: ');
  j:='';
  x:=0;
  coluna:=wherex;
  linha:=wherey;
  repeat
    a:=readkey;
    if a<> chr(ENTER) then
      j:=concat(j,a);
    x:=x+1;
    gotoxy(coluna+x,linha);
  until (a = chr(ENTER)) or (x = 60);
  writeln;
  if cripto(j) <> senha then
    halt;
end; (* senha *)

procedure apresentacao;
begin
  gotoxy(1,1);
  nocursor;
  tela_de_apresentacao;
  delay(1500);
  clrscr;
end; (* apresentacao *)

end. (* agoutros *)
