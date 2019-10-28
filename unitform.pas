unit Unitform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Vcl.StdCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Menus;
  
  TProfileForm = class(TCustomForm)
    Btn1 : TButton;
  private
    DialogStatus: PInteger;
    procedure OnClosing(Sender : TObject; var Action: TCloseAction);
  protected

  public
    constructor Create(AOwner: TComponent);
    reintroduce;
  end;
  
implementation

function GetWidthText(const Text:String; Font:TFont) : Integer;
var
  LBmp: TBitmap;
begin
  LBmp := TBitmap.Create;
  try
   LBmp.Canvas.Font := Font;
   Result := LBmp.Canvas.TextWidth(Text);
  finally
   LBmp.Free;
  end;
end;

constructor TProfileForm.Create(AOwner: TComponent);
var
  strbtn : string;
begin
  inherited CreateNew(AOwner);

  DefaultMonitor := dmMainForm;
  Position := poScreenCenter;
  FormStyle := fsStayOnTop;
  OnClose := OnClosing;

  Btn1 := TButton.Create(Self);
  Btn1.Caption := 'Save';
  Btn1.Width := GetWidthText(Btn1.Caption, Btn1.Font)+20;
  Btn1.Left := Self.Width-(Btn1.Width+10);
  Btn1.Top := Self.Height-(Btn1.Height+10);
  Btn1.Anchors := [akRight,akBottom];
  Btn1.Parent := Self;

  Show;
end;

procedure TProfileForm.OnClosing(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormShow(Sender: TObject);
const BoolToStr : array[boolean] of String = ('No','Yes');
var
  sl : TStringList;
  s,r : boolean;
  I: Integer;
  Item : TListItem;
begin
  ModemIni := TIniFile.Create(ExtractFilePath(Application.EXEName)+ 'modem.ini');
  sl := TStringList.Create;
  try
      ModemIni.ReadSections('', sl);
      for I := 0 to sl.Count-1 do
      begin
        Item := ListView1.Items.Add;
        Item.Caption := '';
        Item.SubItems.Add(sl[I]);
        Item.SubItems.Add(ModemIni.ReadString(sl[I], 'Baudrate', '115200'));
        Item.SubItems.Add(BoolToStr[ModemIni.ReadBool(sl[I], 'Sender', true)]);
        Item.SubItems.Add(ModemIni.ReadString(sl[I], 'Prefix', '+62'));
        Item.ImageIndex := 0;
      end;
  finally
    sl.Free;
  end;

end;
