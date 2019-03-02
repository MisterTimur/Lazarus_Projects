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
    procedure Edit11DblClick(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
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
    procedure Edit7Change(Sender: TObject);
    procedure Edit7DblClick(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit9DblClick(Sender: TObject);
  private

  public
  ELE:POinter;
  PLO:POinter;
  procedure U_RefreshPlo;
  end;

var
  Form10: TForm10;

procedure U_OpenPLos(iPlo,iEle:Pointer);
function  I_FindFormPLo(iPLo:Pointer):Tform10;// Ищим форму с Плоскостью
implementation {$R *.lfm} { TForm10 }
procedure U_OpenPLos(iPlo,iEle:Pointer);
var lForm10:TForm10;
begin
  If I_FindFormPlo(iPlo)=Nil then begin
  lForm10:=TForm10.Create(application);
  lForm10.Visible:=True;
  lForm10.Plo:=iPlo;
  lForm10.Ele:=iEle;
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
I_GetR(PLO,Edit2 );
I_GetC(PLO,Edit3 );
I_GetA(PLO,Edit4 );
I_GPC1(PLO,Edit5 );
I_GPA1(PLO,Edit6 );
I_GPC2(PLO,Edit7 );
I_GPA2(PLO,Edit8 );
I_GPC3(PLO,Edit9 );
I_GPA3(PLO,Edit10);
I_GPC4(PLO,Edit11);
I_GPA4(PLO,Edit12);
end;
procedure TForm10.Edit1Change(Sender: TObject);
begin
  I_SetN(Plo,Edit1);
end;
procedure TForm10.Edit10Change(Sender: TObject);
begin
   I_SPA3(Plo,Edit10);
end;
procedure TForm10.Edit11Change(Sender: TObject);
begin
   I_SPC4(Plo,Edit11);
end;
procedure TForm10.Edit11DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit12Change(Sender: TObject);
begin
   I_SPA4(Plo,Edit12);
end;
procedure TForm10.Edit2Change(Sender: TObject);
begin
   I_SetR(Plo,Edit2);
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
  I_SPC1(Plo,Edit5);
end;
procedure TForm10.Edit5DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm10.Edit6Change(Sender: TObject);
begin
  I_SPA1(Plo,Edit6);
end;
procedure TForm10.Edit7Change(Sender: TObject);
begin
  I_SPC2(Plo,Edit7);
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
   I_SPA2(Plo,Edit8);
end;
procedure TForm10.Edit9Change(Sender: TObject);
begin
   I_SPC3(Plo,Edit9);
end;
procedure TForm10.Edit9DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
end.

