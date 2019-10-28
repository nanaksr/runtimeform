# runtimeform
Delphi Runtime Form

Penggunaan
```
procedure TForm1.Button1Click(Sender: TObject);
var
  cstmForm : TProfileForm;
  FrmName : String;
  I: Integer;
begin
  FrmName := 'nameform';
  if not Assigned(FindComponent(FrmName) as TProfileForm) then
  begin
    cstmForm := TProfileForm.Create(Self);
    cstmForm.Name := FrmName;
  end;
end;
```
