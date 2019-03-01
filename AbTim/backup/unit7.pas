unit Unit7;{$mode objfpc}{$H+}interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus, StdCtrls,Unit3,unit8, Types;
type { TForm7 } TForm7 = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;

    procedure CheckListBox1DblClick(Sender: TObject);
    procedure CheckListBox1SelectionChange(Sender: TObject; User: boolean);

    procedure CheckListBox2DblClick(Sender: TObject);
    procedure CheckListBox2SelectionChange(Sender: TObject; User: boolean);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit8DblClick(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  Ele:Pointer;
  MHeight:Longint;
  end;
var  Form7: TForm7;
procedure U_OpenElement(iEle:Pointer);
implementation {$R *.lfm}{ TForm7 }
procedure U_OpenElement(iEle:Pointer);
var lForm7:TForm7;
begin
  lForm7:=TForm7.Create(application);
  lForm7.Visible:=True;
  lForm7.Ele:=iEle;
  I_GetN(iEle,lForm7.Edit1);
  I_GetX(iEle,lForm7.Edit2);
  I_GetY(iEle,lForm7.Edit3);
  I_GetZ(iEle,lForm7.Edit4);
  I_GetCol(iEle,lForm7.Edit8);
  I_GetAlp(iEle,lForm7.Edit9);
  I_GetUX(iEle,lForm7.Edit5);
  I_GetUY(iEle,lForm7.Edit6);
  I_GetUZ(iEle,lForm7.Edit7);
  I_RefreshSpisokPoints(iEle,lForm7.CheckListBox1);
  I_RefreshSpisokElements(iEle,lForm7.CheckListBox2);
end;
procedure TForm7.MenuItem1Click(Sender: TObject);
begin
  I_NewPoint(Ele);
  I_RefreshSpisokPOints(Ele,CheckListBox1);
end;
procedure TForm7.Edit1Change(Sender: TObject);
begin
    I_SetN(Ele,Edit1);
end;
procedure TForm7.CheckListBox1DblClick(Sender: TObject);
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   U_OpenPoints(CheckListBox1.Items.Objects[CheckListBox1.ItemIndex],Ele);
end;
procedure TForm7.CheckListBox1SelectionChange(Sender: TObject; User: boolean);
var f:Longint;
begin
For  f:=1 to CheckListBox1.Items.Count-1 do
I_SetSel(CheckListBox1.Items.Objects[f],CheckListBox1.Selected[f])
end;
procedure TForm7.CheckListBox2DblClick(Sender: TObject);
begin
   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then
   U_OpenElement(CheckListBox2.Items.Objects[CheckListBox2.ItemIndex]);
end;
procedure TForm7.CheckListBox2SelectionChange(Sender: TObject; User: boolean);
  var f:Longint;
begin
  For f:=1 to CheckListBox2.Items.Count-1 do
  I_SetSel(CheckListBox2.Items.Objects[f],CheckListBox2.Selected[f]);
end;
procedure TForm7.Edit2Change(Sender: TObject);
begin
    I_SetX(Ele,Edit2);
end;
procedure TForm7.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm7.Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
end;
procedure TForm7.Edit3Change(Sender: TObject);
begin
  I_SetY(Ele,Edit3);
end;
procedure TForm7.Edit4Change(Sender: TObject);
begin
  I_SetZ(Ele,Edit4);
end;
procedure TForm7.Edit5Change(Sender: TObject);
begin
  I_SetUX(Ele,Edit5);
end;
procedure TForm7.Edit6Change(Sender: TObject);
begin
  I_SetUY(Ele,Edit6);
end;
procedure TForm7.Edit7Change(Sender: TObject);
begin
  I_SetUZ(Ele,Edit7);
end;
procedure TForm7.Edit8Change(Sender: TObject);
begin
  I_SetCol(Ele,Edit8);
end;
procedure TForm7.Edit8DblClick(Sender: TObject);
begin

  if ColorDialog1.Execute then begin
  edit8.Color:=ColorDialog1.Color;
  edit8.Text:=intToStr(ColorDialog1.Color);
  end;

end;
procedure TForm7.Edit9Change(Sender: TObject);
begin
  I_SetAlp(Ele,Edit9);// Устанавливает прозрачность
end;
procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;
procedure TForm7.FormCreate(Sender: TObject);
begin
  MHeight:=Height;
  left:=form3.left+10;
  top:=form3.top+form3.height-height-10;
end;
procedure TForm7.MenuItem2Click(Sender: TObject);
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   i_DelPoint(CheckListBox1.items.objects[CheckListBox1.itemindex]);
   I_RefreshSpisokPoints(Ele,CheckListBox1);
end;
procedure TForm7.MenuItem3Click(Sender: TObject);
begin
  I_NewElement(Ele);
  I_RefreshSpisokElements(Ele,CheckListBox2);
end;
procedure TForm7.MenuItem4Click(Sender: TObject);
begin

   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then begin
   i_DelElement(CheckListBox2.items.objects[CheckListBox2.itemindex]);
   I_RefreshSpisokElements(Ele,CheckListBox2);
   end;

end;
procedure TForm7.Panel1Click(Sender: TObject);
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
procedure TForm7.Timer1Timer(Sender: TObject);
begin
end;
end.




