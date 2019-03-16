unit Unit6; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus, StdCtrls,Unit3,unit7,unit8,unit9,unit10,Types;
type

  { TForm6 }

  TForm6 = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    CheckListBox4: TCheckListBox;
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
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;

    procedure CheckListBox1DblClick(Sender: TObject);
    procedure CheckListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure CheckListBox2DblClick(Sender: TObject);
    procedure CheckListBox2SelectionChange(Sender: TObject; User: boolean);
    procedure CheckListBox3DblClick(Sender: TObject);
    procedure CheckListBox3SelectionChange(Sender: TObject; User: boolean);
    procedure CheckListBox4DblClick(Sender: TObject);
    procedure CheckListBox4SelectionChange(Sender: TObject; User: boolean);
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
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public
  OBJ:Pointer;
  MHeight:Longint;
  procedure U_RefreshObj;
  end;

var
  Form6: TForm6;

procedure U_OpenObject(iObj:Pointer);
function  I_FindFormObj(iObj:Pointer):Tform6;// Ищим форму с ОБьектом
implementation {$R *.lfm}{ TForm6 }
procedure U_OpenObject(iObj:Pointer);
var lForm6:TForm6;
begin
  if I_FindFormObj(iObj)=nil then begin
  lForm6:=TForm6.Create(application);
  lForm6.Visible:=True;
  lForm6.Obj:=iObj;
  lForm6.U_RefreshObj;
  end else I_FindFormObj(iObj).SetFocus;
end;
function  I_FindFormObj(iObj:Pointer):Tform6;// Ищим форму с ОБьектом
var Rez:Tform6;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform6) then
if  (application.Components[f] as tform6).visible then
if ((application.Components[f] as tform6).Obj=iObj) then
     REz:=application.Components[f] as tform6;
I_FindFormObj:=Rez;
end;
procedure TForm6.U_RefreshObj;
begin
 I_GetN(Obj,Edit1);
 I_GetX(Obj,Edit2);
 I_GetY(Obj,Edit3);
 I_GetZ(Obj,Edit4);
 I_GetC(Obj,Edit8);
 I_GetA(Obj,Edit9);
 I_GeUX(Obj,Edit5);
 I_GeUY(Obj,Edit6);
 I_GeUZ(Obj,Edit7);
 I_RefSpiVers(Obj,CheckListBox1);
 I_RefSpiLins(Obj,CheckListBox2);
 I_RefSpiPlos(Obj,CheckListBox3);
 I_RefSpiEles(Obj,CheckListBox4);
end;
procedure TForm6.MenuItem5Click(Sender: TObject);
begin
 I_AddPlo(Obj);
 I_RefSpiPlos(obj,CheckListBox3);
end;
procedure TForm6.MenuItem6Click(Sender: TObject);
begin
   if CheckListBox3.itemindex<CheckListBox3.items.count then
   if CheckListBox3.itemindex>0 then
   i_DelPLo(CheckListBox3.items.objects[CheckListBox3.itemindex]);
end;
procedure TForm6.Edit1Change(Sender: TObject);
begin
  I_SetN(Obj,Edit1);
end;
procedure TForm6.CheckListBox1DblClick(Sender: TObject);
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   U_OpenPoint(CheckListBox1.Items.Objects[CheckListBox1.ItemIndex],Obj);
end;
procedure TForm6.CheckListBox1SelectionChange(Sender: TObject; User: boolean);
var f:Longint;
begin

 For f:=1 to CheckListBox1.Items.Count-1 do
 I_SetSel(CheckListBox1.Items.Objects[f],CheckListBox1.Selected[f])

end;
procedure TForm6.CheckListBox2DblClick(Sender: TObject);
begin
   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then
   U_OpenLine(CheckListBox2.Items.Objects[CheckListBox2.ItemIndex],Obj);
end;
procedure TForm6.CheckListBox2SelectionChange(Sender: TObject; User: boolean);
var f:Longint;
begin
 For f:=1 to CheckListBox2.Items.Count-1 do
 I_SetSel(CheckListBox2.Items.Objects[f],CheckListBox2.Selected[f])
end;
procedure TForm6.CheckListBox3DblClick(Sender: TObject);
begin
   if CheckListBox3.itemindex<CheckListBox3.items.count then
   if CheckListBox3.itemindex>0 then
   U_OpenPLos(CheckListBox3.Items.Objects[CheckListBox3.ItemIndex],Obj);
end;
procedure TForm6.CheckListBox3SelectionChange(Sender: TObject; User: boolean);
var f:Longint;
begin
 For f:=1 to CheckListBox3.Items.Count-1 do
 I_SetSel(CheckListBox3.Items.Objects[f],CheckListBox3.Selected[f])
end;
procedure TForm6.CheckListBox4DblClick(Sender: TObject);
begin
   if CheckListBox4.itemindex<CheckListBox4.items.count then
   if CheckListBox4.itemindex>0 then
   U_OpenElement(CheckListBox4.Items.Objects[CheckListBox4.ItemIndex]);
end;
procedure TForm6.CheckListBox4SelectionChange(Sender: TObject; User: boolean);
var f:Longint;
begin
 For f:=1 to CheckListBox4.Items.Count-1 do
 I_SetSel(CheckListBox4.Items.Objects[f],CheckListBox4.Selected[f])
end;
procedure TForm6.Edit2Change(Sender: TObject);
begin
  I_SetX(Obj,Edit2);
end;
procedure TForm6.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    if isFloat(TEdit(Sender).text) then
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm6.Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    if isFloat(TEdit(Sender).text) then
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
end;
procedure TForm6.Edit3Change(Sender: TObject);
begin
  I_SetY(Obj,Edit3);
end;
procedure TForm6.Edit4Change(Sender: TObject);
begin
  I_SetZ(Obj,Edit4);
end;
procedure TForm6.Edit5Change(Sender: TObject);
begin
  I_SeUX(Obj,Edit5);
end;
procedure TForm6.Edit6Change(Sender: TObject);
begin
  I_SeUY(Obj,Edit6);
end;
procedure TForm6.Edit7Change(Sender: TObject);
begin
  I_SeUZ(Obj,Edit7);
end;
procedure TForm6.Edit8Change(Sender: TObject);
begin
  I_SetC(Obj,Edit8);
end;
procedure TForm6.Edit8DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  edit8.Color:=ColorDialog1.Color;
  edit8.Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm6.Edit9Change(Sender: TObject);
begin
 I_SetA(Obj,Edit9);// Устанавливает прозрачность
end;
procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;
procedure TForm6.FormCreate(Sender: TObject);
begin
  MHeight:=height;
  left:=form3.Left+10;
  top:=form3.top+30;
end;
procedure TForm6.MenuItem1Click(Sender: TObject);
begin
  I_AddVer(obj);
  I_RefSpiVers(obj,CheckListBox1);
end;
procedure TForm6.MenuItem2Click(Sender: TObject);
var
  F:Longint;
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   I_DelVer(CheckListBox1.items.objects[CheckListBox1.itemindex]);
end;
procedure TForm6.MenuItem3Click(Sender: TObject);
begin
  I_AddLin(Obj);
  I_RefSpiLins(obj,CheckListBox2);
end;
procedure TForm6.MenuItem4Click(Sender: TObject);
begin
   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then
   i_DelLin(CheckListBox2.items.objects[CheckListBox2.itemindex]);
end;
procedure TForm6.MenuItem7Click(Sender: TObject);
begin
    I_AddEle(Obj);
    I_RefSpiEles(obj,CheckListBox4);
end;
procedure TForm6.MenuItem8Click(Sender: TObject);
begin

   if CheckListBox4.itemindex<CheckListBox4.items.count then
   if CheckListBox4.itemindex>0 then
   I_DelEle(CheckListBox4.items.objects[CheckListBox4.itemindex]);

end;
procedure TForm6.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  end;
end;
end.

