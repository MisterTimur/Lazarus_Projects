unit Unit12; {$mode objfpc}{$H+}  interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,unit3;
type  { TForm12 }  TForm12 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
  private

  public
  Ani:Pointer;
  procedure U_RefreshAni;
  end;
var Form12: TForm12;
function  I_FindFormAni(iAni:Pointer):Tform12;// Ищим форму с Анимацией
implementation  {$R *.lfm}
function  I_FindFormAni(iAni:Pointer):Tform12;// Ищим форму с Анимацией
var Rez:Tform12;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform12) then
if  (application.Components[f] as tform12).visible then
if ((application.Components[f] as tform12).Ani=iAni) then
     REz:=application.Components[f] as tform12;
I_FindFormAni:=Rez;
end;
procedure U_OpenAnimation(iAni:Pointer);
var lForm12:TForm12;
begin
  If I_FindFormAni(iAni)=Nil then begin
  lForm12:=TForm12.Create(application);
  lForm12.Visible:=True;
  lForm12.Ani:=iAni;
  lForm12.U_RefreshAni;
  end else I_FindFormAni(iAni).SetFocus; end;
procedure TForm12.U_RefreshAni;
begin
I_GetN(ANI,Edit1 );
end;

end.

