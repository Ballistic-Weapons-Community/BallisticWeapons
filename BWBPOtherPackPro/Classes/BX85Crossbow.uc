//===========================================================================
// BX-85 Stealth Crossbow.
//
// Primary fires relatively slow projectile crossbow bolts for poor DPS.
// Secondary fires lightning projectiles which damage the target and inflict a DoT effect.
// Nearby targets hit with the primary will connect to the electrified target, limiting distance from
// them and sharing damage.
//
// Passively cloaks the user based on their movement speed. Low settings abusers have an additional
// penalty on this check.
//===========================================================================
class BX85Crossbow extends BallisticWeapon;

simulated function float ChargeBar()
{
	return BX85Attachment(ThirdPersonActor).CurAlpha / 128.0f;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.7;	}

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=1)
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BWBPOtherPackTex2.XBow.BigIcon_Crossbow'
     IdleTweenTime=0.000000
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Launches an instant-hit crossbow bolt. This attack has a long fire interval and moderate damage, but is almost invisible and makes no sound. As such, it is very difficult to detect."
     ManualLines(1)="Raises the scope."
     ManualLines(2)="Effective at long range. Excels at stealth."
     SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=8
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.AM67.AM67-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipIn')
     ClipInFrame=0.650000
     CurrentWeaponMode=0
     ZoomType=ZT_Smooth
     ScopeViewTex=Texture'BWBPOtherPackTex2.R9A1.R9_scope_UI_DO1'
     FullZoomFOV=50.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(X=-2.000000,Y=5.000000,Z=5.200000)
     SightDisplayFOV=40.000000
     SightingTime=0.450000
     SightAimFactor=0.150000
     JumpChaos=0.200000
     AimAdjustTime=0.450000
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=600.000000
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=8192.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BWBPOtherPackPro.BX85PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.600000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     bShowChargingBar=True
     Description="Originally a specialist law enforcement weapon, the PD-97 'Bloodhound' has been adapted into a military role, used to control opponents and track their movement upon the battlefield. While less immediately lethal than most other weapons, its tactical repertoire is not to be underestimated."
     Priority=24
     HudColor=(B=150,G=150,R=150)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=0
     PickupClass=Class'BWBPOtherPackPro.BX85Pickup'
     PlayerViewOffset=(X=10.000000,Y=2.000000,Z=-7.000000)
     AttachmentClass=Class'BWBPOtherPackPro.BX85Attachment'
     IconMaterial=Texture'BWBPOtherPackTex2.XBow.Icon_Crossbow'
     IconCoords=(X2=127,Y2=31)
     ItemName="BX85 Stealth Crossbow"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Crossbow_FP'
     DrawScale=0.200000
     Skins(0)=Shader'BWBPOtherPackTex2.XBow.XBow_SH1'
}
