unit Unit6; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus, StdCtrls,Unit3,unit7;

type

  { TForm6 }

  TForm6 = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    CheckListBox4: TCheckListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
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
    procedure CheckListBox1Click(Sender: TObject);
    procedure CheckListBox2Click(Sender: TObject);
    procedure CheckListBox3Click(Sender: TObject);
    procedure CheckListBox4Click(Sender: TObject);
    procedure CheckListBox4DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public
  OBJ:Pointer;
  end;

var
  Form6: TForm6;
procedure U_OpenObject(iObj:Pointer);
implementation {$R *.lfm}

procedure U_OpenObject(iObj:Pointer);
var lForm6:TForm6;
begin
  lForm6:=TForm6.Create(application);
  lForm6.Visible:=True;
  lForm6.Obj:=iObj;
  I_GetN(iObj,lForm6.Edit1);
  I_GetX(iObj,lForm6.Edit2);
  I_GetY(iObj,lForm6.Edit3);
  I_GetZ(iObj,lForm6.Edit4);
  I_GetUX(iObj,lForm6.Edit5);
  I_GetUY(iObj,lForm6.Edit6);
  I_GetUZ(iObj,lForm6.Edit7);
end;

{ TForm6 }

procedure TForm6.MenuItem5Click(Sender: TObject);
begin

end;
procedure TForm6.Edit1Change(Sender: TObject);
begin
  I_SetN(Obj,Edit1);
end;

procedure TForm6.CheckListBox1Click(Sender: TObject);
var f:Longint;
begin
 For f:=1 to CheckListBox1.Items.Count-1 do
 if CheckListBox1.Selected[f]
 then I_SelSel(CheckListBox1.Items.Objects[f])
 else I_DelSel(CheckListBox1.Items.Objects[f]);
end;
procedure TForm6.CheckListBox2Click(Sender: TObject);
var f:Longint;
begin
 For f:=1 to CheckListBox2.Items.Count-1 do
 if CheckListBox2.Selected[f]
 then I_SelSel(CheckListBox2.Items.Objects[f])
 else I_DelSel(CheckListBox2.Items.Objects[f]);
end;
procedure TForm6.CheckListBox3Click(Sender: TObject);
begin
end;
procedure TForm6.CheckListBox4Click(Sender: TObject);
var f:Longint;
begin
 For f:=1 to CheckListBox4.Items.Count-1 do
 if CheckListBox4.Selected[f]
 then I_SelSel(CheckListBox4.Items.Objects[f])
 else I_DelSel(CheckListBox4.Items.Objects[f]);
end;
procedure TForm6.CheckListBox4DblClick(Sender: TObject);
begin
   if CheckListBox4.itemindex<CheckListBox4.items.count then
   if CheckListBox4.itemindex>0 then
   U_OpenElement(CheckListBox4.Items.Objects[CheckListBox4.ItemIndex]);
end;
procedure TForm6.Edit2Change(Sender: TObject);
begin
  I_SetX(Obj,Edit2);
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
  I_SetUX(Obj,Edit5);
end;
procedure TForm6.Edit6Change(Sender: TObject);
begin
  I_SetUY(Obj,Edit6);
end;
procedure TForm6.Edit7Change(Sender: TObject);
begin
  I_SetUZ(Obj,Edit7);
end;
procedure TForm6.MenuItem1Click(Sender: TObject);
begin
  I_NewPoint(obj);
  I_RefreshSpisokPOints(obj,CheckListBox1);
end;
procedure TForm6.MenuItem2Click(Sender: TObject);
begin
   if CheckListBox1.itemindex<CheckListBox1.items.count then
   if CheckListBox1.itemindex>0 then
   i_DelPoint(CheckListBox1.items.objects[CheckListBox1.itemindex]);
   I_RefreshSpisokPoints(obj,CheckListBox1);
end;
procedure TForm6.MenuItem3Click(Sender: TObject);
begin
  I_NewPlos(Obj);
  I_RefreshSpisokPlos(obj,CheckListBox2);
end;
procedure TForm6.MenuItem4Click(Sender: TObject);
begin
   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then
   i_DelPLos(CheckListBox2.items.objects[CheckListBox2.itemindex]);
   I_RefreshSpisokPLos(obj,CheckListBox2);
end;
procedure TForm6.MenuItem7Click(Sender: TObject);
begin
    I_NewElement(Obj);
    I_RefreshSpisokElements(obj,CheckListBox4);
end;
procedure TForm6.MenuItem8Click(Sender: TObject);
var
  f:Longint;
begin

   if CheckListBox4.itemindex<CheckListBox4.items.count then
   if CheckListBox4.itemindex>0 then begin

   for f:=0 to application.ComponentCount-1 do
   if (application.Components[f] is tform7) then begin
      if I_RodEle((application.Components[f] as tform7).ELE,
      CheckListBox4.items.objects[CheckListBox4.itemindex]) then
      (application.Components[f] as tform7).close;

   end else
   if (application.Components[f] is tform6) then
      if I_RodEle((application.Components[f] as tform6).OBJ,
      CheckListBox4.items.objects[CheckListBox4.itemindex]) then
      (application.Components[f] as tform6).close;


   i_DelObject(CheckListBox4.items.objects[CheckListBox4.itemindex]);
   I_RefreshSpisokObjects(CheckListBox4);

end;
end;

end.

