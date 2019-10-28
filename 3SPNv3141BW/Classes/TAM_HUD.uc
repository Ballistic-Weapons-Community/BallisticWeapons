class TAM_HUD extends Team_HUDBase;

/* combo related */
var bool bDrawCombos;

var NumericWidget ComboAdren;
var SpriteWidget ComboBack;
var SpriteWidget ComboDisc;
var SpriteWidget ComboType[10];
/* combo related */

function DisplayMessages(Canvas C)
{
    if(bShowScoreboard || bShowLocalStats)
        ConsoleMessagePosY = 0.995;
    else
        ConsoleMessagePosY = default.ConsoleMessagePosY;

    super.DisplayMessages(C);
}

simulated function DrawChargeBar(Canvas C)
{
    if(!bDrawCombos)
        super.DrawChargeBar(C);
}

simulated function DrawAdrenaline(Canvas C)
{
    local int i;
    local int drawn;
    local float posy;
    local float scale;

    local TeamInfo TRI;
    local Misc_DynComboReplicationInfo CRI;

    Super.DrawAdrenaline(C);

    if(myOwner == None || !myOwner.bShowCombos)
        return;

    if(myOwner.PlayerReplicationInfo.bOnlySpectator)
    {
        if(Pawn(myOwner.ViewTarget) != None)
            TRI = Pawn(myOwner.ViewTarget).GetTeam();
    }
    else
    {
        if(myOwner.Pawn != None)
            TRI = myOwner.Pawn.GetTeam();
        else 
            TRI = myOwner.PlayerReplicationInfo.Team;
    }

    if(TRI == None)
        return;

    if(TAM_TeamInfo(TRI) != None)
        CRI = TAM_TeamInfo(TRI).ComboRI;
    else if(TAM_TeamInfoRed(TRI) != None)
        CRI = TAM_TeamInfoRed(TRI).ComboRI;
    else if(TAM_TeamInfoBlue(TRI) != None)
        CRI = TAM_TeamInfoBlue(TRI).ComboRI;

    if(CRI == None || !CRI.bRunning)
        return;

    bDrawCombos = true;

    scale = FMax(HUDScale, 0.75);
    posy = 1.0 - (0.105 * Scale);

    for(i = 0; i < ArrayCount(CRI.Combos); i++)
    {
        if(CRI.Combos[i].Time > 0.0)
        {
            ComboBack.PosY = (posy - (0.033 * drawn) * Scale);
			DrawWidgetAsTile(C, ComboBack );
            
            ComboType[CRI.Combos[i].Type].PosY = (posy - (0.033 * drawn) * Scale);
            
			DrawWidgetAsTile(C, ComboType[CRI.Combos[i].Type]);

            ComboAdren.Value = CRI.Combos[i].Time;
            ComboAdren.PosY = (posy - (0.033 * drawn) * Scale);
            DrawNumericWidgetAsTiles(C, ComboAdren, DigitsBig);
            
            drawn++;
        }
    }
}

defaultproperties
{
     ComboAdren=(RenderStyle=STY_Alpha,TextureScale=0.270000,DrawPivot=DP_MiddleRight,PosX=0.980000,PosY=0.060000,OffsetX=-44,OffsetY=45,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     ComboBack=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=168,Y1=211,X2=334,Y2=255),TextureScale=0.250000,DrawPivot=DP_UpperRight,PosX=0.990000,PosY=0.060000,OffsetY=25,ScaleMode=SM_Left,Scale=1.500000,Tints[0]=(A=150),Tints[1]=(A=150))
     ComboType(1)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=90,Y1=173,X2=166,Y2=249),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(2)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=174,Y1=5,X2=250,Y2=81),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(3)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=5,Y1=173,X2=81,Y2=249),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(4)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=5,Y1=5,X2=81,Y2=81),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(5)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=174,Y1=173,X2=250,Y2=249),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(6)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=89,Y1=5,X2=165,Y2=81),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
     ComboType(7)=(WidgetTexture=Texture'3SPNv3141BW.textures.Icons',RenderStyle=STY_Alpha,TextureCoords=(X1=89,Y1=89,X2=165,Y2=165),TextureScale=0.200000,DrawPivot=DP_UpperRight,PosX=0.987500,PosY=0.060000,OffsetX=10,OffsetY=23,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=200),Tints[1]=(B=255,G=255,R=255,A=200))
}
