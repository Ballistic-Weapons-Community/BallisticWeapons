//=============================================================================
// A weapon given to player when using item tool for the simple purpose of
// drawing a menu and sending some number key events.
//=============================================================================
class ItemGun extends Weapon HideDropDown CacheExempt;

var Mut_ItemizerTool IMut;

simulated function bool HasAmmo()
{
    return true;
}

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
	if (IMut != None)
		IMut.KeyPress(F);
	return None;
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i;
	local float Scalefactor;

	Super.NewDrawWeaponInfo(C, YPos);

	if (IMut == None)
		return;

//	C.TextSize(Ammo[0].AmmoAmount, XL, YL);
	ScaleFactor = C.ClipX / 1600;
	C.CurX = C.OrgX;
	C.CurY = C.OrgY + 200 * ScaleFactor * class'HUD'.default.HudScale;
	C.SetDrawColor(0, 0, 64, 64);
	C.Style=5;
	C.DrawTile(Texture'Engine.MenuWhite', 300 * ScaleFactor * class'HUD'.default.HudScale, 300 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	for (i=0;i<10;i++)
	{
		if (IMut.SelectedItem == i)
			C.DrawColor = class'hud'.default.GoldColor;
		else
			C.DrawColor = class'hud'.default.WhiteColor;
//		C.Font = Font'engine.defaultfont';
	 	C.CurX = C.OrgX+5;
		C.CurY = C.OrgY + (200 + 30 * i) * ScaleFactor * class'HUD'.default.HudScale;
		C.DrawText(IMut.MenuText[i], false);
	}

}
simulated event RenderOverlays( Canvas C )
{
	Super.RenderOverlays(C);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    local Mutator Mut;
    super.BringUp();
	for (Mut=Level.Game.BaseMutator; Mut!=None; Mut=Mut.NextMutator )
	{
		if (Mut_ItemizerTool(Mut) != None)
		{
			IMut = Mut_ItemizerTool(Mut);
			return;
		}
	}
	log("Item gun could not link to Itemizer mutator",'Warning');
}

defaultproperties
{
     FireModeClass(0)=Class'BallisticProV55.ItemgunFire'
     FireModeClass(1)=Class'BallisticProV55.ItemgunFire'
     PutDownAnim="PutDown"
     IdleAnimRate=0.250000
     SelectSound=Sound'WeaponSounds.Misc.translocator_change'
     SelectForce="Translocator_change"
     AIRating=-999.000000
     CurrentRating=-999.000000
     bShowChargingBar=True
     bCanThrow=False
     Description="item gun."
     Priority=231
     HudColor=(B=255,G=0,R=0)
     SmallViewOffset=(X=38.000000,Y=16.000000,Z=-16.000000)
     CenteredOffsetY=0.000000
     CenteredRoll=0
     CustomCrosshair=2
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Circle1"
     InventoryGroup=10
     PickupClass=Class'XWeapons.Transpickup'
     PlayerViewOffset=(X=28.500000,Y=12.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1000,Yaw=400)
     AttachmentClass=Class'XWeapons.TransAttachment'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X2=2,Y2=2)
     ItemName="Item Gun"
     Mesh=SkeletalMesh'NewWeapons2004.NewTranslauncher_1st'
     DrawScale=0.800000
     Skins(0)=FinalBlend'EpicParticles.JumpPad.NewTransLaunBoltFB'
     Skins(1)=Texture'WeaponSkins.Skins.NEWTranslocatorTEX'
     Skins(2)=Texture'WeaponSkins.AmmoPickups.NEWTranslocatorPUCK'
     Skins(3)=FinalBlend'WeaponSkins.AmmoPickups.NewTransGlassFB'
}
