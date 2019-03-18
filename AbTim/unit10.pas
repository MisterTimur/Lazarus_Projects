unit Unit10; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,unit3, Types;
type

  { TForm10 }

  TForm10 = class(TForm)
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit3MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit6DblClick(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit7DblClick(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit8DblClick(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit9DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public
  MHeight:Longint;
  rELE:POinter;
  PLO:POinter;
  procedure U_RefreshPlo;
  end;

var
  Form10: TForm10;

procedure U_OpenPLos(iPlo,irEle:Pointer);
function  I_FindFormPLo(iPLo:Pointer):Tform10;// Ищим форму с Плоскостью
implementation {$R *.lfm} { TForm10 }
procedure U_OpenPLos(iPlo,irEle:Pointer);
var lForm10:TForm10;
begin
  If I_FindFormPlo(iPlo)=Nil then begin
  lForm10:=TForm10.Create(application);
  lForm10.Visible:=True;
  lForm10.Plo:=iPlo;
  lForm10.rEle:=irEle;
  lForm10.U_RefreshPlo;
  end else I_FindFormPlo(iPlo).SetFocus;
end;
function  I_FindFormPLo(iPLo:Pointer):Tform10;// Ищим форму с Плоскостью
var Rez:Tform10;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform10) then
if  (application.Components[f] as tform10).visible then
if ((application.Components[f] as tform10).PLO=iPLO) then
     REz:=application.Components[f] as tform10;
I_FindFormPLO:=Rez;
end;
procedure TForm10.U_RefreshPlo;
begin
I_GetN(PLO,Edit1 );
I_GetC(PLO,Edit3 );
I_GetA(PLO,Edit4 );
I_GeMl(Plo,edit5 );
// Цвета вершин
I_GCV1(PLO,Edit6 );
I_GCV2(PLO,Edit7 );
I_GCV3(PLO,Edit8 );
I_GCV4(PLO,Edit9 );
// прозрачность вершин
I_GAV1(PLO,Edit10 );
I_GAV2(PLO,Edit11 );
I_GAV3(PLO,Edit12 );
I_GAV4(PLO,Edit13 );
end;
procedure TForm10.Edit1Change(Sender: TObject);
begin
  I_SetN(Plo,Edit1);
end;
procedure TForm10.Edit10Change(Sender: TObject);
begin
I_SAV1(Plo,Edit10);
end;
procedure TForm10.Edit11Change(Sender: TObject);
begin
I_SAV2(Plo,Edit11)
end;
procedure TForm10.Edit12Change(Sender: TObject);
begin
I_SAV3(Plo,Edit12);
end;
procedure TForm10.Edit13Change(Sender: TObject);
begin
  I_SAV4(Plo,Edit13);
end;
procedure TForm10.Edit2Change(Sender: TObject);
begin
end;
procedure TForm10.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
    if inFloat(TEdit(Sender).Text)<1 then TEdit(Sender).Text:='3';
end;
procedure TForm10.Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
  if inFloat(TEdit(Sender).Text)>3 then TEdit(Sender).Text:='1';
end;
procedure TForm10.Edit3Change(Sender: TObject);
begin
  I_SetC(Plo,Edit3);
end;
procedure TForm10.Edit3DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit3MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
      TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-1);
end;
procedure TForm10.Edit3MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
        TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+1);
end;
procedure TForm10.Edit4Change(Sender: TObject);
begin
  I_SetA(Plo,Edit4);
end;
procedure TForm10.Edit5Change(Sender: TObject);
begin
 I_SeMl(Plo,edit5);
end;
procedure TForm10.Edit5DblClick(Sender: TObject);
begin
   if Edit5.Text='1' then Edit5.Text:='2' else
   if Edit5.Text='2' then Edit5.Text:='3' else
   if Edit5.Text='3' then Edit5.Text:='1' else Edit5.Text:='1';
end;
procedure TForm10.Edit6Change(Sender: TObject);
begin
I_SCV1(Plo,Edit6);
end;
procedure TForm10.Edit6DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit7Change(Sender: TObject);
begin
I_SCV2(Plo,Edit7);
end;
procedure TForm10.Edit7DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit8Change(Sender: TObject);
begin
  I_SCV3(Plo,Edit8);
end;
procedure TForm10.Edit8DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit9Change(Sender: TObject);
begin
I_SCV4(Plo,Edit9);
end;
procedure TForm10.Edit9DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.FormCreate(Sender: TObject);
begin
  MHeight:=Height;
end;
procedure TForm10.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Top:=Top-(MHeight-height);
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  Top:=Top+MHeight-height;
  end;
end;

end.

