#region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** ���������� ACNWrapper_GUI ****

#RequireAdmin

Global $testversion = 0;  �ǲ��԰� 1   0 Ϊ��ʽ��
Global $dingZhiFlag = 111 ;  û���� 0 �� 109 ��111 ,  113 ��    ÿ��ս��npc������ؿ��ܶ���ͬ�����붩��flag
Local $onlykp = 0 ;
Global $cheapversion = 0 ; 1 �Ǽ��װ汾����װ�䣬 0 Ϊȫ����
Local $debugmode = 0 ;   1 �� 0 �ر� �ֶ�����ģʽ��������Ϸ�ڿ���

Local $acountArray[2] ;���ڰ��ʺ�
$acountArray[0] = "whenzl4"
$acountArray[1] = "whenzl4"

Global $bindmac = 1;�󶨻���
Global $bindacc = 0;���ʺ�

Local $killQuery  ;Random(1, 3, 1)      ;1 ;�趨һ����ֶ��У�����  1 kp�� 2ɱ����ɽ������Ĺ֣� 3 ɱ����ɽ��


$bindlimitCount = 0 ;  �󶨴���
$bindTime = 0 ;    ���ݿ��еĴ���  ;ֻ���԰��õ�,��ֹ���˹���󲻸���˴�������������ʹ�û��ﵽ����������ʹ��

If $testversion = 1 Then ;�������Ѱ棬�Ͱ󶨴���
	$bindlimitCount = 1
	$bindTime = 1
EndIf
$limitRound = 2 ;�����һ�����

$ranLimte = Random(-10, 13, 1) ;���������Ƶ�ǰ��Χ   ������� 80-20 ���� 80+20
;$ranLimte = 0
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////���ְ汾
#include <guidesignkp.au3>
#include <d2�ͻ���.au3>
#include <include.au3>
#include <colormanger.au3>  ;������ɫ�ĺ���
#include <imageSearch.au3>
#include <commonUse.au3>
#include <fireMethord.au3>   ;���������еĺ���
#include <checkbag.au3>
#include <moveWithMap.au3>
#include <findpath.au3>    ;�ܲ�·��
;#include <approve.au3>
#include <file.au3>    ;д��log ��־
#include <ScreenCapture.au3>
#include <string.au3>   ;16����ת�ַ���

#include "CoProc.au3"



; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused = True ; �趨һ���ȼ�״̬�� true= ��ͣ

Local $ohterImage = 0 ;���ֵ�����δ֪����
Local $emptybag
Local $checkbag = 1

Local $handle
;$title = "d2"
$titlefiremethord = $title
$titleImageSearch = $title

Local $ct = 1 ;��������1
Local $repeatrejpet = 0 ; ����һ������pet�ı�־�����Ƿ��ظ�
Local $repeatbuyred = 0 ; ����һ������pet�ı�־�����Ƿ��ظ�
Local $notfinddoorCount = 0 ;����һ��δ�ҵ����ŵĴ�����������һֱû�ҵ����ţ�����Ҫֹͣ�һ���
Local $repeatCreatroom = 0 ;����һ���ظ�������ļ���������Ŷӵ�����£���ͣ�Ľ����䣬��ֹͣ
Local $roombegintime ;��¼���뷿���kp��ʱ�䣬����ͳ��һ��kp�����೤ʱ��
Local $begintime ;��¼��ʼ���е�ʱ��,��������������


Local $parm_boxing, $parm_MoveBox ;�Ƿ�װ�� ,װ�䷽ʽ
Local $parm_boxqty, $parm_moveround ;���������ĸ���,�̶�kp����
Local $parm_shopred ;���ҩˮ
Local $parm_shopblue ;����ҩˮ

Local $parm_namelenfr, $parm_namelento, $parm_namepre, $parm_namegd
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime, $parm_blzrnd
Local $parm_ramevent, $parm_kprounctime, $parm_rantime
Local $parm_ramclose, $parm_closetime, $parm_closestoptime ;�涨kpt������
Local $parm_path ;������ŵ�·��
Local $parm_othercheck, $parm_otherwhencheck, $parm_othermethord, $parm_otherroundtrace, $parm_otheroundinterval
Local $parm_sldspeed, $parm_speeddelay;����
Local $parm_otherimage; ���������˵�ͼƬ
Local $title ;���ڱ���
Global $parm_path1, $parm_path2, $parm_path3 ;  ·��
Local $parm_exeparm3 ;��������
Local $parm_gamemode ; ���� 0 ������ 1
Local $parm_imageMode ; ��ͼ�ķ�ʽ ��ͨ 0�� ͼ��ͱ�ɫ 1
;Local $parm_kpmode ;kpģʽ��Ĭ�ϣ���Ч��
Local $parm_closegame, $parm_closegamesec ;���𰵺�
;Local $parm_tpIce, $parm_blzIce, $parm_armIce, $parm_tpFire, $parm_fireFire,$parm_armFire,$parm_cta1, $parm_cta2

Global $round = 0 ; kp����ͳ��
Local $tfcount = 0 ; �л��˺�ǰ���˺ŵ��ۻ�kp���� ������ ,��ʱ����
Local $tfclosecount = 0 ; �Զ������ߵ�kp����
Local $other_traced_round = 0 ;����ڼ��ֱ��˽��뷿��,
Local $ranclosecount = 0 ; �����Զ��رհ��ڣ���ֹ���������Ĺ���
Local $movebagcount = 0 ;  ����һ���̶����پ��Զ�ת�ư�����


Local $authority ;
Local $parm_firstdate, $parm_kpcount ;�ܵ�kp���������������¸��ͻ�
Local $connectfailcount = 0 ;����һ���޷�����ս���ļ��Σ������ʺŷ�����ͣ��ʱ���Ͳ���һֱ��������
Local $createroominqueecount = 0 ;����һ��������ȴ��Ŷ�
Local $autshortdelaysec = 0, $short1 = 0, $short2 = 0, $short3 = 0 ;����ǰ·����ʱ��ʱ��    ��  0�뵵�� 4-5�뵵 �� 9-12�뵵

Local $biaojicolor1 = 0x18FB01 ; ����ɫ 0x118FB01
Local $childmsg[8] ;���������յ�����Ϣ
Local $PidChild1 ;�ӽ���id
Local $childWaringFlag = 1 ;����һ���ӽ��̴��ݹ������쳣��־���������˽����䣬����m��

Local $arrayroomName[12] ;����������ĸ������ ,�������û��������Զ���
#CS $arrayroomName[0] = "q"
	$arrayroomName[1] = "e" ;w
	$arrayroomName[2] = "e"
	$arrayroomName[3] = "t"
	$arrayroomName[4] = "a"
	$arrayroomName[5] = "s"
	$arrayroomName[6] = "d"
	$arrayroomName[7] = "f"
	$arrayroomName[8] = "g"
	$arrayroomName[9] = "z"
	$arrayroomName[10] = "x"
	$arrayroomName[11] = "c"
#CE




If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "��ʾ", "δ֪��������")
	Exit 0
EndIf


;If $bindmac = 1 And $testversion = 0 Then
If $testversion = 0 Then
	If $bindmac = 1 Then
		_GUICtrlStatusBar_SetText($StatusBar1, "�󶨻���", 0)
		If $cheapversion = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar1, "�󶨻���" & "-ȫ���ܰ�", 0)
		EndIf
	Else
		_GUICtrlStatusBar_SetText($StatusBar1, "���˺�", 0)
		If $cheapversion = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar1, "���˺�" & "-ȫ���ܰ�", 0)
		EndIf
	EndIf
	If Not _IniVer() Then ; �󶨻���
		gui()
	EndIf
EndIf
;$parm_bhtime = $guibhTime


If @OSVersion = "WIN_XP" And @DesktopDepth <> 32 Then
	MsgBox(0, "��ʼ������", "�����ҵ������-���ԣ�����ɫ������Ϊ32")
	Exit 0
EndIf




creatGui() ; ��ʼ��������


$title = $guititle
$parm_path1 = $d2path1 ;����Ŀ��
$parm_path2 = $d2path2 ; ����λ��
$parm_path3 = $d2path3 ;��ִ��EXE
$parm_exeparm3 = $guiexeparm3 ;��������
$parm_gamemode = $guigamemode
$parm_imageMode = $guiImageMode
;$parm_kpmode = $guikpmode ;Kp ģʽ
$parm_closegame = $guiclosegame
$parm_closegamesec = $guiclosegamesec

$parm_boxing = $guiboxing ;�Ƿ�����װ�书��
$parm_MoveBox = $guiMoveBox ;�����ַ�ʽװ��
$parm_boxqty = $guiboxqty ;���ڰ�������
$parm_moveround = $guimoveround ;ÿ�����پ���ִ��װ��

$parm_buyred = $ckred
$parm_buyblue = $ckblue
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_namepre = $guinamepre
$parm_namegd = $guinamegd
$parm_drinkrej_plus = $guidrinkrej
$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime
$parm_ramclose = $guiramclose
$parm_closetime = $guiclosetime
$parm_closestoptime = $guiclosestoptime
$parm_path = $guipath
$parm_othercheck = $guiothercheck ;������˽�����
$parm_sldspeed = $guisldspeed ;����ѡ��



$char_tpFire = $guitpFire ;���ܿ�ݼ�
$char_fireFire = $guifireFire ;���ܿ�ݼ�
$char_armFire = $guiarmFire ;���ܿ�ݼ�


$arrayroomName[0] = $guiavAlpName[0]
$arrayroomName[1] = $guiavAlpName[1]
$arrayroomName[2] = $guiavAlpName[2]
$arrayroomName[3] = $guiavAlpName[3]
$arrayroomName[4] = $guiavAlpName[4]
$arrayroomName[5] = $guiavAlpName[5]
$arrayroomName[6] = $guiavAlpName[6]
$arrayroomName[7] = $guiavAlpName[7]
$arrayroomName[8] = $guiavAlpName[8]
$arrayroomName[9] = $guiavAlpName[9]
$arrayroomName[10] = $guiavAlpName[10]
$arrayroomName[11] = $guiavAlpName[10]




$parm_speeddelay = $parm_sldspeed * 500 ;0-2  �������ֱ�Ϊ 0 300 600



HotKeySet("{F11}", "TogglePause")
HotKeySet("{F10}", "Terminate")
;;;; Body of program would go here ;;;;

While 1
	Sleep(100)
WEnd


;;;;;;;;
Func TogglePause()
	
	If $parm_imageMode = 2 Then
		_RefreshSystemTray()
	EndIf
	$Paused = Not $Paused
	
	If $parm_imageMode = 2 Then
		If $Paused = False Then
			$PidChild1 = _CoProc("child1") ;;���˶���̣��ж�Ѫ��������Ӷ�������˽������
			_CoProcReciver("Reciver")
		Else
			If ProcessExists($PidChild1) Then
				ProcessClose($PidChild1) ;�����ӽ���
			EndIf
		EndIf
	EndIf

	While $Paused = False
		Sleep(10)
		TrayTip("", "�ȴ�ִ����..", 1, 16)

		runGame()
	WEnd


	;Exit
	$checkbag = 1
	$boxisfull = 0
	$connectfailcount = 0
	$createroominqueecount = 0
	$notfinddoorCount = 0
	$repeatCreatroom = 0
	Sleep(10)
	TrayTip("", "��ͣ��...��", 9, 16)
	Sleep(86400000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "���˳�����", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	Dim $optcount = 0 ; ��¼�Ƿ������²�������ʱ����Ϊ�������ȣ����ͣ����һ��δ֪�����ϲ���
	If $parm_settime = 1 Then ;check if set tiem to shutdown
		tiemtoshut($parm_timedata)
	EndIf
	;-------------------- ��ʱ�ر�
	If $parm_closegame = 1 Then
		If $ranclosecount = 0 Then ;
			$begintime = _NowCalc()
			$ranclosecount = $ranclosecount + 1
		EndIf
		$endDateCalc = _DateDiff('n', $begintime, _NowCalc())
		If $endDateCalc >= $parm_closegamesec Then
			$ranclosecount = 0
			WinKill($title)
			TrayTip("", "��ʱ������Ϸ,�ͷ���Դ..", 1, 16)
			writelog("���---�� " & $round & " ��: ������Ϸ,�ͷ���Դ.")
			Sleep(5000)
		EndIf
	EndIf
	;-------------------
	;���Ӷ԰��ʺŵ����ƣ�                                    1. ���ʺŵ�����
	If $bindacc = 1 Then
		_GUICtrlStatusBar_SetText($StatusBar1, "��ʽ��-���˺�", 0)
		#CS 		If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
			;writelog("�ڵ�" & $other_traced_round + 1 & "�����˽��뷿��")
			MsgBox(4096, " ...... ��ʾ ...... ", "��󶨵��ʺŲ��������ȷ��")
			Exit 0
			EndIf
		#CE
		
		;����һ�����˺źͱ����˺ŵĶԱ�
		If $usr <> $Usrid Then
			MsgBox(4096, " ...... ��ʾ ...... ", "��󶨵��ʺŲ��������ȷ��")
			Exit 0
		EndIf
		
		If Not _IniVer() Then
			MsgBox(4096, " ...... ��ʾ ...... ", "��ȡ���˺���Ϣʧ�ܣ���ȷ��")
			Exit 0
		EndIf
		
	EndIf
	;------------------                                          ��ÿ�����ʹ�ô���
	If $bindlimitCount = 1 Then
		;If $round >= $limitRound + $ranLimte Then
		If $round >= $limitRound Then ;���԰�
			writelog("�ﵽѭ�����ƴ���")
			MsgBox(4096, " ..... ��ܰ��ʾ .........", "���Խ���,����Ϣ���ٹһ�" & @CRLF & "��ʹ�ò��޴�����")
			Exit 0
		EndIf
	EndIf
	
	;���Ӷ����ʹ�ô��������� ----------------                 .���ݿ���ʹ�ô�������,ʹ�õ����ݿ�
	;SQLiteFirstUpateDate(101)
	;SQLiteRead(101)
	;$parm_firstdate = $app_date
	;$parm_kpcount = $app_kpcount
	
	;�ĳ�ʹ���ı��ļ�����¼
	$parm_kpcount = _HexToString(IniRead("D2KP.dat", "ע��", "���", "0"))
	
	
	
	;$iDateCalc = _DateDiff('D', $parm_firstdate, _NowCalc())
	;-------------����Ϊ�������ѣ�
	If $bindTime = 1 Then
		;If $iDateCalc >= 30 Then
		;MsgBox(0, "������ʾ", "�����������ѵ���Ȩ���ޣ�������")
		;Exit 0
		;EndIf
		;30�켴Ϊ2592000��
		;If $parm_kpcount >= 51840 Then   ;��������ô�����
		If $parm_kpcount >= 200 Then
			MsgBox(0, "������ʾ", "�����Ƶ�����ѵ���Ȩ������������")
			Exit 0
		EndIf
	EndIf
	;---------------------------------------
	
	activeWindow()

	#CS //������Ϸ���棬�����ť����ս��
		MouseClick("left", 600, 455, 1)
		//����ս��
		MouseClick("left", 600, 455, 1)
		//������������
		MouseClick("left", 600, 455, 1)
		Sleep(50)
	#CE
	#CS    ;��̨ģ��������
		#Include <ACN_Mouse.au3>
		Opt("MouseCoordMode", 0)
		_MouseClickPlus($title, "left",400,320,1)
	#CE
	
	;����

	#CS 	 	Sleep(1000)
		MouseClick("left", 400, 300, 1)
		Sleep(500)
		MouseClick("left", 700, 560, 1)
		Sleep(500)
		MouseClick("left", 400, 360, 1)
		Sleep(4000)
		
	#CE


	If $testversion = 0 And $connectfailcount >= Random(1, 2) Then
		TrayTip("", "��������޷���½ս�������������׼����ͣ..", 1, 16)
		writelog("�쳣---�� " & $round & " ����������޷���½ս�������������ϵͳ��ͣһ��ʱ�䣡")
		
		$errtime = Random(15, 25) * 60
		For $aa = $errtime To 1 Step -1
			TrayTip("", "�һ�������ͣʣ������:" & Round($aa / 60, 1), 1, 16)
			Sleep(1000)
			If $parm_settime = 1 Then ;check if set tiem to shutdown
				tiemtoshut($parm_timedata)
			EndIf
		Next
		$connectfailcount = 0
	EndIf


	
	;�����ǽ�����Ϸ���ƶ������
	Select
		Case isInRoom() And $debugmode = 0
			;$roombegintime = _NowCalc()
			roomplay()
			;$inRoomDateCalc = _DateDiff('s', $roombegintime, _NowCalc())
			;writelog("������ʱ��---�� " & $round & " ����ʱ: " & $inRoomDateCalc & " ��")
			$optcount = $optcount + 1
			$repeatCreatroom = 0 ; ���һ���ڷ����ڵĻ����ظ�������Ĵ���������δ0
			;Sleep(1000)
			Sleep(Random(200, 400, 1) + $parm_speeddelay)
		Case waitCreatRoom()
			$optcount = $optcount + 1
			$repeatCreatroom = $repeatCreatroom + 1
			
			If $repeatCreatroom = 10 Then ;��������ظ������䣬��10�ε�ʱ��esc ����
				Send("{ESC}") ;����δ֪�Ľ���,��ȴ�,��ESC
				Sleep(2000)
				Send("{ESC}") ;����δ֪�Ľ���,��ȴ�,��ESC
				Sleep(2000)
				Return
			EndIf
			
			If $repeatCreatroom >= 20 Then ;��������ظ������䣬��������Ϸ
				writelog("�쳣---�� " & $round & " �ֳ��ֽ��������쳣��ϵͳ��ͣ�һ���")
				closeAndWait(0)
				$repeatCreatroom = 0
				Return
			EndIf
			TrayTip("", "׼��������Ϸ����.", 1, 16)
			Sleep(Random(2000, 3000, 1) + $parm_speeddelay)
			;Sleep(10)
		Case loginnotConnect()
			$connectfailcount = $connectfailcount + 1 ;�޷�����ս��
			$optcount = $optcount + 1
			TrayTip("", "�޷�����ս���������С���.", 1, 16)
			;Sleep(1000)
			Sleep(Random(200, 400, 1) + $parm_speeddelay)
		Case pwderror()
			$connectfailcount = $connectfailcount + 1 ;�޷�����ս��
			$optcount = $optcount + 1
			TrayTip("", "����������ԡ���.", 1, 16)
			Sleep(1000)
		Case selectRole()
			$repeatCreatroom = 0 ; ����˻ص�ѡ���ɫ�Ľ��棬�ظ�������Ĵ���������δ0
			$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ���Ҫ��������.", 1, 16)
			Sleep(2000)
		Case waitInputUsr()
			;$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ�ѡ���ɫ����.", 1, 16)
			Sleep(2000)
		Case waitLoginNet()
			;$connectfailcount = $connectfailcount + 1 ;�޷�����ս��
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ���Ҫ�����û�������.", 1, 16)
			Sleep(2000)
		Case waitInGame()
			$optcount = $optcount + 1
			TrayTip("", "�ȴ�������Ϸ��.", 1, 16)
			Sleep(2000)
		Case $debugmode = 1
			TrayTip("", "�ֶ�����ģʽ��.", 1, 16)
			Sleep(10)
			TrayTip("", "�ӽ���id: " & $PidChild1 & @CR & "����Ѫ��" & $childmsg[0] & @CR & "���ӷ�����" & $childmsg[1] & @CR & "���ӹ�Ӷ��Ѫ��" & $childmsg[2] & @CR & "��Ѫƿ��" & $childmsg[3] & @CR & "����ƿ��" & $childmsg[4] & @CR & "����ƿ��" & $childmsg[5] & @CR & "���˽����䣺" & $childmsg[6] & @CR & "����m�㣺" & $childmsg[7], 1, 16)
			Sleep(2000)
			
		Case Else
			;$optcount = 0
			
			TrayTip("", "�ȴ��У����Ժ�", 1, 16)
			;Sleep(Random(400, 600, 1) + $parm_speeddelay)
			Sleep(10)
	EndSelect
	
	;;���$optcount ��Ϊ0����ʾûִ�й��κβ�����ͣ����ĳ��δ֪���棬
	If $optcount = 0 And $debugmode = 0 Then
		;activeWindow() ;���Լ������
		WinActivate($title)
		$ohterImage = $ohterImage + 1 ;����һ��������ͳ�Ƴ�������δ֪������д���
		TrayTip("��Ϸ��������������쳣���ȴ���", $ohterImage, 1, 16)
		If $ohterImage > 20 Then;ѭ����100��
			TrayTip($ohterImage, "δ�ҵ��ĺ��ʲ�����������", 1, 16)
			Sleep(100)
			Send("{ESC}") ;����δ֪�Ľ���,��ȴ�,��ESC
			Sleep(100)
			If $ohterImage > 22 Then;
				Sleep(100)
				Send("{ESC}") ;����δ֪�Ľ���,����esc�����еĻ�,�򻻳ɰ��س�����
				Sleep(1000)
			EndIf
			If $ohterImage > 25 Then;   �������ϻس�������,��ֱ�ӽ�����Ϸ����,���´�,�����������򱨴�֮��
				Sleep(100)
				WinKill($title)
				writelog("�쳣---�� " & $round & " �ֳ���δ֪����������������쳣�����Թر����¿�����")
				#CS 				$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
					If $PID Then ProcessClose($PID)
				#CE
				$ohterImage = 0
				Sleep(1000)
			EndIf
		EndIf
	Else
		$ohterImage = 0 ; �ָ���ʼ״̬���������ۻ�
	EndIf
	
EndFunc   ;==>runGame

Func activeWindow()
	
	closeError() ;�ȹر���Ч�Ĵ����ͼ����

	;----------------����
	If $parm_ramclose = 1 Then
		ramclose() ;��ȡ����
	EndIf
	;
	
	;TrayTip("", "����ڣ�", 1,16)
	; �õ����� "this one" ���ݵļ��±����ڵľ��
	$handle = WinGetHandle($title)
	If @error Then
		;MsgBox(32, "����", "û�ҵ����ڴ��ڳ��򣬵�һ�����ȴ򿪰��ڣ�������ѡ�񵥻���ս���Ľ���")
		;Exit 0
		TrayTip("", "û���ҵ���Ϸ���ڣ����������С�", 1, 16)
		Sleep(1000)
		If Run($parm_path1 & " -w -title " & $title & " " & $parm_exeparm3, $parm_path2) = 0 Then
			;Run("F:\�����ƻ���II����֮��1.10\D2loader.exe -w -pdir Plugin -title d2 ", "",@SW_MAXIMIZE )
			
			;Sleep(3000)
			;$handle = WinActivate($title)
			;Send("{ENTER}")
			;If @error <> 0 Then
			MsgBox(32, "����", "�������ú���ȷ��·��", 10)
			Exit
		Else
			Sleep(3000)
			$handle = WinGetHandle($title)
			WinWait($title, "")
			WinActivate($title)
			Send("{ENTER}")
			Sleep(100)
		EndIf
	Else
		WinActivate($title)
	EndIf
	WinMove($title, "", 0, 0) ;�ƶ������ϣ���ֹ����������ס
	Sleep(50)
	$size = WinGetClientSize($title)
	If $size <> 0 Then ;�ҵ�����
		If $size[0] <> 800 And $size[1] <> 600 Then
			WinActivate($title)
			;MsgBox(0, "��ʾ", "����ȷ����Ϸ�Ƿ����Ǵ���ģʽ�����Ƚ���Ϸ���������ó�800*600")
			;Exit 0
		EndIf
	Else
		;MsgBox(0, "��ʾ", "û���ҵ���Ϸ����.")
	EndIf
	initialSize()
EndFunc   ;==>activeWindow

Func roomplay() ;���������е�������
	$killQuery = 1 ; ÿ���ȹ̶���kp��ʼ
	If $parm_ramevent = 1 Then
		getRam() ;��ȡ����¼�
	EndIf
	
	If isInRoom() And $guidrinkrej = 1 Then
		;�������ֵ������ÿ�ֶ����ȵ���Ƽ�����Ǹ����ֺȵ�
		If Mod($round + 1, 8) = 0 Then
			checkbagRev()
		EndIf
		If Mod($round + 1, 20) = 0 Then
			;a5bianshi()
			;Return
		EndIf
		;drinksurplusInbag("0x943030")
		;drinksurplusInbag("0x1828A4")
	EndIf
	
	If isInRoom() Then
		Select
			Case isInRoom() And $parm_boxing = 1 And bagisfull()
				writelog("����---�� " & $round & " ��: " & "��������")
				;Sleep(50)
			Case isInRoom() And $ckroledead = 1 And roleisdead() ;���жϹ�Ӷ���Ƿ�������
				writelog("��ɫ---�� " & $round & " ��: " & "��ɫ����")
				;Sleep(Random(1, 100, 1))
			Case isInRoom() And $ckact5 = 1 And notinfive() = False ;
				exitRoomWithMap(); �˳�����
			Case isInRoom() And $ckass = 1 And astisdead()
				$repeatrejpet = $repeatrejpet + 1 ;
				TrayTip("", "���Ե�" & $repeatrejpet & " �θ���pet", 1, 16)
				Sleep(500)
				If $repeatrejpet >= 2 Then
					Send("{LSHIFT}")
				EndIf
				If $repeatrejpet >= 6 Then ;��� �����ظ�ִ�и���Ĵ������� 10�Σ���ʾ����ûǮ�ˡ�
					writelog("��Ӷ��---�� " & $round & " ��: " & "������δ��ظ�����pet��������ûǮ�ˣ��Զ��˳���")
					WinClose($title)
					Sleep(1000)
					Exit 0
				EndIf
				
				TrayTip("", "pet���ˣ�������", 1, 16)
				Sleep(1000)
				resumepet() ;�����Ӷ��
				;exitRoom()
				;exitRoomWithMap()
				writelog("��Ӷ��---�� " & $round & " ��: " & "��Ӷ������")
				;Sleep(Random(80, 100, 1))
			Case isInRoom() And $parm_imageMode = 2 And ($parm_buyred = 1 Or $parm_buyblue = 1);---�Ƿ���Ҫ���ҩˮ
				TrayTip("", "����Ƿ���Ҫ���ҩˮ", 1, 16)
				;--�ȿ��Ƿ�����ҩˮ���еĻ����Ͳ�����
				If CheckpurpleBottle() = 0 And (ChecklifeBottle() = 0 Or CheckmanaBottle() = 0) Then ;���û�ҵ���ƿ���ͽ��ף�����ƿ�Ͳ���
					$repeatbuyred = $repeatbuyred + 1
					If $repeatbuyred >= 3 Then ;��� �����ظ�ִ�и���Ĵ������� 10�Σ���ʾ����ûǮ�ˡ�
						writelog("ҩˮ---�� " & $round & " ��: " & "����������ҩʧ�ܣ�������ûǮ�ˣ��Զ��˳���")
						WinClose($title)
						Sleep(1000)
						Exit 0
					EndIf
					
					Send("{N}")
					clikcTradeMaraInAct5() ; �����������
					Sleep(500)
					MouseMove(400 + Random(1, 10), 300 + Random(1, 5), Random(0, 5, 1))
					Sleep(300)
					If ChecklifeBottle() = 0 Then ;����ҩˮ
						TrayTip("", "û�к�ҩˮ��׼������", 1, 16)
						findbeltWater("heal", "0xA42818")
						tradewater(1)
					EndIf

					If CheckmanaBottle() = 0 Then
						TrayTip("", "û����ҩˮ��׼������", 1, 16)
						findbeltWater("mana", "0x303094")
						tradewater(2)
					EndIf
					MouseClick("left", 430, 460)
					Sleep(600)
					exitRoom()
					
					
				Else
					$repeatbuyred = 0
					TrayTip("", "��ҩˮ.", 1, 16)
					ContinueCase
				EndIf
				;Sleep(Random(200, 350, 1))
			Case Else ;����kp��kɽ�˵�
				
				Switch $killQuery ;
					Case 1 ;1��kp
						;����Ƿ񰴵���b
						If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
							Send("{ESC}")
							Sleep(500)
						EndIf
						$armrnd = Random(1, 10, 1) ;�����漴���ɷţ����߲���װ�׼���
						If $armrnd = 1 Then
							MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
							armShied()
						EndIf
						
						$shortpath = 0
						If ($parm_path = 1) Then ;��������·��
							;findpath(Random(1, 10, 1))
							TrayTip("", "parm,....1", 1, 16)
							$i = Random(1, 5, 1)
							If $i = 1 Then
								;findpath(11)
								a5clickRight1()
								a5clickRight2()
								a5clickRight3()
								a5clickRight4()
								a5clickRight5()
								
							ElseIf $i = 2 Then
								a5down1()
								If Random(1, 10, 1) = 1 Then
									MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
									armShied()
								EndIf
								a5down2()
							ElseIf $i = 3 Then
								a5downLeft1()
								a5downLeft2()
								;a5clickRight4()
								a5clickRight5()
								
							Else
								a5downLeft1()
								a5downLeft2()
								a5downLeft3()
							EndIf
							
						ElseIf ($parm_path = 2) Then
							TrayTip("", "parm,....2", 1, 16)
							If $parm_imageMode <> 2 Then
								$shortpath = Random(7, 9, 1)
								;$shortpath = 9
								findpath($shortpath) ;���·�ߣ����Ǵ�Сվ��ֱ����ȥ
							Else
								$shortpath = Random(7, 9, 1)
								;$shortpath = 9
								;findpath($shortpath) ;���·�ߣ����Ǵ�Сվ��ֱ����ȥ
								a5downLeft1()
								a5downLeft2()
								a5downLeft3()
							EndIf
						ElseIf ($parm_path = 3) Then
							TrayTip("", "parm,....3", 1, 16)
							;$shortpath = 11 ;text
							If $testversion = 1 Then ;����ǲ��԰棬��ָ��һ����ߵ�·��
								findpath(2) ;801 ��ֱ��- ���԰汾��ʱ���Ϊ������ߵ�·��
							Else ;���������µ�·��
								If $parm_imageMode <> 2 Then
									TrayTip("", "·��8.........", 1, 16)
									findpath(9) ;
								Else
									;findpath(801)
									$i = Random(1, 5, 1)
									If $i = 1 Then
										a5clickRight1()
										a5clickRight2()
										a5clickRight3()
										a5clickRight4()
										a5clickRight5()
										
									ElseIf $i = 2 Then
										a5down1()
										If Random(1, 10, 1) = 1 Then
											MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
											armShied()
										EndIf
										a5down2()
									ElseIf $i = 3 Then
										a5downLeft1()
										a5downLeft2()
										;a5clickRight4()
										a5clickRight5()
										
									Else
										a5downLeft1()
										a5downLeft2()
										a5downLeft3()
									EndIf
								EndIf
							EndIf
							;findpath(801) ��һ·�ߣ����Ǵ�Сվ��ֱ����ȥ ��
							;findpath($shortpath) ;
						ElseIf ($parm_path = 4) Then
							TrayTip("", "parm,....4", 1, 16)
							findpath(4) ;  ����ȶ���·�ߣ��ʺ϶�Ь��Ҫ�󲻸ߵģ�����wtҲ���е�
							
						ElseIf ($parm_path = 5) Then
							;findpath(2) ; �˴������ڶ�����109��·��
							TrayTip("", "ר�ö���·���滮��", 1, 16)
							If $dingZhiFlag = "109" And findpath("109") = False Then
								exitRoom()
							EndIf
							If $dingZhiFlag = "113" And findpath("113") = False Then
								exitRoom()
							EndIf
						EndIf
						
						
						If isInRoom() And finddoor() Then
							If isInRoom() Then ;��ֹ���������ܶϿ��˷���
								;CheckMove($Char_CheckMoveDelay)
								If $parm_imageMode = 2 Then
;~ 									CheckMove($Char_CheckMoveDelay)
;~
;~
									;	$coord = PixelSearch(150, 300, 400, 500, 0x18FC00, 30, 2, $title) ;�ж��Ƿ�ȷʵ�н����ţ��·��б��ɫ  0x18FB01 18FC00 0x00FC19
									;	If Not @error Then
									;	$monsterColor1 = "0x18FC00" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC
									;	$monsterColor1_hex = "18FC00"
									;	$tp_Pix = countFirepointRec(150, 300, 400, 550, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
									;	If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then

;~ 									$findflag = 0 ;a5right ; �Һ����ұ��������
;~ 									$begin1 = TimerInit()
;~ 									Do
;~ 										If isInTown() == False Then
;~ 											$findflag = 1
;~ 										Else
;~ 											CheckMove($Char_CheckMoveDelay)
;~ 										EndIf
;~ 										$dif = TimerDiff($begin1)
;~ 									Until $findflag = 1 Or $dif >= 3000
;~ 									If isInTown() == False Then ;���Ƿ��ڳ���
;~ 									Else ;û�ҵ�������£��˳�����
;~ 										WinActivate($title)
;~ 										Sleep(1000)
;~ 										exitRoomWithMap()
;~ 										Return
;~ 									EndIf
									
								EndIf
;~

								TrayTip("", "ս��ǰ׼��.", 1, 16)
								;afterReady()
								TrayTip("", "������Ƥ�ƶ�.", 1, 16)
								movekp() ;·����Ҫ�Ż�����ֹͬһ��ŵ�
								Sleep(Random(20, 50, 1))
								CheckMove($Char_CheckMoveDelay)
								TrayTip("", "�ͷż���.", 1, 16)
								$fireround = $round ;�Ѿ������� fire
								
								If $parm_imageMode <> 2 Then
									fire(2) ;109 ��ʽ
								Else
									If $dingZhiFlag = "109" Then
										fire(2)
									Else
										fireMonsterByBlock(400, 20, 790, 520, 1, 10000) ; ����mod��������ɫ����Ĺ�����ʽ
									EndIf
								EndIf
								;fire("109")
								
								TrayTip("", "Ѱ����Ʒ.", 1, 16)
								finditem($parm_picktime)
								TrayTip("", "�˳�����.", 1, 16)
								If $onlykp = 1 Then ;���109���Ͳ�k������
									If $dingZhiFlag = "109" Then
										exitRoom()
									Else
										exitRoomWithMap()
									EndIf
								Else
									ReturnToTownWithMap()
									Sleep(Random(1500, 1800, 1) + $parm_speeddelay)
								EndIf

								$round = $round + 1
								$tfcount = $tfcount + 1
								$tfclosecount = $tfclosecount + 1
								$movebagcount = $movebagcount + 1
								
								
								_GUICtrlStatusBar_SetText($StatusBar1, "KP����: " & $round & "  �ۼ�kp������ " & $parm_kpcount + 1, 1)
								$parm_kpcount = $parm_kpcount + 1
								;SQLiteInsert(101, "", $parm_kpcount)
								IniWrite("D2KP.dat", "ע��", "���", _StringToHex($parm_kpcount))
								If $onlykp <> 1 Then
									$killQuery = 2 ; �ѱ��λ��Ϊ���������¾־Ϳ���k��������
								Else
									$killQuery = 1
								EndIf
							EndIf
						EndIf
						If $onlykp <> 1 Then
							ContinueCase
						EndIf
						
					Case 2 ;ɱ����ɽ������Ĺ�
						TrayTip("", "ɱ2.��������������.", 1, 16)
						$topleft = False
						$bottomright = False
						
						MouseClick("left", 135 + Random(1, 10), 400 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						MouseClick("left", 280 + Random(1, 10), 400 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						MouseClick("left", 380 + Random(1, 10), 350 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						;��Сվ��ͼƬ
						$coord = finda5xiaozhan() ;�ҵ���ݵ�λ��
						;ConsoleWrite(TimerDiff($t1) & @CRLF)
						If $coord[0] >= 0 And $coord[1] >= 0 Then
							TrayTip("", "����Сվ", 9, 16)
							Sleep(50)
							MouseMove($coord[0], $coord[1]);
							MouseClick('left', $coord[0] + 10, $coord[1] + 20)
							CheckMove($Char_CheckMoveDelay)
							;Sleep(1000)
						Else
							exitRoom()
							TrayTip("", "��Сվʧ�ܡ�������", 9, 16)
							Sleep(1000)
						EndIf
						
						MouseClick("left", 160 + Random(1, 10), 165 + Random(1, 10), 1)
						Sleep(3000)
						;����ڶ���Сվ�󣬿�ʼ�ж��Ƿ񵽴�
						$outtown = 0
						$begin1 = TimerInit()
						Do
						If isInTown() = true Then
							Sleep(1000)
						Else
							Break
						EndIf
						$dif = TimerDiff($begin1)
						Until $outtown = 1 Or $dif >= 3000
					
						MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
						$coord1 = PixelSearch(20, 20, 400, 300, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$topleft = True
							TrayTip("", "�Ϸ���ǵ�", 1, 16)
							;MouseMove($coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5))
						EndIf
						
;~ 						$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 30, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", "�·���ǵ�", 1, 16)
;~ 							;MouseMove($coord[0] + Random(1, 5), $coord[1] + Random(1, 5))
;~ 						EndIf
						
						If $topleft = True And $bottomright = True Then ;;���¶��б��λ������ָ���ص㣬����ɱ��
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							Else
								Send("{" & $char_tpFire & "}")
							EndIf
							$a = Random(1, 3)
							If $a = 1 Then
								MouseClick("right", $coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5), 1)
								CheckMove($Char_CheckMoveDelay)
								Sleep(200)
								MouseClick("right", 420 + Random(1, 10), 80 + Random(1, 10), Random(1, 2))
								CheckMove($Char_CheckMoveDelay)
								Sleep(200)
								MouseClick("right", 420 + Random(1, 10), 120 + Random(1, 10), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
							Else
								MouseClick("right", $coord1[0] + Random(1, 10), $coord1[1] + Random(1, 20), 1)
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
								MouseClick("right", 420 + Random(1, 20), 100 + Random(1, 20), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
								MouseClick("right", 420 + Random(1, 20), 100 + Random(1, 20), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							;fireMonsterByBlock(100, 20, 790, 520, 0) ; ����mod��������ɫ����Ĺ�����ʽ
							fireMonsterByColor(20, 20, 790, 560, 0)
							TrayTip("", "Ѱ����Ʒ.", 1, 16)
							finditem($parm_picktime)
							;TrayTip("", "�˳�����.", 1, 16)
							;ReturnToTownWithMap()
							;exitRoom()
							$killQuery = 3 ; ��Ϊ1���Ϳ���kpȥ��
						Else
							exitRoom() ;
						EndIf
						
						ContinueCase
						
					Case 3 ;ɱɽ��
						;����Ƿ񰴵���b
						If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
							Send("{ESC}")
							Sleep(500)
						EndIf
						$topleft = False
						$bottomright = False
						
						Send("{" & $char_tpFire & "}")
						$xrd = Random(-2, 2, 1)
						$yrd = Random(-2, 2, 1)
						$findflag = 0
						$begin1 = TimerInit()
						Do
							If isInRoom() Then
								$coord = PixelSearch(10, 300, 700, 400, 0x18FC00, 10, 1, $title) ;0x118FB01
								If @error Then
									TrayTip("", "˲����...", 1, 16)
									$i = Random(1, 2, 1)
									If $i = 1 Then
										MouseClick("right", 380 + $xrd, 400 + $yrd, Random(1, 3)) ;50
									Else
										MouseClick("right", 370 + $xrd, 450 + $yrd, Random(1, 3)) ;50
									EndIf
									Sleep(200)
									$findflag = 0
								Else
									$findflag = 1
									MouseClick("right", $coord[0], $coord[1], Random(1, 3)) ;50
									Sleep(500)
								EndIf
							Else
								Return
							EndIf
							$dif = TimerDiff($begin1)
						Until $findflag = 1 Or $dif >= 10000
						
						MouseClick("right", 500, 500, 1) ;50
						Sleep(500)
						
						;����ڶ���Сվ�󣬿�ʼ�ж��Ƿ񵽴�
						MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
						$coord1 = PixelSearch(20, 20, 400, 300, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$topleft = True
							TrayTip("", "�Ϸ���ǵ�", 1, 16)
							;MouseMove($coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5))
						EndIf
						
						$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$bottomright = True
							TrayTip("", "�·���ǵ�", 1, 16)
							;MouseMove($coord[0] + Random(1, 5), $coord[1] + Random(1, 5))
						EndIf
						
						If $topleft = True And $bottomright = True Then ;;���¶��б��λ������ָ���ص㣬����ɱ��
							
							;fireMonsterByBlock(400, 200, 790, 585, 0) ; ����Ŀ�ĵغ��ȼ�����ܣ��й־����ͷż���
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf


							$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(20, 25), $coord[1] + Random(20, 25))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(400, 10, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(40, 45), $coord[1] + Random(180, 190))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(500, 300, 780, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(100, 120), $coord[1] + Random(40, 45))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(410, 300, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(5, 12), $coord[1] + Random(200, 220))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(500, 300, 780, 560, $biaojicolor1, 10, 1, $title) ;�ﵽ¥���·��Ĵ�ֵ㣬���Դ��
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(55, 60), $coord[1] + Random(40, 45))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(420, 250, 600, 500, $biaojicolor1, 10, 1, $title) ;�����м��ֵ�
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(150, 160), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(420, 200, 790, 500, $biaojicolor1, 10, 1, $title) ;�������ұ�һ����־��
							If Not @error Then
								$bottomright = True
								TrayTip("", "����ָ���ص�", 1, 16)
								MouseMove($coord[0] + Random(10, 15), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							;�˴������Ӽ������������ж���ߣ���߼��꣬�ٻص���־�㣬���ж��ұ߼���
							finditembyzone(50, 50, 400, 500, $parm_picktime)
							$coord = PixelSearch(420, 200, 790, 500, $biaojicolor1, 10, 1, $title) ;�������ұ�һ����־��
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(10, 15), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0) ;���Դ��
							TrayTip("", "Ѱ����Ʒ.", 1, 16)
							finditem($parm_picktime)
							TrayTip("", "�˳�����.", 1, 16)
							exitRoom()
							$killQuery = 1 ; ��Ϊ1���Ϳ���kpȥ��

						Else
							exitRoom() ;
						EndIf
						
						
				EndSwitch
		EndSelect
	EndIf
EndFunc   ;==>roomplay


Func finditem($parm_picktime)
	Sleep(10)
	MouseMove(400 + Random(1, 80, 1), 300 + Random(1, 80, 1), Random(1, 8, 1))
	;�˴�����һ����91d2������Ϣ���жϹ��ܣ��ȼ��������Ϣ������У�����С��Χ
	
	
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		
		If $parm_path <> 5 Then
			$coord = PixelSearch(20, 80, 50, 90, 0x1CC40C, 30, 2, $title)
			If Not @error Then
				TrayTip("", "������Ϣ....", 1, 16)
				Send("{N}")
				Sleep(10)
				Send("{N}")
				Sleep(20)
			EndIf
		EndIf
		
		$coord = PixelSearch(200, 20, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1, 16)
			MouseMove($coord[0], $coord[1] + 5, Random(1, 10, 1))
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", Default, Default, 1) ;����󽨵㶫��
			Sleep(1500)
			CheckMove($Char_CheckMoveDelay)
			;�˴������鴫�ͼ춫��
			#CS 				 				Send("{F6}")
				Sleep(100)
				MouseClick("right", Default, Default, 1)
				Sleep(500)
			#CE
			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
			
		EndIf
		Sleep(10)
	Next
	Send("{ALT up}")
	Sleep(10)
	For $i = Random(2, 4, 1) To 1 Step -1
		Send("{LALT}")
	Next

EndFunc   ;==>finditem

Func finditembyzone($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $parm_picktime)
	Sleep(10)
	MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 50, 1))
	Sleep(20)
	;�˴�����һ����91d2������Ϣ���жϹ��ܣ��ȼ��������Ϣ������У�����С��Χ
	$coord = PixelSearch(200, 50, 300, 100, 0x1CC40C, 30, 1, $title)
	If Not @error Then
		TrayTip("", "����ս��������Ϣ��������", 1, 16)
		;MouseClick("left", 450, 100, 2) ;����������
		Send("{N}")
		Sleep(500)
	Else ;���û����
		
		Send("{ALT down}")
		For $i = 1 To $parm_picktime Step 1
			$coord = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, 0x1CC40C, 30, 1, $title)
			If Not @error Then
				TrayTip("", "������Ҫ����Ʒ", 1, 16)
				MouseMove($coord[0], $coord[1] + 5)
				Sleep(50)
				MouseClick("left", Default, Default, 1) ;����󽨵㶫��
				Sleep(1500)
			EndIf
			Sleep(100)
		Next
		Send("{ALT up}")
		
	EndIf
EndFunc   ;==>finditembyzone

Func movekp()
	$xrd = Random(-3, 3, 1)
	$yrd = Random(-3, 3, 1)
	;TrayTip("", "�������·��" & "�����Ի�ƫ��" & $xrd & $yrd, 1, 16)
	TrayTip("", "�������·��", 1, 16)
	If $fire = 1 Then
		Send("{" & $char_tpFire & "}")
	ElseIf $fire = 2 Then
		
	EndIf
	
	; ���·������ר�ö��ƣ���ָ��
	If $parm_path = 5 Or $parm_imageMode <> 2 Then
		MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
		;MouseClick("right", 590 + $xrd, 110 + $yrd, 1)
		;CheckMove(600)
		Sleep(350)
		Return
	EndIf
	
	
	;�������ר�ö��ƣ�����1.11��
	Sleep(Random(10, 50))
	$kppath = 4 ;Random(1, 10, 1)
	If $testversion = 1 Then
		$kppath = 1
	EndIf
	;������tp��·����1��tp 4�Ρ�
	;Sleep(350 + $parm_speeddelay)
	;MouseMove(740 + $xrd, 120 + $yrd)  ;��cpu��������е�
	;Sleep(350 + $parm_speeddelay)     ;��cpu��������е�
	Switch $kppath ;gm ���ܻ����tp����������־�����Ϊ���̶���Ϊ��
		Case 1
			MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
			;MouseClick("right", 590 + $xrd, 110 + $yrd, 1)
			;CheckMove(600)
			Sleep(350)
			;Sleep(600)
		Case 2
			MouseClick("right", 480 + $xrd, 50 + $yrd, 1) ;120
			Sleep(350 + $parm_speeddelay)
			;MouseMove(750,50)
			MouseClick("right", 630 + $xrd, 150 + $yrd, 1) ;50
			Sleep(350 + $parm_speeddelay)
			;MouseMove(750,50)
			MouseClick("right", 630 + $xrd, 180 + $yrd, 1) ;30
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 630, 150, 1) ;30
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 630, 180, 1) ;30
			Sleep(350 + $parm_speeddelay)
		Case 3
			MouseClick("right", 700 + $xrd, 60 + $yrd, 1) ;120
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 700 + $xrd, 60 + $yrd, 1) ;50
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 700 + $xrd, 70 + $yrd, 1) ;30
			Sleep(350 + $parm_speeddelay)
			
			MouseClick("left", 500 + $xrd, 255 + $yrd, Random(1, 2, 1))
			;MouseClick("right", 500 + $xrd, 240 + $yrd, 1) ;30
			Sleep(100)
		Case Else
			;������ɫ��ǵķ�ʽtp
			$xrd = 1
			$yrd = 1
			$beginAttackTime = TimerInit()
			$i = Random(1, 3, 1)
			Switch $i
				Case 1
					$first_left = 630 + $xrd
					$first_right = 120 + $yrd
				Case 2
					$first_left = 630 + $xrd
					$first_right = 100 + $yrd
				Case 3
					$first_left = 620 + $xrd
					$first_right = 90 + $yrd

			EndSwitch

			MouseClick("right", $first_left, $first_right, Random(1, 3)) ;50
			Sleep(200 + $parm_speeddelay)
			$findflag = 0
			$i = Random(1, 2, 1)
			Switch $i
				Case 1
					Do
						If isInRoom() Then
							$coord = PixelSearch(10, 10, 700, 300, 0x18FC00, 10, 1, $title) ;0x118FB01
							If @error Then
								TrayTip("", "˲����...", 1, 16)
								$i = Random(1, 2, 1)
								If $i = 1 Then
									MouseClick("right", 540 + $xrd, 150 + $yrd, Random(1, 3)) ;50
								Else
									MouseClick("right", 500 + $xrd, 130 + $yrd, Random(1, 3)) ;50
								EndIf
								Sleep(200 + $parm_speeddelay)
								$findflag = 0
							Else
								$findflag = 1
							EndIf
						Else
							Return
						EndIf
						$dif = TimerDiff($beginAttackTime)
					Until $findflag = 1 Or $dif >= 15000
				Case 2
					Do
						If isInRoom() Then
							$coord = PixelSearch(10, 10, 700, 300, 0x18FC00, 20, 2, $title)
							If @error Then
								TrayTip("", "˲����...", 1, 16)
								MouseClick("right", 550 + $xrd, 180 + $yrd, Random(1, 3)) ;50
								Sleep(250 + $parm_speeddelay)
								$findflag = 0
							Else
								$findflag = 1
							EndIf
						Else
							Return
						EndIf
						$dif = TimerDiff($beginAttackTime)
					Until $findflag = 1 Or $dif >= 10000
			EndSwitch
			
			
			
			$coord = PixelSearch(10, 5, 500, 300, 0x18FC00, 20, 2, $title) ; �ҵ����Ͻǵ���ɫ��Ǻ�tp �������ұ�
			If Not @error Then
				TrayTip("", "����tp2", 1, 16)
				If $coord[0] + 250 >= 790 Or $coord[1] + 120 >= 580 Then ;�ж��Ƿ�Խ�磬��Խ�磬�����Ƿɹ���
					TrayTip("", "����tp2�쳣", 1, 16)
					Sleep(300 + $parm_speeddelay)
					MouseClick("right", $coord[0], $coord[1] + Random(120, 125), Random(1, 3, 1))
				Else
					MouseClick("right", $coord[0] + Random(250, 255), $coord[1] + Random(120, 125), Random(1, 3, 1))
					Sleep(300 + $parm_speeddelay)
				EndIf
			EndIf
			
			;�������������������λ��tp����p����
			$findflag = 0
			$beginAttackTime = TimerInit()
			Do
				;CheckMove($Char_CheckMoveDelay)
				$coord = PixelSearch(10, 5, 700, 300, 0x18FC00, 30, 1, $title) ;
				If Not @error Then
					$coord1 = PixelSearch(350, 280, 790, 560, 0x18FC00, 25, 2, $title) ; �������·���û����ɫ��ǣ��еĻ�����ʾ����������м�
					If Not @error Then
						TrayTip("", "����tp3.����", 1, 16)
						If $coord1[0] + 130 >= 790 Or $coord1[1] - 205 >= 580 Then ;�ж��Ƿ�Խ�磬��Խ�磬�����Ƿɹ���
							TrayTip("", "����tp3.�쳣����", 1, 16)
							exitRoomWithMap()
						Else
							MouseClick("right", $coord1[0] + 130 + Random(5, 10, 1), $coord1[1] - Random(205, 210, 1), Random(1, 3, 1)) ;�ұ߲���
							Sleep(200 + $parm_speeddelay)
							;CheckMove($Char_CheckMoveDelay)
							$coord2 = PixelSearch(10, 20, 350, 300, 0x18FC00, 30, 1, $title) ; �ٴ��ж��Ƿ�tp ���������ˣ������Ҳ��������
							If @error Then
								$findflag = 1
								;Sleep(1000)
							Else
								CheckMove($Char_CheckMoveDelay)
							EndIf
						EndIf
						
					Else
						;�ж����·��Ƿ��У���ʾtp ���ˣ������Ѿ����˷�������
						$coordLeft = PixelSearch(2, 350, 200, 560, 0x18FC00, 30, 1, $title) ;����λ�ú��ҵ���Ӧλ�õĵط�,
						If Not @error Then ;��������
							TrayTip("", "����tp����", 1, 16)
							If $coordLeft[0] + 250 >= 790 Or $coordLeft[1] + 120 >= 580 Then ;�ж��Ƿ�Խ�磬��Խ�磬�����Ƿɹ���
								TrayTip("", "����tp���쳣��", 1, 16)
								exitRoomWithMap()
							Else
								MouseClick("right", $coordLeft[0] + Random(250, 255), $coordLeft[1] + Random(120, 125), Random(1, 3, 1))
								Sleep(300 + $parm_speeddelay)
							EndIf
						Else
							TrayTip("", "�ɹ��ˡ���", 1, 16)
							;MouseClick("right", $coord[0] + Random(250, 255), $coord[1] + Random(120, 125), Random(1, 3, 1))
							exitRoomWithMap()
							Sleep(300 + $parm_speeddelay)
						EndIf
					EndIf
				Else
					TrayTip("", "��������tp����", 1, 16)
					;Sleep(1000)
					;Return
				EndIf
				$dif = TimerDiff($beginAttackTime)
			Until $findflag = 1 Or $dif >= 8000

			
			
			
;~ 			$coord = PixelSearch(10, 5, 700, 300, 0x118FB01, 10, 1, $title) ;����λ�ú��ҵ���Ӧλ�õĵط�
;~ 			If Not @error Then
;~ 				$coord1 = PixelSearch(350, 280, 790, 560, 0x118FB01, 10, 1, $title) ;����λ�ú��ҵ���Ӧλ�õĵط�,
;~ 				If Not @error Then
;~ 					TrayTip("", "����tp2", 1, 16)
;~ 					;MouseClick("right", $coord[0] + 550, $coord[1] - 10, Random(1, 2,1))  ;��߲���
;~ 					MouseClick("right", $coord1[0] + 150 + Random(5, 10, 1), $coord1[1] - Random(205, 210, 1), Random(1, 2, 1)) ;�ұ߲���
;~ 					Sleep(350 + $parm_speeddelay)
;~ 				Else
;~ 					exitRoomWithMap()
;~ 				EndIf
;~ 			Else
;~ 				exitRoomWithMap()
;~ 			EndIf

			
	EndSwitch

EndFunc   ;==>movekp
Func fire($var = 1)
	takefire($var, $parm_blztime, $parm_blzrnd)
EndFunc   ;==>fire

Func isInTown() ; �ڳ�����
	;If findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = True Then
	If isInRoom() = True And findPointColor(125, 595, "2C1008") = True Then ;28241C  ��
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>isInTown

Func isInRoom($color = 0xB08848) ;��鿴�����·��Ƿ��л�ɫ�����������б�ʾ����Ϸ��
	If findPointColor(30, 585, "040404") = False Then
		$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
		If Not @error Then
			Return True
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>isInRoom
Func waitLoginNet()
	;����ս�����ж��Ƿ�׼����battle
	If isInRoom() = False And findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
		If $parm_gamemode = 1 Then
			MouseClick("left", 400 + Random(-50, 50), 350 + Random(-2, 2))
			Return True
		Else
			TrayTip("", "����ģʽ", 1, 16)
			;����
			MouseClick("left", 400, 300, 1)
			Sleep(500)
			MouseClick("left", 700, 560, 1)
			Sleep(500)
			MouseClick("left", 400, 360, 1)
			Sleep(4000)
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;����ս�����ж��Ƿ�׼����battle
	If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
		MouseClick("left", 360 + Random(-50, 50), 430 + Random(-5, 5))
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;����ս�����ж��Ƿ�׼�������˺�����
	If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
		MouseClick("left", 400 + Random(-50, 50), 340 + Random(-1, 1), 2)
		Sleep(500)
		;ControlSend($title, "", "", $usr,1)
		Send($usr, 1) ;������»��ߵȣ��������
		Sleep(1500)
		MouseMove(400 + Random(-5, 5), 390 + Random(-1, 1))
		Sleep(1000)
		MouseClick("left", 400 + Random(-5, 5), 390 + Random(-5, 5), 2)
		Sleep(500)
		;ControlSend($title, "", "", $psd, 1)
		Send($psd, 1)
		Sleep(1000)
		Send("{ENTER}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitInputUsr

Func pwderror()
	If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") Then
		If findPointColor(360, 400, "646464") Then
			$i = Random(1, 3)
			If $i = 1 Then
				MouseMove(400 + Random(-10, 10), 390 + Random(-2, 2))
				Sleep(500)
				MouseClick("left", Default, Default)
			Else
				Send("{ENTER}")
			EndIf
			Sleep(500)
			Return True
		Else
			Send("{ENTER}")
			Sleep(500)
			Return True
		EndIf
	Else
		Return False
	EndIf
	;MouseMove(290, 510)  242424
	;MouseMove(290, 560) 303030
	
	;MouseMove(360, 400) 646464
EndFunc   ;==>pwderror

Func selectRole()
	;select role which is to be used
	;If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "343434") Then
	
	If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
		Select
			Case $pos = 1
			Case $pos = 2
				Send("{DOWN}")
			Case $pos = 3
				Send("{DOWN 2}")
			Case $pos = 4
				Send("{DOWN 3}")
			Case $pos = 5
				Send("{RIGHT}")
			Case $pos = 6
				Send("{RIGHT}")
				Send("{DOWN}")
			Case $pos = 7
				Send("{RIGHT}")
				Send("{DOWN 2}")
			Case $pos = 8
				Send("{RIGHT}")
				Send("{DOWN 3}")
		EndSelect
		Sleep(2000)
		$i = Random(1, 3)
		If $i = 1 Then
			Send("{ENTER}")
		Else
			MouseMove(690 + Random(-50, 50), 550 + Random(-2, 2))
			Sleep(1000)
			MouseClick("left", Default, Default)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>selectRole
Func waitCreatRoom()
	;����ս�����ж��Ƿ�׼��������
	;If findPointColor(30, 585, "040404") And findPointColor(325, 585, "040404") Then
	;If findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") And findPointColor(180, 350, "040404") Then ; 109 �Ĳ���
	If isInRoom() = False And findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") Then ; 109 �Ĳ���	 ttbn ����
		TrayTip("", "����ս������,׼����������..", 1, 16)
		;����ҵ�����ʾ���ڴ���
		;�����䣬�ж��Ƿ���ֶԻ������޷�������ͬ������ʾ���м����ֶԻ���
		Sleep(Random(50, 3000));�������ֹÿ�ν�����ļ������ͬ
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
		If isInRoom() = False And findPointColor(385, 250, "040404") = False Then
			;Send("{ENTER}") ;ԭ����enter
			MouseClick("left", 400 + Random(1, 10), 320 + Random(1, 10))
			Sleep(500)
			Return True
		ElseIf isInRoom() = False And findPointColor(445, 410, "786C60") = True Then
			
			$createroominqueecount = $createroominqueecount + 1
			If $createroominqueecount >= 3 Then
				Sleep(1000 * 60 * 20)
				$createroominqueecount = 0
			EndIf
			
			TrayTip("", "��Ҫ�ȴ��Ŷӣ�����..", 1, 16)
			Send("{ESC}") ;ԭ��Ϊenter��
			Sleep(500)
			Return True
		Else
			$createroominqueecount = 0
			If isInRoom() = False Then
				createRoom()
				Return True
			Else
				Return False
			EndIf
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>waitCreatRoom

Func waitInGame() ;�ȴ�������Ϸ�� ,�������ܶ��Ǻڿ�,�м����������
	If findPointColor(100, 100, "000000") = True And findPointColor(100, 600, "000000") = True And findPointColor(500, 100, "000000") = True And findPointColor(500, 600, "000000") = True Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitInGame
Func createRoom() ;����ս����Ϸ������
	;/������Ϸ���棬�����ť����ս��
	;MouseClick("left", 600, 455, 1)
	;//����ս��
	;MouseClick("left", 700, 455)   ;�ȵ��¼�����Ϸ
	MouseClick("left", 600 + Random(-50, 50), 455 + Random(-2, 2))
	;MouseClick("left", 705, 378) ;ѡ�����Ѷ�
	Sleep(1000)
	; //������������
	If $nameCat = 1 Then
		Dim $str = ""
		Dim $roomcount = Random($parm_namelenfr, $parm_namelento, 1)
		;msgbox(0,$roomcount,$roomcount)

		$str = ""
		For $i = 1 To $roomcount Step 1
			$str = $str & $arrayroomName[Random(0, 11, 1)]
		Next

		#CS 		For $i = 1 To $roomcount
			$str = $str & Chr(Random(97, 104, 1))
			Next
		#CE
		
		ControlSend($title, "", "", $str)
		
	ElseIf $nameCat = 2 Then
		ControlSend($title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
	ElseIf $nameCat = 3 Then
		If $parm_namepre = "" Then ;���ǰ׺û��������Ūһ��
			$parm_namepre = Chr(Random(97, 117, 1)) & Chr(Random(97, 117, 1))
		EndIf
		ControlSend($title, "", "", $parm_namepre & $ct)
		$ct = $ct + 1
	Else ;���������������Ҿ��뼸���̶�������
		If $parm_namegd = "" Then
			$parm_namegd = Random(111, 333, 1)
		EndIf
		ControlSend($title, "", "", $parm_namegd)
	EndIf

	Sleep(Random(400, 500, 1))
	If isInRoom() = False Then ;�����ֹ������Ϸ���е��
		MouseClick("left", 680 + Random(1, 5), 410 + Random(1, 10), 1)
	EndIf
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Sleep(100)
	Send("{ESC}")
	Sleep(10)
	MouseClick("left", 400 + Random(1, 50), 250 + Random(1, 10), 1)
	Sleep(10)
EndFunc   ;==>exitRoom

Func ReturnToTownWithMap()
	Sleep(100)
	Send("{BS}")
	Sleep(1000)
EndFunc   ;==>ReturnToTownWithMap

Func exitRoomWithMap()
	Sleep(100)
	Send("{-}")
	Sleep(10)
EndFunc   ;==>exitRoomWithMap

Func finddoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ�Һ���.", 1, 16)
	Sleep(Random(1, 1, 1))
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 100
	$top = 50
	$right = 400
	$bottom = 300
	;Sleep(1000)



	#CS    ;xp:
		If findredDoor($left, $top, $right, $bottom) Then
		TrayTip("", "�ҵ����Ų����룡.", 1, 16)
		Return True
		Else
		TrayTip("", "Ѱ�Һ���ʧ�ܣ�.", 1, 16)
		Sleep(500)
		Return False
		EndIf
		
	#CE
;~ 	;�˴����ԼӸ� ��ͼƬ��ͼ�ķ�ʽ
;~ 		$coord = findreddoor1() ;�ҵ���ݵ�λ��
;~ 		;ConsoleWrite(TimerDiff($t1) & @CRLF)
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			MouseClick('left', $coord[0] +10 , $coord[1] + 50)
;~ 		Else
;~ 			TrayTip("", "û���ҵ�", 9, 16)
;~ 	       Sleep(2000)
;~ 		EndIf

	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "�ҵ����ţ�", 1, 16)
		$notfinddoorCount = 0 ;����ҵ����ţ��Ͱ�δ�ҵ����ŵı�Ǵ�����Ϊ0
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y, Random(1, 10))
		Sleep(Random(50, 80, 1))
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;Sleep(Random(1400, 1600, 1))
		CheckMove($Char_CheckMoveDelay)
		Return True
	Else
		TrayTip("", "����δ�ҵ���׼���˳�����", 1, 16)
		Sleep(500)
		exitRoom()
		$notfinddoorCount = $notfinddoorCount + 1
		
		If $notfinddoorCount >= 2 Then
			Send("{LSHIFT}")
		EndIf
		
		If $notfinddoorCount >= 10 Then ;���10����������û�ҵ����ţ���ʾ���ܲ���act5������������Ь���ٶȲ���
			TrayTip("", "20������δ�ҵ����ţ����飡.", 1, 16)
			writelog("�쳣---�� " & $round & " �ֶ������δ�ҵ����ţ�ֹͣ�һ���")
			WinClose($title)
			Exit 0
		EndIf
		Return False
	EndIf
	
	
EndFunc   ;==>finddoor
Func findredDoor($left, $top, $right, $bottom)
	$exit = False
	$errorexit = False
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		If getRightPoint($x, $y) Then
			;MouseMove($x, $y)
			Sleep(1000)
			Return True
			;MsgBox(0, "", "right")
		Else
			For $k = $left To $right Step 100
				For $j = $top To $bottom Step 100
					;MsgBox(0,"","������")
					;TrayTip("", "��ѯ����." & $k & "" & $j, 1)
					If findNext($k, $j, $right, $bottom) Then
						;MsgBox(0, "", "������һ��")
						;TrayTip("", "�ҵ���һ�����ţ�.", 1, 16)
						;MouseMove($k, $j)
						;MouseClick("left", $k, $j, 1)
						;AAA()
						$exit = True
						ExitLoop
					EndIf
					;MsgBox(0, "", "���ң�" & $k & "" & $j)
					If $k >= $right And $j >= $bottom Then
						;MsgBox(0, "", "error")
						TrayTip("", "Ѱ�Һ���ʧ�ܣ��˳�.", 5, 16)
						$errorexit = True
						ExitLoop
					EndIf
				Next
				If $exit = True Then
					ExitLoop
				EndIf
				If $errorexit = True Then
					ExitLoop
				EndIf
			Next
			If $exit = True Then
				Return True
			EndIf
			If $errorexit = True Then
				exitRoom()
				Return False
			EndIf
			
			
		EndIf
	Else
		;MsgBox(0, "", "û��һ���׵�") ���һ���׵�û�ҵ���������û�����ŵ�λ�ã��˳���Ϸ����
		TrayTip("", "û���ҵ��ܺϺ��ű�־.", 1, 16)
		Sleep(400)
		exitRoom()
		Return False
	EndIf
EndFunc   ;==>findredDoor
Func findNext($left, $top, $right, $bottom)
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		Return getRightPoint($x, $y)
	Else
		Return False
	EndIf
EndFunc   ;==>findNext
Func getRightPoint($xx, $yy)
	;TrayTip("", "�Ҵ���20����ɫ�ĵ�.", 1)
	$total = 0
	For $i = -5 To 85 Step 1
		For $j = -5 To 105 Step 1
			$var = PixelGetColor($xx + $i, $yy + $j)
			If Hex($var, 6) = "FFFFFF" Then
				$total = $total + 1
			EndIf
		Next
	Next
	If $total >= 30 Then
		MouseMove($xx, $yy)
		MouseClick("left", $xx, $yy, 1)
		Sleep(500)
		;TrayTip("", "totalΪ��" & $total, 1)
		Return True
		;ElseIf  $total >= 15 Then
		; Return True
	Else
		;TrayTip("", "totalΪ��" & $total, 1)
		Return False
	EndIf
EndFunc   ;==>getRightPoint

Func bagisfull()
	If isInRoom() = True And $checkbag = 1 And $parm_MoveBox = 1000 Then ;����
		Send("{" & $char_Bag & "}")
		Sleep(100)
		MouseMove(300, 440)
		Sleep(100)
		InitialBagCheck()
		$emptybag = getbagLocation()
		TrayTip("", "��鱳��ʣ��������" & $emptybag, 1, 16)
		Sleep(400)
		
		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;���������Ʒռ�ã���ʾ��������
			TrayTip("", "�����ռ����: " & $emptybag & " ���������õĸ���: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{" & $char_Bag & "}")
			Sleep(500)
			
			If $boxisfull = 0 Then ;�����¼�ֿ������ı�ʾ =1 ����ʾ���ˣ��Ͳ����ٴ�ֿ��0 ȥ��ֿ�
				checkbagRev()
				;a5bianshi() �˴���������һ����ʶ
				gotoBox()
				If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
					;movebagtoBox()
					mapmove() ;���һ���õ�ͼת�ư����Ĳ���
					Sleep(100)
					exitRoom()
					Return True
				Else
					exitRoom()
					Return True
				EndIf
			EndIf
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;����û�ѡ���˰������˹ػ�,����ʾ
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "����ִ�йػ�", 1, 16)
				writelog("����---�� " & $round & " ��: " & "��������׼���ػ�")
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
			
		Else
			Send("{" & $char_Bag & "}")
			Return False
		EndIf
		#CS 	Else
			Return False
		#CE
	EndIf
	
	If isInRoom() = True And $checkbag = 1 And $parm_MoveBox = 2 Then ;���ù̶��ˣо�����ת��
		
		If $movebagcount >= $parm_moveround + Random(0, 0, 1) Then ;�������ֵ
			;If $movebagcount >= $parm_moveround  Then
			InitialBagCheck() ;�ȳ�ʼ�������ռ�
			;����һ������������װ���
			If $boxisfull = 0 Then ;�����¼�ֿ������ı�ʾ =1 ����ʾ���ˣ��Ͳ����ٴ�ֿ��0 ȥ��ֿ�
				;����ת��ǰ���Ⱥȵ������ҩˮ
				checkbagRev();
				;a5bianshi() �˴���������һ����ʶ
				;----����ת��ǰ���Ⱥȵ������ҩˮ
				gotoBox()
				If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
					;movebagtoBox()
					$movebagcount = 0 ;��ʼ��Ϊ�������Ժ��´����¿�ʼ����װ��
					mapmove() ;���һ���õ�ͼת�ư����Ĳ���
					Sleep(100)
					exitRoom()
					Return True
				Else
					exitRoom()
					Return True
				EndIf
			EndIf
			
			$emptybag = getbagLocation()
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;����û�ѡ���˰������˹ػ�,����ʾ
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "����ִ�йػ�", 1, 16)
				writelog("����---�� " & $round & " ��: " & "��������׼���ػ�")
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf
	
	
EndFunc   ;==>bagisfull


Func notinfive()
	TrayTip("", "����Ƿ���act5", 1, 16)
	Sleep(10)
	;����ͨ��ȡ���ж�
	If isInRoom() Then
		
;~ 		;ͨ������Ӷ�����жϼ���
;~ 		If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x008400, 0, 1, $title) = True Then ;��������ҵ���Ӷ��������act5�ˣ��ǾͲ���Ҫ��
;~ 			Return False
;~ 		EndIf
;~
;~ 		;0x016616 ������act ����ɫ
;~ 		If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = True Then ;��������ҵ���Ӷ���ģ�������act4�� �Ǿ�ȥact5
;~ 			;in act4
;~ 			TrayTip("", "��act4��׼��ȥact5����..", 1, 16)
;~ 			Sleep(300)
;~ 			MouseMove(740, 80)
;~ 			Sleep(500)
;~ 			MouseClick("left", Default, Default, 1)
;~ 			;MouseClick("left", 740, 80, 1)
;~ 			Sleep(2000)
;~ 			MouseClick("left", 340, 80, 1)
;~ 			Sleep(200)
;~ 			MouseClick("left", 340, 140, 1)
;~ 			Sleep(2000)
;~ 			exitRoom()
;~ 			Return True
;~ 		EndIf
		
		$coord = PixelSearch(200, 20, 500, 200, 0x118FB01, 25, 2, $title)
		If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
			; �ٴμ���·���û�зſ��Ŷ�
			$coord1 = PixelSearch(10, 300, 570, 520, 0x118FB01, 25, 2, $title)
			If Not @error Then
				Return False
			Else
				Return True
			EndIf
		Else
			Return False
		EndIf
		
	Else
		Return False ;��������ڷ����ڣ��ͷ���
	EndIf
	;MouseMove(280,80) ;act4 1    2C2C2C   4C4C4C
	;MouseMove(320,80) ;act4 2    242424   404040
	;MouseMove(350,80) ;act5 1   2C2C2C    181818
	;MouseMove(380,80) ;act5 2   242424   101010
	
EndFunc   ;==>notinfive


Func astisdead()
	TrayTip("", "���pet����û", 1, 16)
	Sleep(1)
	If isInRoom() Then
		;If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x008400, 0, 1, $title) = False And findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = False Then ;�������û�ҵ���Ӷ����,���߼�鵽pet����act4����ɫ
		If CheckpetStatus() = 0 And isInTown() = True Then ;������func
			#CS 			$repeatrejpet = $repeatrejpet + 1 ;
				TrayTip("", "���Ե�" & $repeatrejpet & " �θ���pet", 1, 16)
				Sleep(500)
				If $repeatrejpet >= 10 Then ;��� �����ظ�ִ�и���Ĵ������� 10�Σ���ʾ����ûǮ�ˡ�
				writelog("��Ӷ��---�� " & $round & " ��: " & "����10���ظ�����pet��������ûǮ�ˣ��Զ��˳���")
				WinClose($title)
				Sleep(1000)
				Exit 0
				EndIf
				
				TrayTip("", "pet���ˣ�������", 1, 16)
				Sleep(1000)
				resumepet()
				exitRoom()
			#CE
			Return True
			
		Else ;����У���ʾ��Ӷ���ڵ�
			$repeatrejpet = 0 ;����Ϊ 0
			Return False
		EndIf
		
	Else
		Return False
	EndIf
	#CS
		;------------------------------ ��һ����������
		Send("{O}")
		Sleep(300)
		;MouseMove(400, 300)
		;Sleep(50)
		;$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
		$a = PixelChecksum(160, 100, 200, 150, $title) ;   ;1649310059
		Sleep(300)
		Send("{O}")
		Sleep(300)
		If $a <> 1649310059 Then
		; -------------------------
		$repeatrejpet = $repeatrejpet + 1 ;
		TrayTip("", "���Ե�" & $repeatrejpet & " �θ���pet", 1, 16)
		Sleep(500)
		If $repeatrejpet >= 10 Then ;��� �����ظ�ִ�и���Ĵ������� 10�Σ���ʾ����ûǮ�ˡ�
		writelog("��Ӷ��---�� " & $round & " ��: " & "����10���ظ�����pet��������ûǮ�ˣ��Զ��˳���")
		WinClose($title)
		Sleep(1000)
		Exit 0
		EndIf
		
		TrayTip("", "pet���ˣ�������", 1, 16)
		Sleep(1000)
		resumepet()
		exitRoom()
		Return True
		Else
		$repeatrejpet = 0 ;����Ϊ 0
		Return False
		EndIf
	#CE
	


EndFunc   ;==>astisdead

Func resumepet()
	
	If $parm_imageMode = 2 And $dingZhiFlag = 109 Then
		MouseClick("left", 60, 220)
		Sleep(2000)
		$coord = findtianshi()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			TrayTip("", $coord[0] & $coord[1], 9, 16)
			MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0], $coord[1] + 20)
			Sleep(2000)
			MouseMove(356, 130)
			MouseClick("left", 356, 130, 1)
			;MouseMove(356,135)      ; ����pet
			;MouseClick("left",356,135,1)
			Sleep(2000)
			MouseClick("left", 400, 300, 1) ;˫��һ�Σ���ֹ�㵽�����Ի���ť
			Return
		Else
			;---------
			MouseMove(240, 200) ; ����еĵ������⣬�����ֶ���λ
			Sleep(2000)
			MouseClick("left", Default, Default, 1)
			Sleep(3000)
			MouseMove(356, 130)
			MouseClick("left", Default, Default, 1)
			Sleep(2000)
			MouseClick("left", 400, 300, 1) ;˫��һ�Σ���ֹ�㵽�����Ի���ť
			;--------------------
			TrayTip("", "û�ҵ�", 9, 16)
			Sleep(1000)
			Return
		EndIf
	EndIf
	
	If $parm_imageMode = 2 And $dingZhiFlag = 113 Then
		findpath(11301)
		;ͨ���ҷ���
		$monsterColor1 = "0xA420FC" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC  ��ɫ 0xFC2C00 ����"0xCE8523" ;��ɫ
		$monsterColor1_hex = "A420FC"
		$findflag113 = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "����npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0xCE8523, 30, 1, $title) ; �� 0x1CC40C ��ɫ��  ��ɫ 0xFC2C00  "0xCE8523" ;��ɫ
				If Not @error Then
					TrayTip("", "������", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + Random(1, 20), $coord[1] + Random(1, 5))
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(500)
					MouseClick("left", 398, 298, Random(2, 3, 1), 5)
					Sleep(50)
					$findflag113 = 1
				Else ;���ܴ����ҵ���ɫ������û����ȥ�����ߵ����ˣ�û�ҵ���ɫ�����
					TrayTip("", "���ʧ�ܣ�", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag113 = 1 Or $dif >= 20000
		Return
		;CheckMove($Char_CheckMoveDelay)
	EndIf
	
	
	If $parm_imageMode = 2 Then
		;ͨ����ɫ�췽ʽ����act5����
		MouseClick("left", 60 + Random(1, 10), 250 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 30 + Random(1, 10), 220 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 160 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 170 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 350, 250, Random(1, 2))
		MouseClick("left", 200, 290, Random(1, 2))
		CheckMove($Char_CheckMoveDelay)
		Sleep(2000) ;����npc���ƶ����ȵȵ�
		
		;ͨ���ҷ���
		$monsterColor1 = "0xA420FC" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC   ��ɫ 0xFC2C00    ��"0xCE8523" ;��ɫ
		$monsterColor1_hex = "A420FC"
		$findflag = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "����npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0xCE8523, 30, 1, $title) ; ��
				If Not @error Then
					TrayTip("", "������", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + 10, $coord[1] + 10)
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(1500)
					$findflag = 1
					exitRoomWithMap()
				Else ;���ܴ����ҵ���ɫ������û����ȥ�����ߵ����ˣ�û�ҵ���ɫ�����
					TrayTip("", "���ʧ�ܣ�", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 40000
		CheckMove($Char_CheckMoveDelay)
		
		
;~ 		$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 		If Not @error Then
;~ 			MouseClick("left", $coord[0] + 10, $coord[1] + 15)
;~ 			Sleep(5000)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		Else
;~ 			;ͨ��������ɫ
;~ 			TrayTip("", "����������.", 1, 16)
;~ 			Sleep(10)
;~ 			$coord = PixelSearch(80, 80, 380, 500, 0x118FB01, 30, 1, $title)
;~ 			If Not @error Then
;~ 				MouseMove($coord[0] - Random(20, 30), $coord[1] + Random(100, 120))
;~ 				MouseClick("left", Default, Default, 1)
;~ 				CheckMove($Char_CheckMoveDelay)
;~ 				Sleep(5000) ;����npc���ƶ����ȵȵ�
;~ 				$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 				If Not @error Then
;~ 					MouseClick("left", $coord[0] + Random(30, 50), $coord[1] + 10)
;~ 					CheckMove($Char_CheckMoveDelay)
;~ 				EndIf
;~ 			Else
;~ 				exitRoom()
;~ 			EndIf
;~ 			EndIf
		
		
		;������ѭ���ķ�ʽ��npc
;~ 	Else
;~ 		$coord = finda5aakkByPicture() ;�ҵ���
;~ 		;ConsoleWrite(TimerDiff($t1) & @CRLF)
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			;MouseMove($coord[0] +10 , $coord[1] + 50);
;~ 			MouseClick('left', $coord[0] + 5, $coord[1] + 5)
;~ 			Sleep(5000) ;�������ȡ�㸴��ĵİ�ť
;~ 			MouseClick("left", 380, 130, 1);���и��� ������㲻�У��˴����Խ���΢��
;~ 			Sleep(1500)
;~ 		Else
;~ 			TrayTip("", "û���ҵ�", 9, 16)
;~ 			Sleep(2000)
;~ 		EndIf
	EndIf
	
	If $parm_imageMode = 1 Then
		;����ȥ act4����
		MouseClick("left", 145, 520, 1)
		Sleep(2000)
		;MouseMove(170,520)
		MouseClick("left", 170, 520, 1)
		Sleep(2000)
		MouseClick("left", 310, 80, 1)
		Sleep(200)
		MouseClick("left", 310, 140, 1)
		Sleep(3000)
		;;����act4
		MouseClick("left", 130, 240, 1)
		Sleep(3000)
		MouseMove(280, 60)
		Sleep(500)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", 280, 60, 1);����̩���
		Sleep(2000)
		;MouseMove(380, 138)
		MouseMove(380, 130)
		Sleep(500)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", 380, 130, 1);���и���
		Sleep(1500)
		MouseClick("left", 380, 130, 1);����ǰ��act5
		Sleep(1500)
	EndIf
EndFunc   ;==>resumepet


Func a5bianshi()
	
	If $parm_imageMode = 2 Then
		;ͨ����ɫ�췽ʽ����act5����
		MouseClick("left", 60 + Random(1, 10), 250 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 30 + Random(1, 10), 220 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 160 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 170 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 150, 450, Random(1, 2))
		Sleep(2000)

		
		;ͨ���ҷ���
		$monsterColor1 = "0xFC2C00" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC  ,��ɫ 0xFC2C00
		$monsterColor1_hex = "FC2C00"
		$findflag = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "����npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0x1CC40C, 30, 1, $title) ; ��
				If Not @error Then
					TrayTip("", "������", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + Random(1, 20), $coord[1] + Random(1, 5))
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(200)
					$findflag = 1
					exitRoomWithMap()
				Else ;���ܴ����ҵ���ɫ������û����ȥ�����ߵ����ˣ�û�ҵ���ɫ�����
					TrayTip("", "���ʧ�ܣ�", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 20000
		CheckMove($Char_CheckMoveDelay)
		
		
	EndIf
EndFunc   ;==>a5bianshi

Func roleisdead()
	If astisdead() = True Then ;��ɫ�����󣬹�Ӷ���϶����ˣ��������ж��¹�Ӷ��

		TrayTip("", "��������Ƿ����", 1, 16)
		Send("{" & $char_Bag & "}")
		Sleep(500)
		If findPointColor(460, 250, "242424") = True And findPointColor(505, 250, "040404") = True And findPointColor(690, 250, "282828") = True Then
			;�������,��ָ,Ь����������ɫ��ΪĬ����ɫ,���ʾ����û��װ��,������
			Send("{" & $char_Bag & "}")
			;Sleep(500)        ;
			;MouseMove(395, 278)   ;��Щ������ʬ���������Ϸ���λ�á���ʱ��
			;Sleep(3000)
			;MouseClick(395, 278);   ;��Щ������ʬ���������Ϸ���λ�á���ʱ��
			Sleep(500)
			MouseClick("left", 400, 285, 1)
			Sleep(2000)
			MouseClick("left", 400, 315, 1)
			Sleep(1000)
			MouseClick("left", 400, 285, 1)
			Sleep(1000)
			MouseClick("left", 400, 315, 1)
			Sleep(1000)
			exitRoom()
			Return True
		Else
			Send("{B}")
			Sleep(100)
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>roleisdead

Func checkbagRev()
	TrayTip("", "�������˲��ظ�ҩˮ", 1, 16)
	;Sleep(100)
	Send("{" & $char_Bag & "}")
	Sleep(300)
	;addrevtobag()
	drinksurplusrev()
	Send("{B}")
	Sleep(100)
	;If 1 = 1 Then
	;	Return True
	;Else
	;	Return False
	;EndIf
EndFunc   ;==>checkbagRev

Func drinksurplusrev() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ�
;~ 	For $i = 1 To 1 Step 1
;~ 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
;~ 		If Not @error Then
;~ 			checkzise("0x682070")
;~ 			;MouseClick("right", $coord[0], $coord[1], 1);
;~ 			;Sleep(200)
;~ 		EndIf
;~ 	Next
	MouseMove(390 + Random(1, 20, 1), 300 + Random(1, 80, 1))
	For $i = 1 To 20 Step 1 ;����ͼ�ķ�ʽ������׼
		$coord = findRevInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
		EndIf
	Next
	
	;�ȵ�����죬������
	For $i = 1 To 20 Step 1 ;����ͼ�ķ�ʽ������׼
		$coord = findHealInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
		EndIf
	Next
	
	For $i = 1 To 20 Step 1 ;����ͼ�ķ�ʽ������׼
		$coord = findManaInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
		EndIf
	Next

EndFunc   ;==>drinksurplusrev

Func drinksurplusInbag($color) ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ�
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, $color, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			checkzise($color)
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusInbag


Func tradewater($water)
	;If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
	If findPointColor(500, 440, "4C4C4C") = True Then
		TrayTip("", "�����Ʒ.", 1, 16)
		Sleep(1000)
		;MouseMove(400,300)
		;Sleep(100)
		;�ڰ��ǵĽ��״�����
		If $water = 1 Then ;��
			$coord = findHealInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "�ҵ���ҩˮ.", 1, 16)
				Sleep(1000)
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0] + 2, $coord[1] + 5, 1);
				Sleep(500)
				Send("{LSHIFT up}")
				Sleep(300)
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
				For $i = 0 To 2 Step 1
					Send("{LSHIFT}")
				Next
			Else
				TrayTip("", "û���ҵ���ҩˮ.", 1, 16)
				Sleep(1000)
			EndIf

		Else
			$coord = findManaInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "��ҩˮ.", 1, 16)
				Sleep(1000)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0] + 2, $coord[1] + 5, 1);
				Sleep(500)
				Send("{LSHIFT up}")
				Sleep(300)
				MouseMove(400, 300)
				Sleep(10)
				For $i = 0 To 2 Step 1
					Send("{LSHIFT}")
				Next
				;MouseClick("right", Default, Default, 1)
			Else
				TrayTip("", "û���ҵ���ɫҩˮ.", 1, 16)
				Sleep(2000)
			EndIf
		EndIf
		#CS 		Send("{ESC}")
			Sleep(600)
		#CE
	EndIf
EndFunc   ;==>tradewater

Func findbeltWater($cat, $color)
	$needshop = 0 ;����֪����Ҫshop�ı�־
	$belt1 = 0
	$belt2 = 0
	$belt3 = 0
	$belt4 = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    ��һ���촰
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; ��2���촰��
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; ��3���촰��
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; ��4���촰��
		Select
			Case $i = 1
				If findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt1 = 1
				EndIf
			Case $i = 2
				If findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt2 = 1
				EndIf
			Case $i = 3
				If findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt3 = 1
				EndIf
			Case $i = 4
				If findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt4 = 1
				EndIf
		EndSelect
	Next
	
	If $cat = "heal" Then
		If $belt1 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "1����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				MouseClick("right", $xbeltarray[0][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		If $belt2 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "2����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				MouseClick("right", $xbeltarray[1][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		
		
	ElseIf $cat = "mana" Then
		
		If $belt3 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "3����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[2][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		If $belt4 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "4����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[3][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
	EndIf
	
	If $needshop = 1 Then
		Return 0
	Else
		Return 1
	EndIf



EndFunc   ;==>findbeltWater



Func addrevtobag() ;��������������󸴻�������,��������ϵ�Ѫƿ�ŵ���Ʒ����ȥ
	Send("{LSHIFT down}")
	Sleep(10)
	For $i = 1 To 10 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			Sleep(10)
			MouseClick("left", $coord[0], $coord[1], 1);
			Sleep(200)
		EndIf
	Next
	Send("{LSHIFT up}")
	Sleep(10)
	For $i = 0 To 2 Step 1
		Send("{LSHIFT}")
		Sleep(100)
	Next
EndFunc   ;==>addrevtobag

Func afterReady() ;���ź��׼������װ�令�ף�CTA ��
	;Sleep(Random(800, 1000, 1))
	Sleep(Random(300, 500, 1) + $parm_speeddelay)
	$armrnd = Random(1, 10, 1) ;�����漴���ɷţ����߲���װ�׼���
	$armrnd = 1
	If $armrnd = 1 Then
		MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
		armShied()
	EndIf
	
	#CS 		;WIN DRU
		MouseMove(500 , 250)
		Sleep(50)
		Send("{F5}")
		Sleep(50)
		MouseClick("right", Default, Default, 1)
		Sleep(400)
		Send("{F2}")
		MouseClick("right", Default, Default, 2)
		Sleep(400)
		;------
	#CE
	
	;Sleep(1000) ;��������
EndFunc   ;==>afterReady

Func armShied() ;װ�����׼���
	If $fire = 1 Then
		Send("{" & $char_armFire & "}")
		Sleep(50)
		MouseClick("right", Default, Default, Random(1, 5))
		Sleep(Random(200, 400, 1))
	ElseIf $fire = 2 Then

	EndIf
EndFunc   ;==>armShied

Func gotoBox()
	
	If $parm_path = 5 Then
		
		If $dingZhiFlag = "109" Then
			cnbnpath() ; 109 ��ȥbox·��
		Else
			anhei3() ; 113
			$i = 1
			While $i <= 1 ;;ѭ��һ�£�����������
;~ 		If $i = 2 Then ;��2�������˺����ٵ�
;~ 			MouseClick('left', 410, 310)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		EndIf
				$coord = findtudui1() ;�ҵ���ݵ�λ��
				;ConsoleWrite(TimerDiff($t1) & @CRLF)
				If $coord[0] >= 0 And $coord[1] >= 0 Then
					;MouseMove($coord[0] +150, $coord[1] +30);
					MouseClick('left', $coord[0] + 150, $coord[1] + 30)
					Sleep(1500)
					CheckMove($Char_CheckMoveDelay)
				EndIf
				$i = $i + 1
			WEnd
			MouseClick('left', 400, 260) ;�����Ϸ����߷����Һ���
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
		EndIf
		
		$coord = finda3box()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0], $coord[1] + 20)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(1200)
		Else
			TrayTip("", "109������ʧ��", 9, 16)
			Sleep(1000)
			Return False;
		EndIf
		
		
		
	Else
;~ 		;�����·��
;~ 		a5down1();
;~ 		Sleep(2000)
;~ 		$coord = finda3box()
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			MouseMove($coord[0], $coord[1]);
;~ 			MouseClick('left', $coord[0], $coord[1] + 20)
;~ 			;CheckMove($Char_CheckMoveDelay)
;~ 			Sleep(3000)
;~ 		Else
;~ 			TrayTip("", "111������ʧ�ܣ����Լ������", 9, 16)
;~ 			Sleep(1000)
;~ 			Return False;
;~ 		EndIf
		;ԭ·��
		Sleep(100)
		MouseMove(200, 500)
		Sleep(1000)
		MouseClick("left", 200, 500, 1)
		Sleep(1600)
		MouseMove(750, 430)
		Sleep(1000)
		MouseClick("left", 750, 430, 1)
		Sleep(1600)
		MouseMove(380, 480)
		Sleep(1000)
		MouseClick("left", 380, 480, 1)
		Sleep(1400)
		MouseMove(150, 240)
		Sleep(100)
		MouseClick("left", 150, 240, 1)
		Sleep(1800)
	EndIf
	
EndFunc   ;==>gotoBox

Func getRam()

	;_GUICtrlStatusBar_SetText($StatusBar1, "KP������" & $round & " ����ӳ�: " & $tfcount, 1)
	$ranKp = Random(-4, 4, 1)
	;$ranKp = 0
	If $tfcount >= $parm_kprounctime + $ranKp Then ; �л��˺ź� ѭ������Ҳ���ڹ涨��
		;��ʱ���Թر���Ϸ,��ѭ������һ���˺�����½
		TrayTip("", "��ʼ����¼�����.", 1, 16)
		Sleep(1000)
		;���¾�������������¼��ˣ�������ʱ������ȥact4
		Select
			Case $tfcount >= 0
				$waitmethord = Random(1, 2, 1) ;�����1��������Ϸ�����ڵȣ������2�����˳�����ȴ�
				If $waitmethord = 1 Then ;
					;MouseClick("left", 400 - Random(30, 400, 1), 300 + Random(10, 50, 1))
					Sleep(Random(200, 1000, 1))
					writelog("���---�� " & $round & " ��: " & "�����ͣ:" & $parm_rantime & "��")
					For $ab = $parm_rantime To 0 Step -1
						TrayTip("", "�һ���ͣʣ�������:" & $ab, 1, 16)
						Sleep(1000)
						If $parm_settime = 1 Then ;check if set tiem to shutdown
							tiemtoshut($parm_timedata)
						EndIf
					Next
					exitRoom() ;�˳���Ϸ����������
					Sleep(1000)
				Else
					exitRoom() ;�˳���Ϸ����������
					Sleep(Random(200, 1000, 1))
					writelog("���---�� " & $round & " ��: " & "�����ͣ:" & $parm_rantime & "��")
					For $ab = $parm_rantime To 0 Step -1
						TrayTip("", "�һ���ͣʣ�������:" & $ab, 1, 16)
						Sleep(1000)
						If $parm_settime = 1 Then ;check if set tiem to shutdown
							tiemtoshut($parm_timedata)
						EndIf
					Next
					Sleep(1000)
				EndIf
				
			Case Else

		EndSelect
		$tfcount = 0 ; ����Ϊ0
	EndIf

	
	
EndFunc   ;==>getRam

Func ramclose()
	;_GUICtrlStatusBar_SetText($StatusBar1, "KP������" & $round & " ����ӳ�: " & $tfclosecount, 1)
	$ranKp = Random(-4, 4, 1)
	;$ranKp = 0
	If $tfclosecount >= $parm_closetime + $ranKp Then ; �л��˺ź� ѭ������Ҳ���ڹ涨��
		;��ʱ���Թر���Ϸ,��ѭ������һ���˺�����½
		closeAndWait(0)
	EndIf
	
	If $tfclosecount >= 300 Then ; �������250�ֶ������ߣ�ϵͳǿ�и�������
		;��ʱ���Թر���Ϸ,��ѭ������һ���˺�����½
		closeAndWait(1)
	EndIf
	
	
EndFunc   ;==>ramclose

Func closeError() ;�رյ�hackmap �ı���
	$errortitle = "Diablo II Fatal Error"
	$errorhandle = WinGetHandle($errortitle)
	If Not @error Then
		writelog("��ͼ����---���Թر�hackmap")
		TrayTip("", "����hackmap Error�����Թرա�", 1, 16)
		Sleep(500)
		WinActivate($errortitle)
		Send("{ENTER}")
		Sleep(500)
		Send("{ENTER}")
		Sleep(2000)
		WinKill($errortitle)
		Sleep(3000)
	EndIf
	
	$errortitle = "Hey guys"
	$errorhandle = WinGetHandle($errortitle)
	If Not @error Then
		writelog("��ͼ����---���Թر�hackmap")
		TrayTip("", "����hackmap Error�����Թرա�", 1, 16)
		Sleep(500)
		WinActivate($errortitle)
		Send("{ENTER}")
		Sleep(500)
		Send("{ENTER}")
		Sleep(2000)
		WinKill($errortitle)
		Sleep(3000)
	EndIf
	
	
EndFunc   ;==>closeError

Func closeAndWait($force) ;force Ϊ 0 1 2   0 -�û�����ʱ�� 1- һ��ǿ��ʱ��  2- �ϸ�ǿ��ʱ��
	;��force ���������tfclosecount ����200�ζ������ߣ����Դ˴�ǿ������
	If $force = 0 Then
		$gamclosestoptime = $parm_closestoptime
	Else
		$gamclosestoptime = Random(35, 45, 1)
	EndIf
	
	writelog("���---�� " & $round & " ��: �ر���Ϸ�ʺ�����:" & $gamclosestoptime & "��")
	TrayTip("", "�ر���Ϸ�ʺ����ߣ�����ͣ����������" & $gamclosestoptime, 1, 16)
	WinClose($title)
	Sleep(1000)
	WinClose($title)

	$ct = 1 ; �ѷ���������Ҳ����
	$tfclosecount = 0 ; ����Ϊ0
	;_GUICtrlStatusBar_SetText($StatusBar1, "�ʺ�������ͣ��...", 1)
	$gamclosestoptime = $gamclosestoptime + Random(1, 5, 1) ;�������ֵ
	$sleeptime = $gamclosestoptime * 60
	For $aa = $sleeptime To 0 Step -1
		TrayTip("", "�һ�������ͣʣ�������:" & Round($aa / 60, 1), 1, 16)
		Sleep(1000)
		If $parm_settime = 1 Then ;check if set tiem to shutdown
			tiemtoshut($parm_timedata)
		EndIf
	Next
	
	TrayTip("", "��ͣʱ���ѹ� ,��ʼ�����һ�", 1, 16)
EndFunc   ;==>closeAndWait

Func checkotherin()
	TrayTip("", "����Ƿ������˽���", 1, 16)
	Sleep(10)
	MouseMove(400 + Random(1, 5, 1), 300 + Random(1, 5, 1))
	Sleep(50)
	Send("{" & $char_Team & "}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		;Send("{" & $char_Team & "}") ;�رն������
		If $b <> 3299051709 Then ;��ʾ�б䶯��,�����������˽��뷿����
			If $parm_otherimage = 1 Then
				_ScreenCapture_CaptureWnd(@ScriptDir & "\" & $parm_kpcount & "other.jpg", $handle) ;�ȱ�����ͼƬ
			EndIf
			
			Send("{" & $char_Team & "}") ;�رն������
			If $parm_otherroundtrace = 1 Then ;�Ƿ����ù涨�����Զ����߹���
				If $round + 1 - $other_traced_round <= $parm_otheroundinterval Then ;�������10�����ھ������α�׷�٣���ʾ�е�Σ���ˣ�
					writelog("�����˽�����---�ڵ�" & $round + 1 & "�ֽ��뷿�䣬������֮��2�ν��룬ֹͣ�һ���")
					exitRoom()
					Sleep(Random(200, 1000, 1))
					Exit 0
				EndIf
			EndIf
			
			$other_traced_round = $round + 1 ;�ѵ�ǰ������¼���� ,��Ϊ round ��һ��Ϊ 0
			writelog("�����˽�����---�ڵ�" & $other_traced_round & "�ֽ��뷿��")
			_GUICtrlStatusBar_SetText($StatusBar1, "ע����İ�����ڵ� " & $other_traced_round & "  �ֽ�����ķ��� ", 0)
			
			Select
				Case $parm_othermethord = 1
					exitRoom()
					Sleep(Random(200, 1000, 1))
					$sleeptime = $parm_rantime * 1000
					TrayTip("", "�����ͣ:" & $parm_rantime & "��", 1, 16)
					Sleep($sleeptime)
				Case $parm_othermethord = 2
					exitRoom()
					Sleep(100)
					closeAndWait(0)
				Case Else
					;����������
			EndSelect
			Return True
		Else
			Send("{" & $char_Team & "}") ;�رն������
			TrayTip("", "û��������", 1, 16)
			;û�ҵ�������
			Return False
		EndIf
	Else
		TrayTip("", "û�ж���", 1, 16)
		;����P�󣬷���Ҳû���ҵ�������棬����Ե�
		Send("{" & $char_Team & "}")
		Return False
	EndIf
	
EndFunc   ;==>checkotherin

Func checkOpenStat() ;����Ƿ���������Ի������������Ӷ������
	;��Χ�߿���һ����
	If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 300, "040404") = True And findPointColor(200, 500, "1C1C1C") = True Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>checkOpenStat

Func _shortdelaysec()
	Dim $randshort
	Select
		Case $short1 >= 4
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(2, 3, 1)
			If $randshort = 2 Then
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			Else
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
		Case $short2 >= 3
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(1, 4, 1)
			If $randshort <> 4 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			Else
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
		Case $short3 >= 3
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(1, 4, 1)
			If $randshort <> 4 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			Else
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			EndIf
		Case Else
			
			$randshort = Random(1, 5, 1)
			If $randshort <> 2 And $randshort <> 3 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			ElseIf $randshort = 2 Then
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			ElseIf $randshort = 3 Then
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
			
			Return $autshortdelaysec
	EndSelect
EndFunc   ;==>_shortdelaysec


Func clikcTradeMaraInAct5()
	
	MouseClick("left", 120 + Random(1, 10, 1), 290 + Random(1, 10, 1))
	Sleep(2000)
	
;~ 	$monsterColor1 = "0xA420FC" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC
;~ 	$monsterColor1_hex = "A420FC"
;~ 	$tp_Pix = countFirepointRec(10, 10, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
;~ 	If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 		;TrayTip("", "1�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
;~ 		MouseClick("left", $tp_Pix[0], $tp_Pix[1], 1, 0)
;~ 		Sleep(3000)
;~ 		CheckMove($Char_CheckMoveDelay)
;~ 	Else
;~ 		exitRoom()
;~ 	EndIf
	
	$monsterColor1 = "0xA420FC" ;��ɫ���� 0x18FC00        ����ɫ 0xA420FC
	$monsterColor1_hex = "A420FC"
	$findflag = 0
	$begin1 = TimerInit()
	Do
		$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
		If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
			;TrayTip("", "1�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
			MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
			Sleep(3000)
			CheckMove($Char_CheckMoveDelay)
			
			$coord = PixelSearch(100, 30, 500, 300, 0x1CC40C, 30, 1, $title) ; ��
			If Not @error Then
				TrayTip("", "������ף�", 1, 16)
				;MouseClick("right", $coord[0], $coord[1], 1);
				MouseMove($coord[0] + Random(10, 20), $coord[1] + Random(5, 7))
				Sleep(1000)
				MouseClick("left", Default, Default, 1)
				Sleep(200)
				$findflag = 1
			Else ;���ܴ����ҵ���ɫ������û����ȥ�����ߵ����ˣ�û�ҵ���ɫ�����
				TrayTip("", "���ʧ�ܣ�", 1, 16)
				Sleep(2000)
				MouseClick("left", 400, 300, Default, Random(1, 3, 1))
				Sleep(200)
			EndIf
			
		EndIf
		;$i = $ + 1
		$dif = TimerDiff($begin1)
	Until $findflag = 1 Or $dif >= 40000
	CheckMove($Char_CheckMoveDelay)

;~ 	;����������ɫ
;~ 	$coord = PixelSearch(10, 10, 380, 450, 0xA420FC, 30, 1, $title) ;   --��npc��ɫ
;~ 	If Not @error Then
;~ 		MouseClick("left", $coord[0] + 10, $coord[1] + 10)
;~ 		Sleep(3000)
;~ 		CheckMove($Char_CheckMoveDelay)
;~ 	Else
;~ 		TrayTip("", "����������.", 1, 16)
;~ 		MouseClick("left", 300, 250)
;~ 		Sleep(2000) ;����npc���ƶ����ȵȵ�
;~ 		$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 		If Not @error Then
;~ 			MouseClick("left", $coord[0] + Random(30, 50), $coord[1] + 10)
;~ 			Sleep(3000)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		Else
;~ 			exitRoom();
;~ 		EndIf
;~ 	EndIf
	
	
	
;~ 	$coord = PixelSearch(100, 50, 400, 300, 0x1CC40C, 30, 1, $title) ; ��
;~ 	If Not @error Then
;~ 		TrayTip("", "������ף�", 1, 16)
;~ 		;MouseClick("right", $coord[0], $coord[1], 1);
;~ 		MouseMove($coord[0] + Random(10, 20), $coord[1] + Random(1, 5))
;~ 		Sleep(200)
;~ 		MouseClick("left", Default, Default, 1)
;~ 		TrayTip("", "�򿪽��׽��棡", 1, 16)
;~ 		Sleep(200)
;~ 	EndIf
	
EndFunc   ;==>clikcTradeMaraInAct5


;---------------------������ж�Ѫ��������pet��
Local $lifeStatus ;1.����Ѫ��  0 ȱ�� ��1 ����
Local $manaStatus ;2.���﷨��: 0 ȱ�� ��1 ����
Local $petStatus ;3.��Ӷ��Ѫ�� 0 ���� ��1 ��Ѫ ��2 ����
Local $lifeBottle ;4.��ҩ���  0 ��    1 ��
Local $manaBottle ;5.��ҩ���  0 ��    1 ��
Local $purpleBottle ;6.��ҩ���   0 ��    1 ��
Local $noOtherComeIn ;7.���˽�����   0 ���˽�    1 ��
Local $noOtherWhisper ;  8�Ƿ�����m��  0 ����mi  1 ����m

Func child1()
	Local $parm[6]
	Local $needResumePetFlag = 0 ; ��Ҫ����pet�ı�־λ
	Local $needByRedBottle = 0 ; ��Ҫ���ҩ�ı��λ
	Local $needByManaBottle = 0 ; ��Ҫ���ҩ�ı��λ

	$drink_pet_ct = 0 ;Ĭ�ϺȺ�ҩ�Ĵ��� ����ʼΪ 0 ��û��һ�Σ���1�� ͬ��ʱ��Ҳ�Ǽ�3��
	$drink_heal_ct = 0
	$drink_mana_ct = 0
	$i = 0
	While ProcessExists($gi_CoProcParent)
		$i = $i + 1
		$petStatus = CheckpetStatus() ;---�ȼ���Ӷ��������Ӷ�����ˣ��򸴻�
		_CoProcSend($gi_CoProcParent, "petStatus|" & $petStatus)
		If isInRoom() = True And isInTown() = False And $petStatus = 0 And $needResumePetFlag = 0 Then ;վ���ڲ��˳�
			writelog("��Ӷ�� - ��⵽��Ҫ�����Ӷ��")
			exitRoomWithMap()
			;exitRoom()
			$needResumePetFlag = 1
			ContinueLoop
			;writelog($petStatus & "-" & $i & "-" & $needResumePetFlag)
		EndIf
		If $petStatus = 1 Or $petStatus = 2 Then ;������ɹ���,
			$needResumePetFlag = 0
		EndIf
		If $petStatus = 1 Then ;��Ӷ����Ѫ��Ҫ��Ѫ�����
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;����ҩˮ������ͼ���ҩˮ
				Send("{LSHIFT down}")
				Sleep(50)
				drinkWaterNew("0x682070")
				Sleep(50)
				Send("{LSHIFT up}")
				Send("{LSHIFT}")
				Sleep(50)
				Send("{LSHIFT}")

			Else ;û��ҩˮ�Ļ���ȥ�Һ�ҩˮ
				
				$lifeBottle = ChecklifeBottle()
				If $lifeBottle = 1 Then
					If $drink_pet_ct = 0 Then ;��һ�κȺ�ҩˮ
						$begindrinkpetTime = TimerInit()
						Send("{LSHIFT down}")
						Sleep(50)
						drinkWaterNew("0x943030")
						Sleep(50)
						Send("{LSHIFT up}")
						Send("{LSHIFT}")
						Sleep(50)
						Send("{LSHIFT}")
						$drink_pet_ct = $drink_pet_ct + 1
					Else ;�����ǵڶ��λ����Ϻ�
						$difpet = TimerDiff($begindrinkpetTime)
						If $difpet >= 4000 Then
							Send("{LSHIFT down}")
							Sleep(50)
							drinkWaterNew("0x943030")
							Sleep(50)
							Send("{LSHIFT up}")
							Send("{LSHIFT}")
							Sleep(50)
							Send("{LSHIFT}")
							$drink_pet_ct = $drink_pet_ct + 1
							$begindrinkpetTime = TimerInit() ;����ʱ��
						EndIf
					EndIf
				Else ;û�к�ҩ������ѡ���˳��������¾ֿ�ʼ��ʱ�����ҩ
					If isInRoom() And $needByRedBottle = 0 And $ckred = 1 Then
						writelog("��ҩ----��Ҫ���ҩ")
						exitRoom()
						$needByRedBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;�������Ҫ��Ѫ����Ҫ����Ѫ�Ĵ�����Ϊ0
			$drink_pet_ct = 0
		EndIf
		
		
		$lifeStatus = ChecklifeStatus() ;	���Ѫ��
		_CoProcSend($gi_CoProcParent, "lifeStatus|" & $lifeStatus)
		If $lifeStatus = 0 Then ;��Ҫ��Ѫ������ע��Ӻ�ҩˮ��Ҫ��ʱ����
			;1���ȼ���ҩˮ
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;����ҩˮ������ͼ���ҩˮ
				drinkWaterNew("0x682070")
				Sleep(10)
			Else ;û��ҩˮ�Ļ���ȥ�Һ�ҩˮ
				$lifeBottle = ChecklifeBottle()
				If $lifeBottle = 1 Then
					If $drink_heal_ct = 0 Then ;��һ�κȺ�ҩˮ
						$begindrinkhealTime = TimerInit()
						drinkWaterNew("0x943030")
						$drink_heal_ct = $drink_heal_ct + 1
					Else ;�����ǵڶ��λ����Ϻ�
						$difheal = TimerDiff($begindrinkhealTime)
						If $difheal >= 4000 Then
							drinkWaterNew("0x943030")
							$drink_heal_ct = $drink_heal_ct + 1
							$begindrinkhealTime = TimerInit() ;����ʱ��
						EndIf
					EndIf
				Else ;û�к�ҩ������ѡ���˳��������¾ֿ�ʼ��ʱ�����ҩ
					If isInRoom() And $needByRedBottle = 0 And $ckred = 1 Then
						writelog("��ҩ----��Ҫ���ҩ")
						exitRoom()
						$needByRedBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;�������Ҫ�Ⱥ죬�Ͱѱ��Ϊ��Ϊ 0
			$drink_heal_ct = 0
		EndIf
		
		
		$manaStatus = CheckmanaStatus()
		_CoProcSend($gi_CoProcParent, "manaStatus|" & $manaStatus)
		If $manaStatus = 0 Then ;��Ҫ����������ע�����ҩˮ��Ҫ��ʱ����
			;1���ȼ���ҩˮ
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;����ҩˮ������ͼ���ҩˮ
				drinkWaterNew("0x682070")
				Sleep(10)
			Else ;û��ҩˮ�Ļ���ȥ����ҩˮ
				$manaBottle = CheckmanaBottle()
				If $manaBottle = 1 Then ;����ҩ�������ҩ,����ҩ�ָ�ʱ�仺������Ҫ���һ��ʱ���
					If $drink_mana_ct = 0 Then ;��һ�κȺ�ҩˮ
						$beginmanaTime = TimerInit()
						drinkWaterNew("0x1828A4")
						$drink_mana_ct = $drink_mana_ct + 1
					Else ;�����ǵڶ��λ����Ϻ�
						$difmana = TimerDiff($beginmanaTime)
						If $difmana >= 4000 Then
							drinkWaterNew("0x1828A4")
							$drink_mana_ct = $drink_mana_ct + 1
							$beginmanaTime = TimerInit() ;����ʱ��
						EndIf
					EndIf
				Else ;û����ҩ������ѡ���˳��������¾ֿ�ʼ��ʱ������ҩ
					If isInRoom() And $needByManaBottle = 0 And $ckblue = 1 Then
						writelog("��ҩ----��Ҫ����ҩ")
						exitRoom()
						$needByManaBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;�������Ҫ�Ⱥ죬�Ͱѱ��Ϊ��Ϊ 0
			$drink_mana_ct = 0
		EndIf
		
		

		$lifeBottle = ChecklifeBottle()
		_CoProcSend($gi_CoProcParent, "lifeBottle|" & $lifeBottle)
		
		$manaBottle = CheckmanaBottle()
		_CoProcSend($gi_CoProcParent, "manaBottle|" & $manaBottle)
		
		$purpleBottle = CheckpurpleBottle()
		_CoProcSend($gi_CoProcParent, "purpleBottle|" & $purpleBottle)
		
		$noOtherComeIn = ChecknoOtherComeIn()
		If $noOtherComeIn = 0 And $guiothercheck = 1 Then
			exitRoomWithMap()
		EndIf
		_CoProcSend($gi_CoProcParent, "noOtherComeIn|" & $noOtherComeIn)
		
		$noOtherWhisper = ChecknoOtherWhisper()
		_CoProcSend($gi_CoProcParent, "noOtherWhisper|" & $noOtherWhisper)
		
		Sleep(50)
	WEnd

EndFunc   ;==>child1

Func CheckpetStatus()
	;����Ӷ��
	If isInRoom() = False Then
		Return 3
	Else
;~ 		If isInRoom() And checkOpenStat() = False And findPointColor(18, 17, "F0041C") = False And findPointColor(18, 17, "D08420") = False And findPointColor(18, 17, "008400") = False Then
;~ 			;��  F0041C���� D08420 ���� 008400 ��  sum �Ǹ��Ǵ򿪹�Ӷ�����ڵĻ���
;~ 			If findAreaColor(10, 5, 52, 20, 0xF0041C, 30, 2, $title) = False And findAreaColor(10, 5, 52, 20, 0xDD0D20, 30, 2, $title) = False Then
;~ 				;writelog("��Ӷ��----��Ӷ����������⣬�ƺ�����")
;~ 				Return 0
;~ 			Else;�����һ������Ѫ���ֻ��У���ʾ����һ˿Ѫ
;~ 				Return 1
;~ 			EndIf
;~
;~ 		Else
;~ 			If isInRoom() And checkOpenStat() = False And findPointColor(40, 17, "008400") = False Then
;~ 				Return 1
;~ 			Else
;~ 				Return 2
;~ 			EndIf
;~ 		EndIf
		
		If isInRoom() And checkOpenStat() = True Then ;����ڷ����ڣ��Ҵ��˱���ת�ƣ���Ӷ���Ȼ���
			Return 3
		Else ;
			If isInRoom() And findPointColor(18, 17, "008400") = True Then ;�������ɫ�����������ģ����Բ��ü�Ѫ
				Return 2 ; ��ʾ����
			Else ;������ɫ���ж��ǲ��ǻ�ɫ
				If isInRoom() And findPointColor(18, 17, "D08420") = True Then
					Return 1
				Else ;������ǻ�ɫ�����ǲ��Ǻ�ɫ
					If isInRoom() And findPointColor(18, 17, "F0041C") = True Then
						Return 1
					Else ;�����ɫҲ�Ҳ��������ܴ���һ˿Ѫ����Ϊ��Χȡɫ����
						
						;��  F0041C���� D08420 ���� 008400 ��  sum �Ǹ��Ǵ򿪹�Ӷ�����ڵĻ���
						If isInRoom() And findAreaColor(10, 5, 52, 20, 0xF0041C, 30, 1, $title) = False And findAreaColor(10, 5, 52, 20, 0x231B9D, 30, 2, $title) = False Then
							;writelog("��Ӷ��----��Ӷ����������⣬�ƺ�����")
							Return 0
						Else;�����һ������Ѫ���ֻ��У���ʾ����һ˿Ѫ
							Return 3
						EndIf
					EndIf
				EndIf
				
			EndIf
		EndIf
		
	EndIf
	
	
	
	
EndFunc   ;==>CheckpetStatus

Func ChecklifeStatus()
	;�������
	If isInRoom() And findPointColor(70, 530, "5C0000") = False And findPointColor(70, 530, "18480C") = False Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>ChecklifeStatus

Func CheckmanaStatus()
	;��鷨��
	If isInRoom() And findPointColor(705, 570, "040404") = False Then ; 735, 580, "0C0C28"
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>CheckmanaStatus

Func ChecklifeBottle()
;~ 	;��������ҩˮ
;~ 	$haveRed = 0
;~ 	$colorRed = "0x943030"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $haveRed = 0 Then ;���û�ҵ��κκ�ҩˮ
;~ 		Return 0 ;û��ҩ
;~ 	Else
;~ 		Return 1 ;�к�ҩ
;~ 	EndIf
	
	;�ڶ��ַ�ʽ��ֱ������������
	$coord1 = PixelSearch(420, 565, 540, 590, 0x943030, 25, 1, $title) ;��ɫ
	If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
		Return 1 ;�к�ҩ
	Else
		Return 0 ;û��ҩ
	EndIf
	
EndFunc   ;==>ChecklifeBottle

Func CheckmanaBottle()
;~ 	;��������ҩˮ
;~ 	$haveBlue = 0
;~ 	$colorBlue = "0x1828A4"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $haveBlue = 0 Then ;
;~ 		Return 0 ;û��ɫ����ҩˮ
;~ 	Else
;~ 		Return 1 ;����ɫ����ҩˮ
;~ 	EndIf
	$coord1 = PixelSearch(420, 565, 540, 590, 0x1828A4, 25, 1, $title) ;��ɫ
	If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
		Return 1 ;����ɫ����ҩˮ
	Else
		Return 0 ;û��ɫ����ҩˮ
	EndIf


	
	
EndFunc   ;==>CheckmanaBottle

Func CheckpurpleBottle()
;~ 	;��������ɫҩˮ
;~ 	$havePurple = 0 ; $purpleBottle
;~ 	$colorPurple = "0x682070"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $havePurple = 0 Then ;���һ����ظ�ҩˮ��û�ҵ��������ˡ����ҵ�һ��������hackmap����ΪѪ����
;~ 		Return 0 ;û��ɫҩˮ
;~ 	Else
;~ 		Return 1 ;����ɫҩˮ
;~ 	EndIf
	
	$coord1 = PixelSearch(420, 565, 540, 590, 0x682070, 25, 1, $title) ;��ɫ
	If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
		Return 1 ;����ɫҩˮ
	Else
		Return 0 ;û��ɫҩˮ

	EndIf

EndFunc   ;==>CheckpurpleBottle

Func ChecknoOtherComeIn()
	;����Ƿ����˽�����
;~ 	$firstOther = 1
;~ 	$secondOther = 1
;~ 	$noOthercolor1 = "0xCE8523"
;~ 	$noOthercolor2 = "0x1CC40C"
;~ 	$noOthercolor21 = "0x14FD01"
;~
;~ 	If isInRoom() And findAreaColor(20, 10, 35, 105, $noOthercolor1, 25, 1, $title) And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 		$firstOther = 0
;~ 	Else
;~ 		$firstOther = 1
;~ 	EndIf
;~ 	If isInRoom() And findAreaColor(60, 10, 85, 105, $noOthercolor2, 25, 1, $title) And findAreaColor(60, 10, 85, 105, $noOthercolor1, 25, 1, $title) = False And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 		$secondOther = 0
;~ 	Else
;~ 		If isInRoom() And findAreaColor(60, 10, 85, 105, $noOthercolor21, 25, 1, $title) And findAreaColor(60, 10, 85, 105, $noOthercolor1, 25, 1, $title) = False And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 			$secondOther = 0
;~ 		Else
;~ 			$secondOther = 1
;~ 		EndIf
;~ 	EndIf
;~ 	If $firstOther = 0 And $secondOther = 0 Then ;�������������������˽�
;~ 		writelog("�����˽�����---�����⣡")
;~ 		Return 0
;~ 	Else
;~ 		Return 1
;~ 	EndIf

	;0x010101  ;��ɫ
	$cheng = "0xCE8523" ;��ɫ
	$lan = "0x4E4FAD" ;��ɫ
	$bai = "0xC4C4C4" ;��ɫ
	; 20 -  ,54  ,93
	; 30- 40
	; 60 - 70
	; 100 -110
	$coord = PixelSearch(20, 10, 150, 150, $cheng, 25, 1, $title)
	If Not @error Then;�ҵ���ɫ��������ͬһˮƽ��������������ɫû
		;ConsoleWrite("  " & $coord[0] & @CRLF)
		$coord1 = PixelSearch(60, $coord[1] - 2, 70, $coord[1] + 10, $lan, 25, 2, $title)
		If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
			;ConsoleWrite("  " & $coord1[0] & @CRLF)
			$coord2 = PixelSearch(100, $coord1[1] - 2, 110, $coord1[1] + 10, $bai, 20, 2, $title)
			If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
				;ConsoleWrite("  " & $coord2[0] & @CRLF)
				writelog("�����˽�����---�����⣡")
				Return 0;
			EndIf
			;ConsoleWrite( "  "& $coord[0]& @CRLF)
		EndIf
	EndIf
	Return 1;
EndFunc   ;==>ChecknoOtherComeIn

Func ChecknoOtherWhisper()
	;����Ƿ���������m��
;~ 	$firstWhisper = 1
;~ 	$secondWhisper = 1
;~ 	$Whispercolor1 = "0x1CC40C" ;0x1CC40C  0x14FD01
;~ 	$Whispercolor11 = "0x14FD01"
;~ 	$Whispercolor2 = "0xCE8523"
;~
;~ 	If isInRoom() And checkOpenStat() = False And findAreaColor(20, 10, 35, 105, $Whispercolor1, 25, 1, $title) And findAreaColor(20, 10, 35, 105, $Whispercolor2, 25, 1, $title) = False Then
;~ 		$firstWhisper = 0
;~ 	Else
;~ 		If isInRoom() And checkOpenStat() = False And findAreaColor(20, 10, 35, 105, $Whispercolor11, 25, 1, $title) And findAreaColor(20, 10, 35, 105, $Whispercolor2, 25, 1, $title) = False Then
;~ 			$firstWhisper = 0
;~ 		Else
;~ 			$firstWhisper = 1
;~ 		EndIf
;~ 	EndIf
;~ 	If isInRoom() And checkOpenStat() = False And findAreaColor(60, 10, 85, 105, $Whispercolor2, 25, 1, $title) Then
;~ 		$secondWhisper = 0
;~ 	Else
;~ 		$secondWhisper = 1
;~ 	EndIf
;~
;~ 	If $firstWhisper = 0 And $secondWhisper = 0 Then ;�������������������˽�
;~ 		writelog("����m��---�����⣡")
;~ 		Return 0
;~ 	Else
;~ 		Return 1
;~ 	EndIf

	;0x010101  ;��ɫ
	$cheng = "0xCE8523" ;��ɫ
	$lan = "0x4E4FAD" ;��ɫ
	$bai = "0xC4C4C4" ;��ɫ
	; 20 -  ,54  ,93
	; 30- 40
	; 60 - 70
	; 100 -110
	$coord = PixelSearch(20, 10, 150, 150, $lan, 25, 1, $title)
	If Not @error Then;�ҵ���ɫ��������ͬһˮƽ��������������ɫû
		;ConsoleWrite("  " & $coord[0] & @CRLF)
		$coord1 = PixelSearch(60, $coord[1] - 2, 70, $coord[1] + 10, $cheng, 25, 2, $title)
		If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
			;ConsoleWrite("  " & $coord1[0] & @CRLF)
			$coord2 = PixelSearch(100, $coord1[1] - 2, 110, $coord1[1] + 10, $bai, 20, 2, $title)
			If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
				;ConsoleWrite("  " & $coord2[0] & @CRLF)
				writelog("����m��---�����⣡")
				Return 0;
			EndIf
			;ConsoleWrite( "  "& $coord[0]& @CRLF)
		EndIf
	EndIf
	Return 1;

EndFunc   ;==>ChecknoOtherWhisper





Func Reciver($vParameter)
	;TrayTip("",  $i  & "  �յ��ӽ��̵���Ϣ�� " & $vParameter , 1, 16)   ; $gi_CoProcParent
	;$childmsg = $vParameter
	$aParam = StringSplit($vParameter, "|")
	If $aParam[1] = "lifeStatus" Then $childmsg[0] = $aParam[2]
	If $aParam[1] = "manaStatus" Then $childmsg[1] = $aParam[2]
	If $aParam[1] = "petStatus" Then $childmsg[2] = $aParam[2]
	If $aParam[1] = "lifeBottle" Then $childmsg[3] = $aParam[2]
	If $aParam[1] = "manaBottle" Then $childmsg[4] = $aParam[2]
	If $aParam[1] = "purpleBottle" Then $childmsg[5] = $aParam[2]
	If $aParam[1] = "noOtherComeIn" Then $childmsg[6] = $aParam[2]
	If $aParam[1] = "noOtherWhisper" Then $childmsg[7] = $aParam[2]

EndFunc   ;==>Reciver







