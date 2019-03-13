unit Unit5;{$mode objfpc}{$H+}interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus,Unit3,unit6,unit7,unit8,unit13,StdCtrls;
type

  { TForm5 }

  TForm5 = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure CheckListBox1DblClick(Sender: TObject);
    procedure CheckListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure CheckListBox3DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  mHeight:longint;
  procedure U_RefreshObjs;
  end;

var
  Form5: TForm5;

procedure U_OpenObjects();
function  I_FindFormObjs:Tform5;// Ищим форму с списком обьектов
implementation {$R *.lfm} { TForm5 }uses unit4;
procedure U_OpenObjects();
var
  lForm5:TForm5;
begin
 lForm5:=Tform5.create(application);
 lForm5.visible:=true;
 lForm5.U_RefreshObjs;
end;
function  I_FindFormObjs:Tform5;// Ищим форму с списком обьектов
var Rez:Tform5;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform5) then
if  (application.Components[f] as tform5).visible then
     REz:=application.Components[f] as tform5;
I_FindFormObjs:=Rez;
end;
procedure TForm5.U_RefreshObjs;
begin
 I_RefSpiObjs(CheckListBox1);
 I_RefSpiAnis(CheckListBox2);
 I_RefSpiScrs(CheckListBox3);
end;
procedure TForm5.MenuItem1Click(Sender: TObject);
begin
  I_AddObj;
  I_RefSpiObjs(CheckListBox1);
end;
procedure TForm5.MenuItem2Click(Sender: TObject);
var f:Longint;
begin

  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then begin
  i_DelObj(CheckListBox1.items.objects[CheckListBox1.itemindex]);
  I_RefSpiObjs(CheckListBox1);
  end;

end;
procedure TForm5.MenuItem3Click(Sender: TObject); // Добавить анимацию
begin
  I_AddAni;
end;
procedure TForm5.MenuItem4Click(Sender: TObject);// Удалить анимацию
begin
  if CheckListBox2.itemindex<CheckListBox2.items.count then
  if CheckListBox2.itemindex>0 then begin
  i_DelAni(CheckListBox2.items.objects[CheckListBox2.itemindex]);
  I_RefSpiAnis(CheckListBox2);
  end;
end;
procedure TForm5.MenuItem5Click(Sender: TObject); // создаеться Копия обьекта
begin
  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then  begin
  I_DoubleObject(CheckListBox1.items.objects[CheckListBox1.itemindex],CheckListBox1);
  end;
end;
procedure TForm5.MenuItem6Click(Sender: TObject);
var
  m:Tmemo;
begin
  I_SET_ANIMATION(CheckListBox2);
end;
procedure TForm5.MenuItem9Click(Sender: TObject);// Создать скрипт
begin
  I_AddScr;
end;
procedure TForm5.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  end;
end;
procedure TForm5.Panel1DblClick(Sender: TObject);
begin

end;
procedure TForm5.Timer1Timer(Sender: TObject);
begin
end;
procedure TForm5.CheckListBox1DblClick(Sender: TObject);
begin
  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then
  U_OpenObject(CheckListBox1.items.objects[CheckListBox1.itemindex]);
end;
procedure TForm5.CheckListBox1SelectionChange(Sender: TObject; User: boolean);
var F:Longint;
begin
 for f:=1 to CheckListBox1.items.Count-1 do
 I_SetSel(CheckListBox1.items.objects[f],CheckListBox1.Selected[f])
end;
procedure TForm5.CheckListBox3DblClick(Sender: TObject);
begin
  if CheckListBox3.itemindex<CheckListBox3.items.count then
  if CheckListBox3.itemindex>0 then
  U_OpenScript(CheckListBox3.items.objects[CheckListBox3.itemindex]);
end;
procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  form4.MenuItem5.Enabled:=true;
end;
procedure TForm5.FormCreate(Sender: TObject);
begin
  mHeight:=Height;
  left:=form3.left+form3.width-width-10;
  top :=form3.top+30;
end;
procedure TForm5.MenuItem10Click(Sender: TObject); // удалить скрипт
begin
  if CheckListBox3.itemindex<CheckListBox3.items.count then
  if CheckListBox3.itemindex>0 then begin
  i_DelScr(CheckListBox3.items.objects[CheckListBox3.itemindex]);
  I_RefSpiScrs(CheckListBox3);
  end;
end;

end.

