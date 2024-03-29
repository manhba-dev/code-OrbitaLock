unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JsCtrls;

type
  TfrmMain = class(TForm)
    gpbConnection: TGroupBox;
    cmbDM: TComboBox;
    stxText2: TStaticText;
    stxText3: TStaticText;
    cmbDP: TComboBox;
    gpbCardFields: TGroupBox;
    stxText9: TStaticText;
    btnRead: TButton;
    btnExit: TButton;
    edtCN: TEdit;
    stxText10: TStaticText;
    edtLC: TEdit;
    stxText11: TStaticText;
    edtSC: TEdit;
    stxText12: TStaticText;
    edtGC: TEdit;
    stxText13: TStaticText;
    stxText14: TStaticText;
    stxText16: TStaticText;
    edtPI: TEdit;
    edtPN: TEdit;
    edtET: TEdit;
    stbInfo: TStatusBar;
    btnWrite: TButton;
    gpbCardSetting: TGroupBox;
    edtSP: TEdit;
    stxText8: TStaticText;
    stxText17: TLabel;
    edtBT: TEdit;
    lblSectorNo: TLabel;
    edtSectorNo: TEdit;
    lblRepeatTimes: TLabel;
    edtRepeatTimes: TEdit;
    gpbLiftFields: TGroupBox;
    Edit1: TEdit;
    StaticText1: TStaticText;
    Label1: TLabel;
    Edit2: TEdit;
    StaticText2: TStaticText;
    Edit3: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Label4: TLabel;
    Edit6: TEdit;
    Label5: TLabel;
    Edit7: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    StaticText3: TStaticText;
    edtPWCN: TEdit;
    StaticText4: TStaticText;
    edtPWLC: TEdit;
    StaticText9: TStaticText;
    edtPWET: TEdit;
    edtPWBT: TEdit;
    StaticText5: TStaticText;
    edtPSW: TEdit;
    edtPSSectorNo: TEdit;
    Label7: TLabel;
    StaticText6: TStaticText;
    cmbPM: TComboBox;
    StaticText7: TStaticText;
    edtGuestSex: TEdit;
    StaticText8: TStaticText;
    edtGuestName: TEdit;
    gpbData: TGroupBox;
    lblData: TLabel;
    edtData: TEdit;
    StaticText10: TStaticText;
    edtDataSectorID: TEdit;
    Label8: TLabel;
    edtDataSectorNo: TEdit;
    ckbData: TCheckBox;
    ckbLiftContent: TCheckBox;
    ckbCardContent: TCheckBox;
    ckbPowerSwitchContent: TCheckBox;
    procedure btnExitClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure ckbDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckbLiftContentClick(Sender: TObject);
    procedure ckbCardContentClick(Sender: TObject);
    procedure ckbPowerSwitchContentClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  //读宾客卡函数
  function Read_Guest_Card(Port, ReaderType, SectorNo: Byte; HotelPwd: PChar;
    var CardNo, GuestSN, GuestIdx: Integer; DoorID, SuitDoor, PubDoor, BeginTime,
    EndTime: PChar): Integer; stdcall; far; external 'btlock57L.dll';
  //写宾客卡函数
  function Write_Guest_Card (Port, ReaderType, SectorNo: Byte; HotelPwd: PChar;
    CardNo, GuestSN, GuestIdx: Integer; DoorID, SuitDoor, PubDoor, BeginTime,
    EndTime: PChar): Integer; stdcall; far; external 'btlock57L.dll';
  //读卡器蜂鸣
  function Reader_Alarm(Port, ReaderType, AlarmCount: Byte): Integer;
    stdcall; far; external 'btlock57L.dll';
  //写电梯控制信息
  function Write_Guest_Lift(Port, ReaderType, SectorNo: Byte; HotelPwd: PChar;
    CardNo, BeginAddr, EndAddr, MaxLiftAddr: Integer; BeginTime, EndTime,
    LiftData: PChar): Integer; stdcall; far; external 'btlock57L.dll';
  //读电梯控制信息
  function Read_Guest_Lift(Port, ReaderType, SectorNo: Byte; HotelPwd: PChar;
    BeginAddr, EndAddr: Integer; var CardNo: Integer; BeginTime, EndTime,
    LiftData: PChar): Integer; stdcall; far; external 'btlock57L.dll';
  //写取电开关函数
  function Write_Guest_PowerSwitch(Port, ReaderType, SectorNo: Byte; PowerSwitchPwd: PChar;
    CardNo, GuestSex: Integer; DoorID, GuestName, BeginTime, EndTime: PChar;
    PowerSwitchType: Byte): Integer; stdcall; far; external 'btlock57L.dll';
  //读取电开关函数
  function Read_Guest_PowerSwitch(Port, ReaderType, SectorNo: Byte; PowerSwitchPwd: PChar;
    var CardNo, GuestSex: Integer; DoorID, GuestName, BeginTime, EndTime: PChar;
    PowerSwitchType: Byte): Integer; stdcall; far; external 'btlock57L.dll';
  //读其它扇区数据函数
  function Read_Data(Port, ReaderType, SectorNo: Byte; SectorPwd: PChar;
    Data: PChar): Integer; stdcall; far; external 'Data.dll';
  //写其它扇区数据函数
  function Write_Data(Port, ReaderType, SectorNo: Byte; SectorPwd: PChar;
    Data: PChar): Integer; stdcall; far; external 'Data.dll';

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnReadClick(Sender: TObject);
var
  tmpCardNo, tmpGuestSN, tmpGuestIdx, tmpGuestSex,
  rt: Integer;
  tmpDoorID, tmpSuitDoor, tmpPubDoor,
  tmpBeginTime, tmpEndTime, tmpLiftData, tmpGuestName, tmpData: PChar;
begin
  rt := 255;
  edtLC.Text := '';
  edtSC.Text := '';
  edtGC.Text := '';
  edtET.Text := '';
  edtBT.Text := '';
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  edtPWCN.Text := '';
  edtPWLC.Text := '';
  edtGuestSex.Text := '';
  edtGuestName.Text := '';
  edtPWBT.Text := '';
  edtPWET.Text := '';
  edtData.Text := '';

  GetMem(tmpDoorID, 7);
  tmpDoorID[6] := #0;
  GetMem(tmpSuitDoor, 5);
  tmpSuitDoor[4] := #0;
  GetMem(tmpPubDoor, 9);
  tmpPubDoor[8] := #0;
  GetMem(tmpBeginTime, 13);
  tmpBeginTime[12] := #0;
  GetMem(tmpEndTime, 13);
  tmpEndTime[12] := #0;
  GetMem(tmpGuestName, 9);
  tmpGuestName[8] := #0;
  GetMem(tmpData, 33);
  tmpData[32] := #0;

  if StrToInt(Edit7.Text) - StrToInt(Edit6.Text) + 1 > 16 then
  begin
    GetMem(tmpLiftData, (StrToInt(Edit7.Text) - StrToInt(Edit6.Text) -15) * 2 + 1);
    tmpLiftData[(StrToInt(Edit7.Text) - StrToInt(Edit6.Text) -15) * 2] := #0;
  end else
  begin
    GetMem(tmpLiftData, (StrToInt(Edit7.Text) - StrToInt(Edit6.Text) + 1) * 2 + 1);
    tmpLiftData[(StrToInt(Edit7.Text) - StrToInt(Edit6.Text) + 1) * 2] := #0;
  end;

  if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = False) and
     (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
    end;
  end else if (ckbLiftContent.Checked = True) and  (ckbCardContent.Checked = False) and
              (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
      @tmpEndTime[0], @tmpLiftData[0]);
    if rt = 0 then
    begin
      Edit1.Text := IntToStr(tmpCardNo);
      Edit2.Text := strPas(tmpBeginTime);
      Edit3.Text := strPas(tmpEndTime);
      Edit4.Text := strPas(tmpLiftData);
    end;
  end else if (ckbPowerSwitchContent.Checked = True) and (ckbCardContent.Checked = False) and
              (ckbLiftContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
      PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
      @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        edtPWCN.Text := IntToStr(tmpCardNo);
        edtPWLC.Text := strPas(tmpDoorID);
        edtGuestSex.Text := IntToStr(tmpGuestSex);
        edtGuestName.Text := strPas(tmpGuestName);
        edtPWBT.Text := strPas(tmpBeginTime);
        edtPWET.Text := strPas(tmpEndTime);
      end else if cmbPM.ItemIndex = 1 then
      begin
        //edtPWCN.Text := IntToStr(tmpCardNo);
        edtPWLC.Text := strPas(tmpDoorID);
        //edtGuestSex.Text := IntToStr(tmpGuestSex);
        //edtGuestName.Text := strPas(tmpGuestName);
        //edtPWBT.Text := strPas(tmpBeginTime);
        edtPWET.Text := strPas(tmpEndTime);
      end;
    end;
  end else if (ckbData.Checked = True) and (ckbCardContent.Checked = False) and
              (ckbLiftContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
      PChar(edtDataSectorID.Text), @tmpData[0]);
    if rt = 0 then
    begin
      edtData.Text := strPas(tmpData);
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
        @tmpEndTime[0], @tmpLiftData[0]);
      if rt = 0 then
      begin
        Edit1.Text := IntToStr(tmpCardNo);
        Edit2.Text := strPas(tmpBeginTime);
        Edit3.Text := strPas(tmpEndTime);
        Edit4.Text := strPas(tmpLiftData);
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbLiftContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
        @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          edtGuestSex.Text := IntToStr(tmpGuestSex);
          edtGuestName.Text := strPas(tmpGuestName);
          edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end else if cmbPM.ItemIndex = 1 then
        begin
          //edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          //edtGuestSex.Text := IntToStr(tmpGuestSex);
          //edtGuestName.Text := strPas(tmpGuestName);
          //edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end;
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbData.Checked = True) and
              (ckbLiftContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), @tmpData[0]);
      if rt = 0 then
      begin
        edtData.Text := strPas(tmpData);
      end;
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
      @tmpEndTime[0], @tmpLiftData[0]);
    if rt = 0 then
    begin
      Edit1.Text := IntToStr(tmpCardNo);
      Edit2.Text := strPas(tmpBeginTime);
      Edit3.Text := strPas(tmpEndTime);
      Edit4.Text := strPas(tmpLiftData);
      rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
        @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          edtGuestSex.Text := IntToStr(tmpGuestSex);
          edtGuestName.Text := strPas(tmpGuestName);
          edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end else if cmbPM.ItemIndex = 1 then
        begin
          //edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          //edtGuestSex.Text := IntToStr(tmpGuestSex);
          //edtGuestName.Text := strPas(tmpGuestName);
          //edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end;
      end;
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbData.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
      @tmpEndTime[0], @tmpLiftData[0]);
    if rt = 0 then
    begin
      Edit1.Text := IntToStr(tmpCardNo);
      Edit2.Text := strPas(tmpBeginTime);
      Edit3.Text := strPas(tmpEndTime);
      Edit4.Text := strPas(tmpLiftData);
      rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), @tmpData[0]);
      if rt = 0 then
      begin
        edtData.Text := strPas(tmpData);
      end;
    end;
  end else if (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbLiftContent.Checked = False) then
  begin
    rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
      PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
      @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        edtPWCN.Text := IntToStr(tmpCardNo);
        edtPWLC.Text := strPas(tmpDoorID);
        edtGuestSex.Text := IntToStr(tmpGuestSex);
        edtGuestName.Text := strPas(tmpGuestName);
        edtPWBT.Text := strPas(tmpBeginTime);
        edtPWET.Text := strPas(tmpEndTime);
      end else if cmbPM.ItemIndex = 1 then
      begin
        //edtPWCN.Text := IntToStr(tmpCardNo);
        edtPWLC.Text := strPas(tmpDoorID);
        //edtGuestSex.Text := IntToStr(tmpGuestSex);
        //edtGuestName.Text := strPas(tmpGuestName);
        //edtPWBT.Text := strPas(tmpBeginTime);
        edtPWET.Text := strPas(tmpEndTime);
      end;
      rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), @tmpData[0]);
      if rt = 0 then
      begin
        edtData.Text := strPas(tmpData);
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
        @tmpEndTime[0], @tmpLiftData[0]);
      if rt = 0 then
      begin
        Edit1.Text := IntToStr(tmpCardNo);
        Edit2.Text := strPas(tmpBeginTime);
        Edit3.Text := strPas(tmpEndTime);
        Edit4.Text := strPas(tmpLiftData);
        rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
          @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
        if rt = 0 then
        begin
          if cmbPM.ItemIndex = 0 then
          begin
            edtPWCN.Text := IntToStr(tmpCardNo);
            edtPWLC.Text := strPas(tmpDoorID);
            edtGuestSex.Text := IntToStr(tmpGuestSex);
            edtGuestName.Text := strPas(tmpGuestName);
            edtPWBT.Text := strPas(tmpBeginTime);
            edtPWET.Text := strPas(tmpEndTime);
          end else if cmbPM.ItemIndex = 1 then
          begin
            //edtPWCN.Text := IntToStr(tmpCardNo);
            edtPWLC.Text := strPas(tmpDoorID);
            //edtGuestSex.Text := IntToStr(tmpGuestSex);
            //edtGuestName.Text := strPas(tmpGuestName);
            //edtPWBT.Text := strPas(tmpBeginTime);
            edtPWET.Text := strPas(tmpEndTime);
          end;
        end;
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbData.Checked = True) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
        @tmpEndTime[0], @tmpLiftData[0]);
      if rt = 0 then
      begin
        Edit1.Text := IntToStr(tmpCardNo);
        Edit2.Text := strPas(tmpBeginTime);
        Edit3.Text := strPas(tmpEndTime);
        Edit4.Text := strPas(tmpLiftData);
        rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), @tmpData[0]);
        if rt = 0 then
        begin
          edtData.Text := strPas(tmpData);
        end;
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbData.Checked = True) and (ckbLiftContent.Checked = False) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
        @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          edtGuestSex.Text := IntToStr(tmpGuestSex);
          edtGuestName.Text := strPas(tmpGuestName);
          edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end else if cmbPM.ItemIndex = 1 then
        begin
          //edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          //edtGuestSex.Text := IntToStr(tmpGuestSex);
          //edtGuestName.Text := strPas(tmpGuestName);
          //edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end;
        rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), @tmpData[0]);
        if rt = 0 then
        begin
          edtData.Text := strPas(tmpData);
        end;
      end;
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbData.Checked = True) and (ckbCardContent.Checked = False) then
  begin
    rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
      @tmpEndTime[0], @tmpLiftData[0]);
    if rt = 0 then
    begin
      Edit1.Text := IntToStr(tmpCardNo);
      Edit2.Text := strPas(tmpBeginTime);
      Edit3.Text := strPas(tmpEndTime);
      Edit4.Text := strPas(tmpLiftData);
      rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
        @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          edtGuestSex.Text := IntToStr(tmpGuestSex);
          edtGuestName.Text := strPas(tmpGuestName);
          edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end else if cmbPM.ItemIndex = 1 then
        begin
          //edtPWCN.Text := IntToStr(tmpCardNo);
          edtPWLC.Text := strPas(tmpDoorID);
          //edtGuestSex.Text := IntToStr(tmpGuestSex);
          //edtGuestName.Text := strPas(tmpGuestName);
          //edtPWBT.Text := strPas(tmpBeginTime);
          edtPWET.Text := strPas(tmpEndTime);
        end;
        rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), @tmpData[0]);
        if rt = 0 then
        begin
          edtData.Text := strPas(tmpData);
        end;
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = True) then
  begin
    rt := Read_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), tmpCardNo, tmpGuestSN, tmpGuestIdx, @tmpDoorID[0], @tmpSuitDoor[0],
      @tmpPubDoor[0], @tmpBeginTime[0], @tmpEndTime[0]);
    if rt = 0 then
    begin
      edtCN.Text := IntToStr(tmpCardNo);
      edtLC.Text := strPas(tmpDoorID);
      edtSC.Text := strPas(tmpSuitDoor);
      edtGC.Text := strPas(tmpPubDoor);
      edtPI.Text := IntToStr(tmpGuestSN);
      edtPN.Text := IntToStr(tmpGuestIdx);
      edtBT.Text := strPas(tmpBeginTime);
      edtET.Text := strPas(tmpEndTime);
      rt := Read_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text), tmpCardNo, @tmpBeginTime[0],
        @tmpEndTime[0], @tmpLiftData[0]);
      if rt = 0 then
      begin
        Edit1.Text := IntToStr(tmpCardNo);
        Edit2.Text := strPas(tmpBeginTime);
        Edit3.Text := strPas(tmpEndTime);
        Edit4.Text := strPas(tmpLiftData);
        rt := Read_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), tmpCardNo, tmpGuestSex, @tmpDoorID[0], @tmpGuestName[0],
          @tmpBeginTime[0], @tmpEndTime[0], cmbPM.ItemIndex + 1);
        if rt = 0 then
        begin
          if cmbPM.ItemIndex = 0 then
          begin
            edtPWCN.Text := IntToStr(tmpCardNo);
            edtPWLC.Text := strPas(tmpDoorID);
            edtGuestSex.Text := IntToStr(tmpGuestSex);
            edtGuestName.Text := strPas(tmpGuestName);
            edtPWBT.Text := strPas(tmpBeginTime);
            edtPWET.Text := strPas(tmpEndTime);
          end else if cmbPM.ItemIndex = 1 then
          begin
            //edtPWCN.Text := IntToStr(tmpCardNo);
            edtPWLC.Text := strPas(tmpDoorID);
            //edtGuestSex.Text := IntToStr(tmpGuestSex);
            //edtGuestName.Text := strPas(tmpGuestName);
            //edtPWBT.Text := strPas(tmpBeginTime);
            edtPWET.Text := strPas(tmpEndTime);
          end;
          rt := Read_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
            PChar(edtDataSectorID.Text), @tmpData[0]);
          if rt = 0 then
          begin
            edtData.Text := strPas(tmpData);
          end;
        end;
      end;
    end;
  end else ShowMessage('Please select first!');
  if rt = 0 then
    Reader_Alarm(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtRepeatTimes.Text));
  stbInfo.Panels[1].Text := IntToStr(rt);
  stbInfo.Refresh;
  FreeMem(tmpDoorID);
  FreeMem(tmpSuitDoor);
  FreeMem(tmpPubDoor);
  FreeMem(tmpEndTime);
  FreeMem(tmpBeginTime);
  FreeMem(tmpGuestName);
  FreeMem(tmpData);
end;

procedure TfrmMain.btnWriteClick(Sender: TObject);
var
  rt: Integer;
begin
  rt := 255;
  if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = False) and
     (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
  end else if (ckbLiftContent.Checked = True) and  (ckbCardContent.Checked = False) and
              (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
      StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
  end else if (ckbPowerSwitchContent.Checked = True) and (ckbCardContent.Checked = False) and
              (ckbLiftContent.Checked = False) and (ckbData.Checked = False) then
  begin
    if cmbPM.ItemIndex = 0 then
    begin
      rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
        PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
    end else if cmbPM.ItemIndex = 1 then
    begin
      rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
        cmbPM.ItemIndex + 1);
    end;
  end else if (ckbData.Checked = True) and (ckbCardContent.Checked = False) and
              (ckbLiftContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
      PChar(edtDataSectorID.Text), PChar(edtData.Text));
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
        StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
    end;
  end else if (ckbCardContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbLiftContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
          PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
      end else if cmbPM.ItemIndex = 1 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
          cmbPM.ItemIndex + 1);
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbData.Checked = True) and
              (ckbLiftContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), PChar(edtData.Text));
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
      StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
          PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
      end else if cmbPM.ItemIndex = 1 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
          cmbPM.ItemIndex + 1);
      end;
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbData.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
      StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
    if rt = 0 then
    begin
      rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), PChar(edtData.Text));
    end;
  end else if (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = True) and
              (ckbCardContent.Checked = False) and (ckbLiftContent.Checked = False) then
  begin
    if cmbPM.ItemIndex = 0 then
    begin
      rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
        PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
    end else if cmbPM.ItemIndex = 1 then
    begin
      rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
        PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
        cmbPM.ItemIndex + 1);
    end;
    if rt = 0 then
    begin
      rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
        PChar(edtDataSectorID.Text), PChar(edtData.Text));
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
        StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
            PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
            PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
        end else if cmbPM.ItemIndex = 1 then
        begin
          rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
            PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
            cmbPM.ItemIndex + 1);
        end;
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbData.Checked = True) and (ckbPowerSwitchContent.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
        StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
      if rt = 0 then
      begin
        rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), PChar(edtData.Text));
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbData.Checked = True) and (ckbLiftContent.Checked = False) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
          PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
      end else if cmbPM.ItemIndex = 1 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
          cmbPM.ItemIndex + 1);
      end;
      if rt = 0 then
      begin
        rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), PChar(edtData.Text));
      end;
    end;
  end else if (ckbLiftContent.Checked = True) and (ckbPowerSwitchContent.Checked = True) and
              (ckbData.Checked = True) and (ckbCardContent.Checked = False) then
  begin
    rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
      StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
    if rt = 0 then
    begin
      if cmbPM.ItemIndex = 0 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
          PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
      end else if cmbPM.ItemIndex = 1 then
      begin
        rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
          PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
          cmbPM.ItemIndex + 1);
      end;
      if rt = 0 then
      begin
        rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
          PChar(edtDataSectorID.Text), PChar(edtData.Text));
      end;
    end;
  end else if (ckbCardContent.Checked = True) and (ckbLiftContent.Checked = True) and
              (ckbPowerSwitchContent.Checked = True) and (ckbData.Checked = True) then
  begin
    rt := Write_Guest_Card(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
      PChar(edtSP.Text), StrToInt(edtCN.Text), StrToInt(edtPI.Text), StrToInt(edtPN.Text),
      PChar(edtLC.Text), PChar(edtSC.Text), PChar(edtGC.Text), PChar(edtBT.Text), PChar(edtET.Text));
    if rt = 0 then
    begin
      rt := Write_Guest_Lift(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtSectorNo.Text),
        PChar(edtSP.Text), StrToInt(Edit1.Text), StrToInt(Edit5.Text), StrToInt(Edit6.Text),
        StrToInt(Edit7.Text), PChar(Edit2.Text), PChar(Edit3.Text), PChar(Edit4.Text));
      if rt = 0 then
      begin
        if cmbPM.ItemIndex = 0 then
        begin
          rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
            PChar(edtPSW.Text), StrToInt(edtPWCN.Text), StrToInt(edtGuestSex.Text), PChar(edtPWLC.Text),
            PChar(edtGuestName.Text), PChar(edtPWBT.Text), PChar(edtPWET.Text), cmbPM.ItemIndex + 1);
        end else if cmbPM.ItemIndex = 1 then
        begin
          rt := Write_Guest_PowerSwitch(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtPSSectorNo.Text),
            PChar(edtPSW.Text), 1, 0, PChar(edtPWLC.Text), 0, 0, PChar(edtPWET.Text),
            cmbPM.ItemIndex + 1);
        end;
        if rt = 0 then
        begin
          rt := Write_Data(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtDataSectorNo.Text),
            PChar(edtDataSectorID.Text), PChar(edtData.Text));
        end;
      end;
    end;
  end else ShowMessage('Please select first!');
  if rt = 0 then
    Reader_Alarm(cmbDP.ItemIndex + 1, cmbDM.ItemIndex + 1, StrToInt(edtRepeatTimes.Text));
  stbInfo.Panels[1].Text := IntToStr(rt);
  stbInfo.Refresh;
end;

procedure TfrmMain.ckbDataClick(Sender: TObject);
begin
  if ckbData.Checked = true then
  begin
    ckbCardContent.Checked := true;
    lblData.Enabled := true;
    edtData.Enabled := true;
  end else
  begin
    ckbCardContent.Checked := false;
    lblData.Enabled := false;
    edtData.Enabled := false;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  stxText9.Enabled := false;
  stxText11.Enabled := false;
  stxText13.Enabled := false;
  stxText17.Enabled := false;
  stxText10.Enabled := false;
  stxText12.Enabled := false;
  stxText14.Enabled := false;
  stxText16.Enabled := false;
  StaticText1.Enabled := false;
  StaticText2.Enabled := false;
  Label3.Enabled := false;
  Label2.Enabled := false;
  Label1.Enabled := false;
  Label5.Enabled := false;
  Label4.Enabled := false;
  lblData.Enabled := false;
  StaticText3.Enabled := false;
  StaticText7.Enabled := false;
  Label6.Enabled := false;
  StaticText4.Enabled := false;
  StaticText8.Enabled := false;
  StaticText9.Enabled := false;
  edtCN.Enabled := false;
  edtSC.Enabled := false;
  edtPI.Enabled := false;
  edtBT.Enabled := false;
  edtLC.Enabled := false;
  edtGC.Enabled := false;
  edtPN.Enabled := false;
  edtET.Enabled := false;
  Edit1.Enabled := false;
  Edit3.Enabled := false;
  Edit5.Enabled := false;
  Edit4.Enabled := false;
  Edit2.Enabled := false;
  Edit7.Enabled := false;
  Edit6.Enabled := false;
  edtData.Enabled := false;
  edtPWCN.Enabled := false;
  edtGuestSex.Enabled := false;
  edtPWBT.Enabled := false;
  edtPWLC.Enabled := false;
  edtGuestName.Enabled := false;
  edtPWET.Enabled := false;
end;

procedure TfrmMain.ckbLiftContentClick(Sender: TObject);
begin
  if ckbLiftContent.Checked = true then
  begin
    StaticText1.Enabled := true;
    StaticText2.Enabled := true;
    Label3.Enabled := true;
    Label2.Enabled := true;
    Label1.Enabled := true;
    Label5.Enabled := true;
    Label4.Enabled := true;
    Edit1.Enabled := true;
    Edit3.Enabled := true;
    Edit5.Enabled := true;
    Edit4.Enabled := true;
    Edit2.Enabled := true;
    Edit7.Enabled := true;
    Edit6.Enabled := true;
  end else
  begin
    StaticText1.Enabled := false;
    StaticText2.Enabled := false;
    Label3.Enabled := false;
    Label2.Enabled := false;
    Label1.Enabled := false;
    Label5.Enabled := false;
    Label4.Enabled := false;
    Edit1.Enabled := false;
    Edit3.Enabled := false;
    Edit5.Enabled := false;
    Edit4.Enabled := false;
    Edit2.Enabled := false;
    Edit7.Enabled := false;
    Edit6.Enabled := false;
  end;
end;

procedure TfrmMain.ckbCardContentClick(Sender: TObject);
begin
  if ckbCardContent.Checked = true then
  begin
    stxText9.Enabled := true;
    stxText11.Enabled := true;
    stxText13.Enabled := true;
    stxText17.Enabled := true;
    stxText10.Enabled := true;
    stxText12.Enabled := true;
    stxText14.Enabled := true;
    stxText16.Enabled := true;
    edtCN.Enabled := true;
    edtSC.Enabled := true;
    edtPI.Enabled := true;
    edtBT.Enabled := true;
    edtLC.Enabled := true;
    edtGC.Enabled := true;
    edtPN.Enabled := true;
    edtET.Enabled := true;
  end else
  begin
    ckbPowerSwitchContent.Checked := false;
    ckbData.Checked := false;
    stxText9.Enabled := false;
    stxText11.Enabled := false;
    stxText13.Enabled := false;
    stxText17.Enabled := false;
    stxText10.Enabled := false;
    stxText12.Enabled := false;
    stxText14.Enabled := false;
    stxText16.Enabled := false;
    edtCN.Enabled := false;
    edtSC.Enabled := false;
    edtPI.Enabled := false;
    edtBT.Enabled := false;
    edtLC.Enabled := false;
    edtGC.Enabled := false;
    edtPN.Enabled := false;
    edtET.Enabled := false;
  end;
end;

procedure TfrmMain.ckbPowerSwitchContentClick(Sender: TObject);
begin
  if ckbPowerSwitchContent.Checked = true then
  begin
    ckbCardContent.Checked := true;
    StaticText3.Enabled := true;
    StaticText7.Enabled := true;
    Label6.Enabled := true;
    StaticText4.Enabled := true;
    StaticText8.Enabled := true;
    StaticText9.Enabled := true;
    edtPWCN.Enabled := true;
    edtGuestSex.Enabled := true;
    edtPWBT.Enabled := true;
    edtPWLC.Enabled := true;
    edtGuestName.Enabled := true;
    edtPWET.Enabled := true;
  end else
  begin
    ckbCardContent.Checked := false;
    StaticText3.Enabled := false;
    StaticText7.Enabled := false;
    Label6.Enabled := false;
    StaticText4.Enabled := false;
    StaticText8.Enabled := false;
    StaticText9.Enabled := false;
    edtPWCN.Enabled := false;
    edtGuestSex.Enabled := false;
    edtPWBT.Enabled := false;
    edtPWLC.Enabled := false;
    edtGuestName.Enabled := false;
    edtPWET.Enabled := false;
  end;
end;

end.
