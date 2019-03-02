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
  procedure U_RefreshEle;
  end;
var  Form7: TForm7;
procedure U_OpenElement(iEle:Pointer);
function  I_FindFormEle(iEle:Pointer):Tform7;// Ищим форму с Элементом
implementation {$R *.lfm}{ TForm7 }
procedure U_OpenElement(iEle:Pointer);
var lForm7:TForm7;
begin
  if I_FindFormEle(iEle)=nil then begin
  lForm7:=TForm7.Create(application);
  lForm7.Visible:=True;
  lForm7.Ele:=iEle;
  lForm7.U_RefreshEle
  end else I_FindFormEle(iEle).SetFocus;
end;
function  I_FindFormEle(iEle:Pointer):Tform7;// Ищим форму с Элементом
var Rez:Tform7;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform7) then
if  (application.Components[f] as tform7).visible then
if ((application.Components[f] as tform7).Ele=iEle) then
     REz:=application.Components[f] as tform7;
I_FindFormEle:=Rez;
end;
procedure TForm7.U_RefreshEle;
begin
  I_GetN(Ele,Edit1);
  I_GetX(Ele,Edit2);
  I_GetY(Ele,Edit3);
  I_GetZ(Ele,Edit4);
  I_GetC(Ele,Edit8);
  I_GetA(Ele,Edit9);
  I_GeUX(Ele,Edit5);
  I_GeUY(Ele,Edit6);
  I_GeUZ(Ele,Edit7);
  I_RefSpiVers(Ele,CheckListBox1);
  I_RefSpiEles(Ele,CheckListBox2);
end;
procedure TForm7.MenuItem1Click(Sender: TObject);
begin
  I_AddVer(Ele);
  I_RefSpiVers(Ele,CheckListBox1);
end;
procedure TForm7.Edit1Change(Sender: TObject);
begin
    I_SetN(Ele,Edit1);
end;
procedure TForm7.CheckListBox1DblClick(Sender: TObject);
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   U_OpenPoint(CheckListBox1.Items.Objects[CheckListBox1.ItemIndex],Ele);
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
  I_SeUX(Ele,Edit5);
end;
procedure TForm7.Edit6Change(Sender: TObject);
begin
  I_SeUY(Ele,Edit6);
end;
procedure TForm7.Edit7Change(Sender: TObject);
begin
  I_SeUZ(Ele,Edit7);
end;
procedure TForm7.Edit8Change(Sender: TObject);
begin
  I_SetC(Ele,Edit8);
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
  I_SetA(Ele,Edit9);// Устанавливает прозрачность
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
   I_DelVer(CheckListBox1.items.objects[CheckListBox1.itemindex]);
end;
procedure TForm7.MenuItem3Click(Sender: TObject);
begin
  I_AddEle(Ele);
  I_RefSpiEles(Ele,CheckListBox2);
end;
procedure TForm7.MenuItem4Click(Sender: TObject);
begin

   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then
   i_DelEle(CheckListBox2.items.objects[CheckListBox2.itemindex]);

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




