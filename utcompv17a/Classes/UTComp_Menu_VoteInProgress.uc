

defaultproperties
{
     Begin Object Class=GUIButton Name=VoteYesButton
         Caption="Vote Yes"
         WinTop=0.639583
         WinLeft=0.301562
         WinWidth=0.160938
         WinHeight=0.080000
         OnClick=UTComp_Menu_VoteInProgress.InternalOnClick
         OnKeyEvent=VoteYesButton.InternalOnKeyEvent
     End Object
     bu_VoteYes=GUIButton'utcompv17a.UTComp_Menu_VoteInProgress.VoteYesButton'

     Begin Object Class=GUIButton Name=votenoButton
         Caption="Vote No"
         WinTop=0.639583
         WinLeft=0.529689
         WinWidth=0.160938
         WinHeight=0.080000
         OnClick=UTComp_Menu_VoteInProgress.InternalOnClick
         OnKeyEvent=votenoButton.InternalOnKeyEvent
     End Object
     bu_VoteNo=GUIButton'utcompv17a.UTComp_Menu_VoteInProgress.votenoButton'

     Begin Object Class=GUILabel Name=VoteLabel0
         Caption="--- Vote in progress ---"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=200,R=230)
         WinTop=0.350000
     End Object
     l_Vote(0)=GUILabel'utcompv17a.UTComp_Menu_VoteInProgress.VoteLabel0'

     Begin Object Class=GUILabel Name=VoteLabel1
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.400000
     End Object
     l_Vote(1)=GUILabel'utcompv17a.UTComp_Menu_VoteInProgress.VoteLabel1'

     Begin Object Class=GUILabel Name=VoteLabel2
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.450000
     End Object
     l_Vote(2)=GUILabel'utcompv17a.UTComp_Menu_VoteInProgress.VoteLabel2'

     Begin Object Class=GUILabel Name=VoteLabel3
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.500000
     End Object
     l_Vote(3)=GUILabel'utcompv17a.UTComp_Menu_VoteInProgress.VoteLabel3'

     Begin Object Class=GUILabel Name=VoteLabel4
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.550000
     End Object
     l_Vote(4)=GUILabel'utcompv17a.UTComp_Menu_VoteInProgress.VoteLabel4'

}
