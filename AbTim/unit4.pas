unit Unit4;{$mode objfpc}{$H+}interface uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, StdCtrls, Menus,UNit5,unit3, Types;
type { TForm4 } TForm4 = class(TForm)
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    procedure Edit1Change(Sender: TObject);
    procedure Edit1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit7DblClick(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public
  Act:Pointer;// Активный элемент в данный момент времени в редакторе
  end;
var Form4: TForm4;
implementation{$R *.lfm}{ TForm4 }
procedure TForm4.MenuItem5Click(Sender: TObject);
begin
   Tform5.create(application).show;
   MenuItem5.Enabled:=false;
end;
procedure TForm4.FormCreate(Sender: TObject);
begin
  Act:=nil;
  //left:=0;//form3.Left+form3.width-width-30;
  //top:=0;//form3.top+form3.height-height-10;
end;
procedure TForm4.Edit1Change(Sender: TObject);
begin
  I_SetX(Act,Edit1);
end;
procedure TForm4.Edit1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm4.Edit1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
end;
procedure TForm4.Edit2Change(Sender: TObject);
begin
 I_SetY(Act,Edit2);
end;
procedure TForm4.Edit3Change(Sender: TObject);
begin
 I_SetZ(Act,Edit3);
end;
procedure TForm4.Edit4Change(Sender: TObject);
begin
 I_SetUX(Act,Edit4);
end;
procedure TForm4.Edit5Change(Sender: TObject);
begin
 I_SetUY(Act,Edit5);
end;
procedure TForm4.Edit6Change(Sender: TObject);
begin
 I_SetUZ(Act,Edit6);
end;
procedure TForm4.Edit7Change(Sender: TObject);
begin
 I_SetCol(Act,Edit7);
end;
procedure TForm4.Edit7DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  edit7.Color:=ColorDialog1.Color;
  edit7.Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm4.Edit8Change(Sender: TObject);
begin
 I_SetAlp(Act,Edit8);
end;
end.

