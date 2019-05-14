unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Generics.Collections,CommDev, CommDevSub, CommTypes, StdCtrls,
  POSChkBox, ExtCtrls;

type
  TForm2 = class(TForm)
    InvPrinter1: TInvPrinter;
    InvPrinter2: TInvPrinter;
    InvPrinter12: TInvPrinter;
    InvPrinter11: TInvPrinter;
    InvPrinter10: TInvPrinter;
    InvPrinter9: TInvPrinter;
    InvPrinter8: TInvPrinter;
    InvPrinter7: TInvPrinter;
    InvPrinter3: TInvPrinter;
    InvPrinter4: TInvPrinter;
    InvPrinter5: TInvPrinter;
    InvPrinter6: TInvPrinter;
    EDCCom: TEDCCom;
    lb507060: TLabel;
    cb01a: TComboBox;
    lb507070: TLabel;
    cb01b: TComboBox;
    ck02: TPOSCheckBox;
    Label1: TLabel;
    cb02a: TComboBox;
    Label2: TLabel;
    cb02b: TComboBox;
    Label3: TLabel;
    cb03a: TComboBox;
    Label4: TLabel;
    cb03b: TComboBox;
    Label5: TLabel;
    cb04a: TComboBox;
    Label6: TLabel;
    cb04b: TComboBox;
    Label7: TLabel;
    cb05a: TComboBox;
    Label8: TLabel;
    cb05b: TComboBox;
    Label9: TLabel;
    cb06a: TComboBox;
    Label10: TLabel;
    cb06b: TComboBox;
    Label11: TLabel;
    cb07a: TComboBox;
    Label12: TLabel;
    cb07b: TComboBox;
    Label13: TLabel;
    cb08a: TComboBox;
    Label14: TLabel;
    cb08b: TComboBox;
    Label15: TLabel;
    cb09a: TComboBox;
    Label16: TLabel;
    cb09b: TComboBox;
    Label17: TLabel;
    cb10a: TComboBox;
    Label18: TLabel;
    cb10b: TComboBox;
    Label19: TLabel;
    cb11a: TComboBox;
    Label20: TLabel;
    cb11b: TComboBox;
    ck01: TPOSCheckBox;
    ck04: TPOSCheckBox;
    ck05: TPOSCheckBox;
    ck03: TPOSCheckBox;
    ck06: TPOSCheckBox;
    ck07: TPOSCheckBox;
    ck08: TPOSCheckBox;
    ck09: TPOSCheckBox;
    ck10: TPOSCheckBox;
    ck11: TPOSCheckBox;
    lb519044: TLabel;
    cb01c: TComboBox;
    Label22: TLabel;
    cb02c: TComboBox;
    Label24: TLabel;
    cb03c: TComboBox;
    Label26: TLabel;
    cb04c: TComboBox;
    Label28: TLabel;
    cb05c: TComboBox;
    Label30: TLabel;
    cb06c: TComboBox;
    Label32: TLabel;
    cb07c: TComboBox;
    Label34: TLabel;
    cb08c: TComboBox;
    Label36: TLabel;
    cb09c: TComboBox;
    Label38: TLabel;
    cb10c: TComboBox;
    Label40: TLabel;
    cb11c: TComboBox;
    btnTest: TButton;
    btnClose: TButton;
    ckPinv: TPOSCheckBox;
    btnConnclose: TButton;
    pl01: TPanel;
    pl02: TPanel;
    pl03: TPanel;
    pl04: TPanel;
    pl05: TPanel;
    pl06: TPanel;
    pl07: TPanel;
    pl08: TPanel;
    pl09: TPanel;
    pl10: TPanel;
    pl11: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnConncloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    PTRList : TObjectList<TInvPrinter>;
    PTRINV  : TObjectList<TPOSCheckBox>;
    PTRLight: TObjectList<TPanel>;
    PTRCB_A : TObjectList<TComboBox>;
    PTRCB_B : TObjectList<TComboBox>;
    PTRCB_C : TObjectList<TComboBox>;
    procedure InitBuffer;
    procedure InitList;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses LibPOS;

procedure TForm2.btnCloseClick(Sender: TObject);
begin
Close;
end;

procedure TForm2.btnConncloseClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to PTRList.Count -1 do
  begin
   // if PTRList[i].CheckConnected then
      PTRList[i].DisConnect;
      PTRLight[i].Color := $008080FF;
  end;
end;

procedure TForm2.btnTestClick(Sender: TObject);
begin
  InitBuffer;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  PTRINV  := TObjectList<TPOSCheckBox>.Create;
  PTRLight:= TObjectList<TPanel>.Create;
  PTRCB_A := TObjectList<TComboBox>.Create;
  PTRCB_B := TObjectList<TComboBox>.Create;
  PTRCB_C := TObjectList<TComboBox>.Create;
  InitList;
end;


procedure TForm2.InitList;
var
  i: Integer;
  j: Integer;
  cb:TComboBox;
const
  NamePrefix = 'cb';
begin
  for j := 0 to 4 do
  begin
    for i := 1 to 11 do
    begin
      case j of
        0: PTRINV.Add(TPOSCheckBox(FindComponent('ck' + ZeroAtFirst(i,2))));
        1: PTRCB_A.Add(TComboBox(FindComponent(NamePrefix + ZeroAtFirst(i,2) + 'a')));
        2: PTRCB_B.Add(TComboBox(FindComponent(NamePrefix + ZeroAtFirst(i,2) + 'b')));
        3: PTRCB_C.Add(TComboBox(FindComponent(NamePrefix + ZeroAtFirst(i,2) + 'c')));
        4: PTRLight.Add(TPanel(FindComponent('pl' + ZeroAtFirst(i,2))));
      end;
    end;
  end;

  for j := 0 to PTRCB_A.Count-1 do
  begin
    for i := Low(StrPrinterType) to High(StrPrinterType) do
    begin
      PTRCB_A[j].Items.Add(StrPrinterType[i]);
    end;
    PTRCB_A[j].ItemIndex := 0;
  end;

  for j := 0 to PTRCB_B.Count-1 do
  begin
    for i := Low(StrDevicePortValue) to High(StrDevicePortValue) do
    begin
      PTRCB_B[j].Items.Add(StrDevicePortValue[i]);
    end;
    PTRCB_B[j].ItemIndex := 0;
  end;

  for j := 0 to PTRCB_C.Count-1 do
  begin
    PTRCB_C[j].Items.Add('9600');
    PTRCB_C[j].Items.Add('115200');
    PTRCB_C[j].ItemIndex := 0;
  end;

end;

procedure TForm2.InitBuffer;
var
  i: integer;
  //20140814 add  by 02953 for Cust-20140814001  ↓
  //Logo專用變數
  s_lngReturn,s_lngTargetHeight,s_lngTargetWidth:LongInt;
  s_bufNV: Array of byte;
  s_strFileName :String;
  aa:string;
  num:DWORD;
  mutf8String:utf8String;
  j,k,mDelay:integer;
  //20140814 add  by 02953 for Cust-20140814001  ↑
begin
  PTRList := TObjectList<TInvPrinter>.Create;
  PTRList.Add(InvPrinter1) ; PTRList.Add(InvPrinter2)  ; PTRList.Add(InvPrinter3);
  PTRList.Add(InvPrinter4) ; PTRList.Add(InvPrinter5)  ; PTRList.Add(InvPrinter6);
  PTRList.Add(InvPrinter7) ; PTRList.Add(InvPrinter8)  ; PTRList.Add(InvPrinter9);
  PTRList.Add(InvPrinter10); PTRList.Add(InvPrinter11) ; //PTRList.Add(InvPrinter12);


  for i := 0 to PTRList.Count -1 do
  begin
    if i = 4 then Continue;  //標籤機不需設定

    //發票機507
    //0 機台A 發票機            //6  熱感式印表機_1
    //1 機台B 出貨明細印表機    //7  熱感式印表機_2
    //2 機台C 熱感式印表機      //8  熱感式印表機_3
    //3 機台D 銷貨退回印表機    //9  熱感式印表機_4
    //4 機台E 標籤機            //10 熱感式印表機_5
    //5 機台F 自訂印表機        //11 熱感式印表機_6
    if (PTRCB_A[i].ItemIndex <> -1)and (PTRINV[i].Checked) then
    begin
      PTRList[i].PrinterType := TPrinterType(PTRCB_A[i].ItemIndex);
      //if GetPub_I(dpnRef, FPTRStr[i],'Port') >= 6 then  //20131014 mark by 01753 元件修正
      if (PTRCB_B[i].ItemIndex >= 6) and (PTRCB_B[i].ItemIndex < 12) then  //20131014 modi by 01753 元件修正
          PTRList[i].ConnectType := cm_ParallelPort
      else
          PTRList[i].ConnectType := cm_SerialPort;

      PTRList[i].Port            := TDevicePort(PTRCB_B[i].ItemIndex);
      PTRList[i].UniName         := '';
      PTRList[i].Delay           := 30;
      PTRList[i].CheckLPTStatus  := True;
      PTRList[i].CheckDSR        := True;

      //20161129 add by 07113 for C30-20161107001 web000502856 ↓
      //if i = 0 then //機台A 發票機 才做鮑率設定 //20171017 mark by 07113 for Cust-20171017002 //所有印表機都可以選擇鮑率
      begin
        //case GetPub_I(dpnRef, 'PTR_A', 'BaudRate') of  //20171017 mark by 07113 for Cust-20171017002
        case PTRCB_C[i].ItemIndex of //20171017 modi by 07113 for Cust-20171017002
          0: PTRList[i].BaudRate := TBaudRateType.brt_9600;
          1: PTRList[i].BaudRate := TBaudRateType.brt_115200;
        end;
      end;
      //20161129 add by 07113 for C30-20161107001 web000502856 ↑

      //if i < 6 then
      begin
        PTRList[i].DefaultReset := IIF(i=0,True,false);

        if not PTRList[i].Connect then
        begin
          //ShowBoxMessage(GetLangStr('E', FErrorMsg[i]), GetLangStr('E', 009999));
          ShowMessage('連接失敗#' +IntToStr(i+1));
        end
        else
        begin
          PTRLight[i].Color := clWebLimeGreen;
          {if (i=0) and GetPub_B(dpnRef,'PInv','PInv_PrintInv') then //20140530 mark by 02262 第1台關掉印電子發票會有問題
            PTRList[i].DisConnect;}
        end;
      end
      {else
      begin
        if not ((pos('//', PTRList[i].UniName) = 0) and (not IsEmpty(PTRList[i].UniName))) then
        begin
          if not PTRList[i].Connect then
            ShowBoxMessage('1' + GetLangStr('E', FErrorMsg[i]), GetLangStr('E', 009999));
        end;
      end};


      //20150525 MODI BY 01753 FOR C30-20150525003
      if (i = 0) and ckPinv.Checked then
        PTRList[i].DisConnect
      else
      if i <> 0 then
        PTRList[i].DisConnect;
      //20150525 MODI BY 01753 FOR C30-20150525003

    end
    else
      PTRList[i].DisConnect;
  end;
end;

end.
