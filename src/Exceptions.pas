unit Exceptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Diagnostics;

type
  TfExceptions = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    Label2: TLabel;
    Button2: TButton;
    Memo3: TMemo;
    Label1: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FPath: string;

    procedure LoadNumbers(const AIgnore: Integer; const AResult: TMemo);
  public
  end;

var
  fExceptions: TfExceptions;

implementation

{$R *.dfm}

procedure TfExceptions.Button1Click(Sender: TObject);
var
  LWatch: TStopwatch;
begin
  try
    Memo1.Lines.Clear;
    Memo2.Lines.Clear;

    LWatch := TStopwatch.StartNew();
    try
      LoadNumbers(1, Memo2);
    finally
      LWatch.Stop();
      Label1.Caption := Format('Tempo de processamento: %d ms', [LWatch.ElapsedMilliseconds]);
    end;
  except on E: Exception do
    begin
      Memo1.Lines.Add('Classe Exception: ' + E.ClassName);
      Memo1.Lines.Add('Erro: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TfExceptions.Button2Click(Sender: TObject);
var
  i: Integer;
  LWatch: TStopwatch;
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;

  LWatch := TStopwatch.StartNew();
  try
    for i := 0 to 7 do
    begin
      try
        LoadNumbers(i, Memo2);
      except
        on LException: Exception do
        begin
          Memo1.Lines.Add('Classe Exception: ' + LException.ClassName);
          Memo1.Lines.Add('Erro: ' + LException.Message);
        end;
      end;
    end;
  finally
    LWatch.Stop();
    Label1.Caption := Format('Tempo de processamento: %d ms', [LWatch.ElapsedMilliseconds]);
  end;
end;

procedure TfExceptions.FormCreate(Sender: TObject);
begin
  FPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'text.txt';
end;

procedure TfExceptions.LoadNumbers(const AIgnore: Integer; const AResult: TMemo);
{var
  st: TStringList;
  i, y: Integer;
  s: string;
  LLines: TStrings;
begin
  st := TStringList.Create;
  try
    st.LoadFromFile(FPath);
    LLines := TStringList.Create();
    try
      for i := 0 to st.Count do
      begin
        s := st[i];
        for y := 1 to Length(s) do
        begin
          if not (s[y] = AIgnore.ToString) then
            LLines.Add(s[y]);
        end;
      end;
    finally
      AResult.SetSelText(LLines.Text);
      LLines.DisposeOf();
    end;
  finally
    st.DisposeOf();
  end;}
var
  st: TStringList;
  i: Integer;
  s: string;
  LChar: Char;
  LLines: TStrings;
begin
  st := TStringList.Create;
  try
    st.LoadFromFile(FPath);
    LLines := TStringList.Create();
    try
      for i := 0 to st.Count do
      begin
        s := st[i];
        for LChar in s do
        begin
          if not (LChar = AIgnore.ToString) then
            LLines.Add(LChar);
        end;
      end;
    finally
      AResult.SetSelText(LLines.Text);
      LLines.DisposeOf();
    end;
  finally
    st.DisposeOf();
  end;
end;

end.
