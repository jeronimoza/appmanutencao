unit Streams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfStreams = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FPath: string;

    //function LoadStream: TMemoryStream;
  public
  end;

  TFileInfo = record
  strict private
    class function LoadStream(const AFile: string): TMemoryStream; static;
  public
    ///<param name="AFile">Nome do arquivo com caminho completo.</param>
    ///<returns>O tamanho do arquivo em megabytes.</returns>
    class function GetFileSize(const AFile: string): Int64; static;
  end;

var
  fStreams: TfStreams;

implementation

{$R *.dfm}

procedure TfStreams.Button1Click(Sender: TObject);
{var
  S: TStream;
begin
  S := LoadStream;
  try
    Label1.Caption := 'Size: ' + (S.Size div 1024).ToString + ' MB';
  finally
    S.DisposeOf();
  end;}
begin
  Label1.Caption := Format('Size: %d MB', [TFileInfo.GetFileSize(FPath)]);
end;

procedure TfStreams.Button2Click(Sender: TObject);
{var
  i, SizeInc: Integer;
  S: TStream;
begin
  ProgressBar1.Position := 0;
  ProgressBar1.Max := 100;

  SizeInc := 0;
  Button2.Enabled := False;
  try
    for i := 0 to 99 do
    begin
      S := LoadStream;
      try
        SizeInc := SizeInc + S.Size;
      finally
        S.DisposeOf();
      end;
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;
    end;
  finally
    Button2.Enabled := True;
  end;

  Label2.Caption := (SizeInc div 1024).ToString + ' MB';}
var
  LCount, LSizeInc: Integer;
begin
  ProgressBar1.Position := 0;
  ProgressBar1.Max := 100;

  LSizeInc := 0;
  Button2.Enabled := False;
  try
    for LCount := 0 to 99 do
    begin
      LSizeInc := LSizeInc + TFileInfo.GetFileSize(FPath);
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages();
    end;
  finally
    Label2.Caption := Format('Size: %d MB', [LSizeInc]);
    Button2.Enabled := True;
  end;
end;

procedure TfStreams.FormCreate(Sender: TObject);
begin
  FPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'pdf.pdf';
end;

{function TfStreams.LoadStream: TMemoryStream;
begin
  Result := TMemoryStream.Create();
  if FileExists(FPath) then
  begin
    Result.LoadFromFile(FPath);
  end;
end;}

{ TFileInfo }

class function TFileInfo.GetFileSize(const AFile: string): Int64;
var
  LStream: TMemoryStream;
begin
  LStream := LoadStream(AFile);
  try
    Result := LStream.Size div 1024;
  finally
    LStream.DisposeOf();
  end;
end;

class function TFileInfo.LoadStream(const AFile: string): TMemoryStream;
begin
  Result := TMemoryStream.Create();
  if FileExists(AFile) then
    Result.LoadFromFile(AFile);
end;

end.
