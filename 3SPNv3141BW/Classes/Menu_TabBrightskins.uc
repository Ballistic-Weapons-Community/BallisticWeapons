class Menu_TabBrightskins extends UT2k3TabPanel;

var SpinnyWeap  RedSpinnyDude;
var SpinnyWeap  BlueSpinnyDude;
var vector      RedSpinnyOffset;
var vector      BlueSpinnyOffset;
var bool        bBrightskins;

var array<string> Models;
var string      RedPick;
var string      BluePick;

var GUITreeListBox  RedMLB;
var GUITreeList     RedML;

var GUITreeListBox  BlueMLB;
var GUITreeList     BlueML;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local Misc_Player P;
    local int i;

    Super.InitComponent(MyController, MyOwner);

    P = Misc_Player(PlayerOwner());
    if(P == None)
        return;

    moCheckBox(Controls[1]).Checked(!P.bUseBrightskins);
    moCheckBox(Controls[2]).Checked(!P.bUseTeamColors);

    GUISlider(Controls[5]).Value = P.RedOrEnemy.R;
    GUISlider(Controls[6]).Value = P.RedOrEnemy.G;
    GUISlider(Controls[7]).Value = P.RedOrEnemy.B;

    GUISlider(Controls[8]).Value = P.BlueOrAlly.R;
    GUISlider(Controls[9]).Value = P.BlueOrAlly.G;
    GUISlider(Controls[10]).Value = P.BlueOrAlly.B;

    RedSpinnyDude = P.Spawn(Class'XInterface.SpinnyWeap');
    RedSpinnyDude.SetDrawType(DT_Mesh);
    RedSpinnyDude.bPlayRandomAnims = true;
    RedSpinnyDude.SetDrawScale(0.275);
    RedSpinnyDude.SpinRate = 12000;

    BlueSpinnyDude = P.Spawn(Class'XInterface.SpinnyWeap');
    BlueSpinnyDude.SetDrawType(DT_Mesh);
    BlueSpinnyDude.bPlayRandomAnims = true;
    BlueSpinnyDude.SetDrawScale(0.275);
    BlueSpinnyDude.SpinRate = 12000;

    moCheckBox(Controls[20]).Checked(!P.bUseTeamModels);
    moCheckBox(Controls[21]).Checked(P.bForceRedEnemyModel);
    moCheckBox(Controls[22]).Checked(P.bForceBlueAllyModel);

    /* red model list */
    RedMLB = GUITreeListBox(Controls[23]);
    if(RedMLB != None)
    {
        RedML = RedMLB.List;
        
        if(RedMLB.MyScrollBar != None)
            RedMLB.MyScrollBar.WinWidth = 0.015;
    }

    if(RedML != None)
    {
        RedML.OnChange = OnChange;
        RedML.bSorted = true;

        RedML.bNotify = false;
        RedML.Clear();

        for(i = 0; i < Models.Length; i++)
            RedML.AddItem(Models[i], Models[i]);

        RedML.SortList();
        RedML.bNotify = true;
        
        i = RedML.FindIndex(P.RedEnemyModel);
        if(i != -1)
            RedML.SilentSetIndex(i);
        else
            OnChange(RedML);
    }
    /* end red model list */

    /* blue model list */
    BlueMLB = GUITreeListBox(Controls[24]);
    if(BlueMLB != None)
    {
        BlueML = BlueMLB.List;

        if(BlueMLB.MyScrollBar != None)
            BlueMLB.MyScrollBar.WinWidth = 0.015;
    }

    if(BlueML != None)
    {
        BlueML.OnChange = OnChange;
        BlueML.bSorted = true;

        BlueML.bNotify = false;
        BlueML.Clear();

        for(i = 0; i < Models.Length; i++)
            BlueML.AddItem(Models[i], Models[i]);

        BlueML.SortList();
        BlueML.bNotify = true;

        i = BlueML.FindIndex(P.BlueAllyModel);
        if(i != -1)
            BlueML.SilentSetIndex(i);
        else
            OnChange(BlueML);
    }
    /* end blue model list */

    OnChange(Controls[1]);
    //OnChange(Controls[2]);
}

function HideSpinnyDudes(bool bHide)
{
    if(RedSpinnyDude != None)
        RedSpinnyDude.bHidden = bHide;
    if(BlueSpinnyDude != None)
        BlueSpinnyDude.bHidden = bHide;
}

function string GetRandomModel()
{
    return Models[Rand(Models.Length)];
}

function UpdateSpinnyDudes()
{
    local Misc_Player P;

	local xUtil.PlayerRecord Rec;
	local Mesh RedMesh, BlueMesh;
	local Material RedBodySkin, RedHeadSkin,
                   BlueBodySkin, BlueHeadSkin;

    local Combiner RedC, BlueC;
	local ConstantColor RedCC, BlueCC;

    local string BlueModel;
    local string RedModel;

    RedC = New(None)class'Combiner';
	RedCC = New(None)class'ConstantColor';
    BlueC = New(None)class'Combiner';
	BlueCC = New(None)class'ConstantColor';

    P = Misc_Player(PlayerOwner());

    if(P.bForceRedEnemyModel)
        RedModel = P.RedEnemyModel;
    else if(RedPick == "")
        RedModel = GetRandomModel();
    else 
        RedModel = RedPick;
    RedPick = RedModel;
    
    if(P.bForceBlueAllyModel)
        BlueModel = P.BlueAllyModel;
    else if(BluePick == "")
        BlueModel = GetRandomModel();
    else
        BlueModel = BluePick;
    BluePick = BlueModel;

	Rec = Class'xUtil'.static.FindPlayerRecord(RedModel);
	RedMesh = Mesh(DynamicLoadObject(Rec.MeshName, class'Mesh'));
	if(RedMesh == None)
	{
		Log("Could not load mesh: "$Rec.MeshName$" For player: "$Rec.DefaultName);
		return;
	}

	RedBodySkin = Material(DynamicLoadObject(Rec.BodySkinName, class'Material'));
	if(RedBodySkin == None)
	{
		Log("Could not load body material: "$Rec.BodySkinName$" For player: "$Rec.DefaultName);
		return;
	}

	RedHeadSkin = Material(DynamicLoadObject(Rec.FaceSkinName, class'Material'));
	if(RedHeadSkin == None)
	{
		Log("Could not load head material: "$Rec.FaceSkinName$" For player: "$Rec.DefaultName);
		return;
	}

    Rec = Class'xUtil'.static.FindPlayerRecord(BlueModel);
    BlueMesh = Mesh(DynamicLoadObject(Rec.MeshName, class'Mesh'));
	if(BlueMesh == None)
	{
		Log("Could not load mesh: "$Rec.MeshName$" For player: "$Rec.DefaultName);
		return;
	}

	BlueBodySkin = Material(DynamicLoadObject(Rec.BodySkinName, class'Material'));
	if(BlueBodySkin == None)
	{
		Log("Could not load body material: "$Rec.BodySkinName$" For player: "$Rec.DefaultName);
		return;
	}

	BlueHeadSkin = Material(DynamicLoadObject(Rec.FaceSkinName, class'Material'));
	if(BlueHeadSkin == None)
	{
		Log("Could not load head material: "$Rec.FaceSkinName$" For player: "$Rec.DefaultName);
		return;
	}

	RedCC.Color = P.RedOrEnemy;
    //class'Misc_Pawn'.static.ClampColor(RedCC.Color);

    RedC.CombineOperation = CO_Add;
    RedC.Material1 = RedBodySkin;
    RedC.Material2 = RedCC;

	RedSpinnyDude.LinkMesh(RedMesh);
    if(bBrightskins)
	    RedSpinnyDude.Skins[0] = RedC;
    else
    {
        RedBodySkin = GetTeamSkin(RedBodySkin, 0);
        RedSpinnyDude.Skins[0] = RedBodySkin;
    }
	RedSpinnyDude.Skins[1] = RedHeadSkin;

	BlueCC.Color = P.BlueOrAlly;
    //class'Misc_Pawn'.static.ClampColor(BlueCC.Color);

    BlueC.CombineOperation = CO_Add;
    BlueC.Material1 = BlueBodySkin;
    BlueC.Material2 = BlueCC;

	BlueSpinnyDude.LinkMesh(BlueMesh);
    if(bBrightskins)
	    BlueSpinnyDude.Skins[0] = BlueC;
    else
    {
        BlueBodySkin = GetTeamSkin(BlueBodySkin, 1);
        BlueSpinnyDude.Skins[0] = BlueBodySkin;
    }
	BlueSpinnyDude.Skins[1] = BlueHeadSkin;
}

function Material GetTeamSkin(Material skin, int team)
{
    local string MatS;
    local Material Mat;

    MatS = string(skin);

    Mat = Material(DynamicLoadObject("Bright" $ MatS $ "_" $ team $ "B", class'Material', true));
    if(Mat == None)
        Mat = Material(DynamicLoadObject(MatS $ "_" $ team, class'Material', true));

    if(Mat == None)
        return skin;
    return Mat;
}

function OnChange(GUIComponent c)
{
	bBrightskins = !moCheckBox(Controls[1]).IsChecked();

	switch(c)
	{
		case Controls[1]: 
            class'Misc_Player'.default.bUseBrightskins = !moCheckBox(c).IsChecked();
			Misc_Player(PlayerOwner()).bUseBrightskins = !moCheckBox(c).IsChecked();
			
			/*if(moCheckBox(Controls[1]).IsChecked())
			{
				for(i = 2; i < Controls.Length; i++)
					Controls[i].DisableMe();
			}
			else
			{
				for(i = 2; i < Controls.Length; i++)
					Controls[i].EnableMe();
			}*/
		break;

		case Controls[2]:
            class'Misc_Player'.default.bUseTeamColors = !moCheckBox(c).IsChecked();
			Misc_Player(PlayerOwner()).bUseTeamColors = !moCheckBox(c).IsChecked();

			/*if(moCheckBox(c).IsChecked())
			{
				GUILabel(Controls[3]).Caption = "Enemies:";
				GUILabel(Controls[4]).Caption = "Teammates:";
			}
			else
			{
				GUILabel(Controls[3]).Caption = "Red Team:";
				GUILabel(Controls[4]).Caption = "Blue Team:";
			}*/
		break;

		case Controls[5]:   Misc_Player(PlayerOwner()).RedOrEnemy.R = GUISlider(c).Value;
                            class'Misc_Player'.default.RedOrEnemy = Misc_Player(PlayerOwner()).RedOrEnemy;
        break;
                            
		case Controls[6]:   Misc_Player(PlayerOwner()).RedOrEnemy.G = GUISlider(c).Value;
                            class'Misc_Player'.default.RedOrEnemy = Misc_Player(PlayerOwner()).RedOrEnemy;
        break;

		case Controls[7]:   Misc_Player(PlayerOwner()).RedOrEnemy.B = GUISlider(c).Value;
                            class'Misc_Player'.default.RedOrEnemy = Misc_Player(PlayerOwner()).RedOrEnemy;
        break;

		case Controls[8]:   Misc_Player(PlayerOwner()).BlueOrAlly.R = GUISlider(c).Value;
                            class'Misc_Player'.default.BlueOrAlly = Misc_Player(PlayerOwner()).BlueOrAlly;
        break;

		case Controls[9]:   Misc_Player(PlayerOwner()).BlueOrAlly.G = GUISlider(c).Value;
                            class'Misc_Player'.default.BlueOrAlly = Misc_Player(PlayerOwner()).BlueOrAlly;
        break;

		case Controls[10]:  Misc_Player(PlayerOwner()).BlueOrAlly.B = GUISlider(c).Value;
                            class'Misc_Player'.default.BlueOrAlly = Misc_Player(PlayerOwner()).BlueOrAlly;
        break;

        case Controls[20]:  Misc_Player(PlayerOwner()).bUseTeamModels = !moCheckBox(c).IsChecked();
                            class'Misc_Player'.default.bUseTeamModels = !moCheckBox(c).IsChecked();
        break;

        case Controls[21]:  Misc_Player(PlayerOwner()).bForceRedEnemyModel = moCheckBox(c).IsChecked();
                            class'Misc_Player'.default.bForceRedEnemyModel = moCheckBox(c).IsChecked();
                            RedPick = "";
        break;

        case Controls[22]:  Misc_Player(PlayerOwner()).bForceBlueAllyModel = moCheckBox(c).IsChecked();
                            class'Misc_Player'.default.bForceBlueAllyModel = moCheckBox(c).IsChecked();
                            BluePick = "";
        break;

        case RedML:         Misc_Player(PlayerOwner()).RedEnemyModel = RedML.GetValue();
                            class'Misc_Player'.default.RedEnemyModel = RedML.GetValue();
        break;

        case BlueML:        Misc_Player(PlayerOwner()).BlueAllyModel = BlueML.GetValue();
                            class'Misc_Player'.default.BlueAllyModel = BlueML.GetValue();
        break;
	}

    class'Misc_Player'.static.staticsaveconfig();
	Misc_Player(PlayerOwner()).saveconfig();

	UpdateSpinnyDudes();
}

function bool InternalDraw(Canvas C)
{
	local vector CamPos, X, Y, Z;
	local rotator CamRot;

	C.GetCameraLocation(CamPos, CamRot);
	GetAxes(CamRot, X, Y, Z);

    if(RedSpinnyDude != None)
    {
	    RedSpinnyDude.SetLocation(CamPos + (RedSpinnyOffset.X * X) + (RedSpinnyOffset.Y * Y) + (RedSpinnyOffset.Z * Z));
	    C.DrawActor(RedSpinnyDude, false, true, 90.0);
    }

    if(BlueSpinnyDude != None)
    {
	    BlueSpinnyDude.SetLocation(CamPos + (BlueSpinnyOffset.X * X) + (BlueSpinnyOffset.Y * Y) + (BlueSpinnyOffset.Z * Z));
	    C.DrawActor(BlueSpinnyDude, false, true, 90.0);
    }

	return false;
}

function bool OnClick(GUIComponent C)
{
    local int i;

	Misc_Player(PlayerOwner()).RedOrEnemy.R = 100;
	Misc_Player(PlayerOwner()).RedOrEnemy.G = 0;
	Misc_Player(PlayerOwner()).RedOrEnemy.B = 0;

	Misc_Player(PlayerOwner()).BlueOrAlly.R = 0;
	Misc_Player(PlayerOwner()).BlueOrAlly.G = 25;
	Misc_Player(PlayerOwner()).BlueOrAlly.B = 100;

	Misc_Player(PlayerOwner()).bUseTeamColors = true;

	moCheckBox(Controls[2]).Checked(!Misc_Player(PlayerOwner()).bUseTeamColors);

	GUISlider(Controls[5]).Value = Misc_Player(PlayerOwner()).RedOrEnemy.R;
	GUISlider(Controls[6]).Value = Misc_Player(PlayerOwner()).RedOrEnemy.G;
	GUISlider(Controls[7]).Value = Misc_Player(PlayerOwner()).RedOrEnemy.B;

	GUISlider(Controls[8]).Value = Misc_Player(PlayerOwner()).BlueOrAlly.R;
	GUISlider(Controls[9]).Value = Misc_Player(PlayerOwner()).BlueOrAlly.G;
	GUISlider(Controls[10]).Value = Misc_Player(PlayerOwner()).BlueOrAlly.B;

    moCheckBox(Controls[20]).Checked(false);
    moCheckBox(Controls[21]).Checked(false);
    moCheckBox(Controls[22]).Checked(false);

    for(i = 0; i < Controls.Length; i++)
        OnChange(Controls[i]);

	UpdateSpinnyDudes();

	return true;
}

function ShowPanel(bool bShow)
{
    Super.ShowPanel(bShow);

    HideSpinnyDudes(!bShow);
}

defaultproperties
{
     RedSpinnyOffset=(X=150.000000,Y=5.000000,Z=10.750000)
     BlueSpinnyOffset=(X=150.000000,Y=5.000000,Z=-35.500000)
     Models(0)="Jakob"
     Models(1)="Tamika"
     Models(2)="Gorge"
     Models(3)="Sapphire"
     Models(4)="Malcolm"
     Models(5)="Brock"
     Models(6)="Gaargod"
     Models(7)="Rylisa"
     Models(8)="Ophelia"
     Models(9)="Zarina"
     Models(10)="Nebri"
     Models(11)="Subversa"
     Models(12)="Barktooth"
     Models(13)="Diva"
     Models(14)="Torch"
     Models(15)="Widowmaker"
     Begin Object Class=GUIImage Name=TabBackground
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(B=0,G=0,R=0)
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         bNeverFocus=True
     End Object
     Controls(0)=GUIImage'3SPNv3141BW.Menu_TabBrightskins.TabBackground'

     Begin Object Class=moCheckBox Name=BrightskinsCheck
         Caption="Disable Brightskins."
         OnCreateComponent=BrightskinsCheck.InternalOnCreateComponent
         WinTop=0.050000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(1)=moCheckBox'3SPNv3141BW.Menu_TabBrightskins.BrightskinsCheck'

     Begin Object Class=moCheckBox Name=EnemyAllyCheck
         Caption="Force brightskin colors to Teammates and Enemies."
         OnCreateComponent=EnemyAllyCheck.InternalOnCreateComponent
         Hint="When checked, Team and Enemy skin colors will always be the same regardless of whether you are on the red or blue team."
         WinTop=0.100000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(2)=moCheckBox'3SPNv3141BW.Menu_TabBrightskins.EnemyAllyCheck'

     Begin Object Class=GUILabel Name=RedLabel
         Caption="Red Team (Enemies): "
         TextColor=(B=255,G=255,R=255)
         WinTop=0.250000
         WinLeft=0.100000
         WinHeight=20.000000
     End Object
     Controls(3)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.RedLabel'

     Begin Object Class=GUILabel Name=BlueLabel
         Caption="Blue Team (Teammates): "
         TextColor=(B=255,G=255,R=255)
         WinTop=0.550000
         WinLeft=0.100000
         WinHeight=20.000000
     End Object
     Controls(4)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.BlueLabel'

     Begin Object Class=GUISlider Name=RedRSlider
         bIntSlider=True
         WinTop=0.320000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=RedRSlider.InternalOnClick
         OnMousePressed=RedRSlider.InternalOnMousePressed
         OnMouseRelease=RedRSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=RedRSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedRSlider.InternalCapturedMouseMove
     End Object
     Controls(5)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.RedRSlider'

     Begin Object Class=GUISlider Name=RedGSlider
         bIntSlider=True
         WinTop=0.390000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=RedGSlider.InternalOnClick
         OnMousePressed=RedGSlider.InternalOnMousePressed
         OnMouseRelease=RedGSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=RedGSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedGSlider.InternalCapturedMouseMove
     End Object
     Controls(6)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.RedGSlider'

     Begin Object Class=GUISlider Name=RedBSlider
         bIntSlider=True
         WinTop=0.460000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=RedBSlider.InternalOnClick
         OnMousePressed=RedBSlider.InternalOnMousePressed
         OnMouseRelease=RedBSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=RedBSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedBSlider.InternalCapturedMouseMove
     End Object
     Controls(7)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.RedBSlider'

     Begin Object Class=GUISlider Name=BlueRSlider
         bIntSlider=True
         WinTop=0.620000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=BlueRSlider.InternalOnClick
         OnMousePressed=BlueRSlider.InternalOnMousePressed
         OnMouseRelease=BlueRSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=BlueRSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueRSlider.InternalCapturedMouseMove
     End Object
     Controls(8)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.BlueRSlider'

     Begin Object Class=GUISlider Name=BlueGSlider
         bIntSlider=True
         WinTop=0.690000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=BlueGSlider.InternalOnClick
         OnMousePressed=BlueGSlider.InternalOnMousePressed
         OnMouseRelease=BlueGSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=BlueGSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueGSlider.InternalCapturedMouseMove
     End Object
     Controls(9)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.BlueGSlider'

     Begin Object Class=GUISlider Name=BlueBSlider
         bIntSlider=True
         WinTop=0.760000
         WinLeft=0.200000
         WinWidth=0.260000
         OnClick=BlueBSlider.InternalOnClick
         OnMousePressed=BlueBSlider.InternalOnMousePressed
         OnMouseRelease=BlueBSlider.InternalOnMouseRelease
         OnChange=Menu_TabBrightskins.OnChange
         OnKeyEvent=BlueBSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueBSlider.InternalCapturedMouseMove
     End Object
     Controls(10)=GUISlider'3SPNv3141BW.Menu_TabBrightskins.BlueBSlider'

     Begin Object Class=GUILabel Name=RedRLabel
         Caption="R:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.320000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(11)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.RedRLabel'

     Begin Object Class=GUILabel Name=RedGLabel
         Caption="G:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.390000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(12)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.RedGLabel'

     Begin Object Class=GUILabel Name=RedBLabel
         Caption="B:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.460000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(13)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.RedBLabel'

     Begin Object Class=GUILabel Name=BlueRLabel
         Caption="R:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.620000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(14)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.BlueRLabel'

     Begin Object Class=GUILabel Name=BlueGLabel
         Caption="G:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.690000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(15)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.BlueGLabel'

     Begin Object Class=GUILabel Name=BlueBLabel
         Caption="B:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.760000
         WinLeft=0.150000
         WinHeight=20.000000
     End Object
     Controls(16)=GUILabel'3SPNv3141BW.Menu_TabBrightskins.BlueBLabel'

     Begin Object Class=GUIImage Name=RedColorView
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(A=100)
         ImageStyle=ISTY_Stretched
         WinTop=0.240000
         WinLeft=0.075000
         WinWidth=0.850000
         WinHeight=0.275000
         RenderWeight=1.000000
         bNeverFocus=True
     End Object
     Controls(17)=GUIImage'3SPNv3141BW.Menu_TabBrightskins.RedColorView'

     Begin Object Class=GUIImage Name=BlueColorView
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(A=100)
         ImageStyle=ISTY_Stretched
         WinTop=0.540000
         WinLeft=0.075000
         WinWidth=0.850000
         WinHeight=0.275000
         RenderWeight=1.000000
         bNeverFocus=True
     End Object
     Controls(18)=GUIImage'3SPNv3141BW.Menu_TabBrightskins.BlueColorView'

     Begin Object Class=GUIButton Name=DefaultButton
         Caption="Load Defaults."
         StyleName="SquareMenuButton"
         WinTop=0.850000
         WinLeft=0.150000
         WinWidth=0.700000
         WinHeight=0.090000
         OnClick=Menu_TabBrightskins.OnClick
         OnKeyEvent=DefaultButton.InternalOnKeyEvent
     End Object
     Controls(19)=GUIButton'3SPNv3141BW.Menu_TabBrightskins.DefaultButton'

     Begin Object Class=moCheckBox Name=EnemyAllyMCheck
         Caption="Force models to Teammates and Enemies."
         OnCreateComponent=EnemyAllyMCheck.InternalOnCreateComponent
         Hint="When checked, Team and Enemy models will always be the same regardless of whether you are on the red or blue team."
         WinTop=0.150000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(20)=moCheckBox'3SPNv3141BW.Menu_TabBrightskins.EnemyAllyMCheck'

     Begin Object Class=moCheckBox Name=ForceRedMCheck
         Caption="Force Model"
         OnCreateComponent=ForceRedMCheck.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.600000
         WinWidth=0.300000
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(21)=moCheckBox'3SPNv3141BW.Menu_TabBrightskins.ForceRedMCheck'

     Begin Object Class=moCheckBox Name=ForceBlueMCheck
         Caption="Force Model"
         OnCreateComponent=ForceBlueMCheck.InternalOnCreateComponent
         WinTop=0.550000
         WinLeft=0.600000
         WinWidth=0.300000
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(22)=moCheckBox'3SPNv3141BW.Menu_TabBrightskins.ForceBlueMCheck'

     Begin Object Class=GUITreeListBox Name=RUseableModels
         bVisibleWhenEmpty=True
         OnCreateComponent=RUseableModels.InternalOnCreateComponent
         WinTop=0.310000
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.190000
         bBoundToParent=True
         bScaleToParent=True
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(23)=GUITreeListBox'3SPNv3141BW.Menu_TabBrightskins.RUseableModels'

     Begin Object Class=GUITreeListBox Name=BUseableModels
         bVisibleWhenEmpty=True
         OnCreateComponent=BUseableModels.InternalOnCreateComponent
         WinTop=0.610000
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.190000
         bBoundToParent=True
         bScaleToParent=True
         OnChange=Menu_TabBrightskins.OnChange
     End Object
     Controls(24)=GUITreeListBox'3SPNv3141BW.Menu_TabBrightskins.BUseableModels'

     OnDraw=Menu_TabBrightskins.InternalDraw
}
