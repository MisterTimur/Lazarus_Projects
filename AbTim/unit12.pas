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
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public
  Ani:Pointer;
  procedure U_RefreshAni;
  end;
var Form12: TForm12;
function  I_FindFormAni(iAni:Pointer):Tform12;// Ищим форму с Анимацией
procedure U_OpenAnimation(iAni:Pointer);
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
procedure TForm12.Memo1Change(Sender: TObject);
begin
    I_SetT(Ani,memo1);
end;
procedure TForm12.FormCreate(Sender: TObject);
begin
  Caption:='Animation';
  left:=OknoWidth(form3.left+form3.Width-width-10);
  top:=OknoHeight(form3.top+form3.height-height-50);
end;

procedure TForm12.Edit1Change(Sender: TObject);
begin
   I_SetN(Ani,Edit1);
end;

procedure TForm12.U_RefreshAni;
begin
I_GetN(ANI,Edit1 );
I_GetT(ANI,Memo1 );
end;
end.

