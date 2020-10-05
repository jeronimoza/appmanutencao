unit Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls, Vcl.ComCtrls, System.SyncObjs;

type
  TfThreads = class(TForm)
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    FPosition: Integer;
    function CreateAnonymousThread(const ASleep: Integer): TThread;
  public
  end;

var
  fThreads: TfThreads;

implementation

{$R *.dfm}

procedure TfThreads.Button1Click(Sender: TObject);
begin
  FPosition := 0;
  CreateAnonymousThread(string(Edit1.Text).ToInteger()).Start();
  CreateAnonymousThread(string(Edit2.Text).ToInteger()).Start();
end;

function TfThreads.CreateAnonymousThread(const ASleep: Integer): TThread;
begin
  Result := TThread.CreateAnonymousThread(
    procedure()
    var
      LIndex: Integer;
    begin
      for LIndex := 0 to 99 do
      begin
        TThread.Sleep(ASleep);
        TInterlocked.Increment(FPosition);
        TThread.Synchronize(nil,
          procedure()
          begin
            ProgressBar1.Position := FPosition;
          end);
      end;
    end);
end;

end.
