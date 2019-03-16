unit Unit13;{$mode objfpc}{$H+}interface
uses
  Classes, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls,Unit3;
type { TForm13 } TForm13 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public
  Scr:Pointer;
  procedure U_RefreshScr;
  end;
var Form13: TForm13;
procedure U_OpenScript(iScr:Pointer);
function  I_FindFormScr(iScr:Pointer):Tform13;// Ищим форму с скриптом
implementation {$R *.lfm}
function  I_FindFormScr(iScr:Pointer):Tform13;// Ищим форму с скриптом
var Rez:Tform13;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform13) then
if  (application.Components[f] as tform13).visible then
if ((application.Components[f] as tform13).Scr=iScr) then
     REz:=application.Components[f] as tform13;
I_FindFormScr:=Rez;
end;
procedure U_OpenScript(iScr:Pointer);
var lForm13:TForm13;
begin
  If I_FindFormScr(iScr)=Nil then begin
  lForm13:=TForm13.Create(application);
  lForm13.Visible:=True;
  lForm13.Scr:=iScr;
  lForm13.U_RefreshScr;
  end else I_FindFormScr(iScr).SetFocus; end;
procedure TForm13.U_RefreshScr;
begin
I_GetN(Scr,Edit1);
I_GetT(Scr,memo1);
end;
procedure TForm13.Edit1Change(Sender: TObject);
begin
  I_SetN(Scr,Edit1);
end;
procedure TForm13.Button1Click(Sender: TObject);
begin
  I_RUN(Scr,memo1);
end;
procedure TForm13.Memo1Change(Sender: TObject);
begin
  I_SetT(Scr,memo1);
end;
end.

