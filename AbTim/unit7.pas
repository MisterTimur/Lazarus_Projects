unit Unit7;{$mode objfpc}{$H+}interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus, StdCtrls,Unit3;
type { TForm7 } TForm7 = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
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
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure CheckListBox1Click(Sender: TObject);
    procedure CheckListBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  Ele:Pointer;
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
  I_GetUX(iEle,lForm7.Edit5);
  I_GetUY(iEle,lForm7.Edit6);
  I_GetUZ(iEle,lForm7.Edit7);
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
procedure TForm7.CheckListBox1Click(Sender: TObject);
 var f:Longint;
begin
 For  f:=1 to CheckListBox1.Items.Count-1 do
 if   CheckListBox1.Selected[f]
 then I_SelSel(CheckListBox1.Items.Objects[f])
 else I_DelSel(CheckListBox1.Items.Objects[f]);
end;
procedure TForm7.CheckListBox2Click(Sender: TObject);
var f:Longint;
begin
  For f:=1 to CheckListBox2.Items.Count-1 do
  if CheckListBox2.Selected[f]
  then I_SelSel(CheckListBox2.Items.Objects[f])
  else I_DelSel(CheckListBox2.Items.Objects[f]);
end;
procedure TForm7.Edit2Change(Sender: TObject);
begin
    I_SetX(Ele,Edit2);
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
procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

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
var
  f:Longint;
begin

   if CheckListBox2.itemindex<CheckListBox2.items.count then
   if CheckListBox2.itemindex>0 then begin

   for f:=0 to application.ComponentCount-1 do
   if (application.Components[f] is tform7) then
      if I_RodEle((application.Components[f] as tform7).ELE,
      CheckListBox2.items.objects[CheckListBox2.itemindex]) then
      (application.Components[f] as tform7).close;

   i_DelObject(CheckListBox2.items.objects[CheckListBox2.itemindex]);
   I_RefreshSpisokObjects(CheckListBox2);

end;
end;
procedure TForm7.Timer1Timer(Sender: TObject);
begin
end;
end.

