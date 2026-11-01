class ThawInfoHudOverlay extends HudOverlay;

var ThawInfo							ThawInfo;

var HUDBase.SpriteWidget  ProtectionIcon;
var HUDBase.NumericWidget ProtectionDigits;

var HUDBase.SpriteWidget  RecentlyThawnIcon;
var HUDBase.NumericWidget RecentlyThawnDigits;

simulated function Render(Canvas C)
{	
	if (ThawInfo != None && Freon_HUD(Owner).PlayerOwner.Pawn	!= None)
	{
	  if( ThawInfo.bIsProtected && ThawInfo.ClientProtectionStartTime != 0 && Level.TimeSeconds - ThawInfo.ClientProtectionStartTime < ThawInfo.ThawProtectionTime)
	  {
	  	Freon_HUD(Owner).DrawWidgetAsTile(C, ProtectionIcon);
			ProtectionDigits.Value = Ceil((ThawInfo.ClientProtectionStartTime + ThawInfo.ThawProtectionTime) - Level.TimeSeconds);
			Freon_HUD(Owner).DrawNumericWidgetAsTiles(C, ProtectionDigits, Freon_HUD(Owner).DigitsBig);
	  }
	  
	  if(ThawInfo.bRecentlyThawn && ThawInfo.ClientRecentlyThawnStartTime != 0 && Level.TimeSeconds - ThawInfo.ClientRecentlyThawnStartTime < ThawInfo.RecentlyThawnTime)
	  {
	  	Freon_HUD(Owner).DrawWidgetAsTile(C, RecentlyThawnIcon);
			RecentlyThawnDigits.Value = Ceil((ThawInfo.ClientRecentlyThawnStartTime + ThawInfo.RecentlyThawnTime) - Level.TimeSeconds);
			Freon_HUD(Owner).DrawNumericWidgetAsTiles(C, RecentlyThawnDigits, Freon_HUD(Owner).DigitsBig);
	  }
	}
}

defaultproperties
{
     ProtectionIcon=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=126,Y1=165,X2=164,Y2=226),TextureScale=0.800000,DrawPivot=DP_MiddleMiddle,PosX=0.950000,PosY=0.550000,OffsetY=7,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     ProtectionDigits=(RenderStyle=STY_Alpha,TextureScale=0.490000,DrawPivot=DP_MiddleMiddle,PosX=0.950000,PosY=0.550000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     RecentlyThawnIcon=(WidgetTexture=Texture'LDGGameBW_rc.textures.RecentlyThawnFlake',RenderStyle=STY_Alpha,TextureCoords=(X2=63,Y2=63),TextureScale=0.800000,DrawPivot=DP_MiddleMiddle,PosX=0.950000,PosY=0.650000,OffsetY=7,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     RecentlyThawnDigits=(RenderStyle=STY_Alpha,TextureScale=0.490000,DrawPivot=DP_MiddleMiddle,PosX=0.950000,PosY=0.660000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
}
