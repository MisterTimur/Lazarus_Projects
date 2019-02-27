unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus,Unit3,unit6;

type

  { TForm5 }

  TForm5 = class(TForm)
    CheckListBox1: TCheckListBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    procedure CheckListBox1Click(Sender: TObject);
    procedure CheckListBox1DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.MenuItem1Click(Sender: TObject);
begin
  I_NewObject;
  I_RefreshSpisokObjects(CheckListBox1);
end;

procedure TForm5.MenuItem2Click(Sender: TObject);
begin
  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then
  i_DelObject(CheckListBox1.items.objects[CheckListBox1.itemindex]);
  I_RefreshSpisokObjects(CheckListBox1);
end;

procedure TForm5.CheckListBox1Click(Sender: TObject);
var F:Longint;
begin
 for f:=1 to CheckListBox1.items.Count-1 do
 if CheckListBox1.Selected[f]
 then I_SelSel(CheckListBox1.items.objects[f])
 else I_DelSel(CheckListBox1.items.objects[f]);
end;

procedure TForm5.CheckListBox1DblClick(Sender: TObject);
begin
  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then
  U_OpenObject(CheckListBox1.items.objects[CheckListBox1.itemindex]);
end;

end.
