//=============================================================================
// DragonsToothAttachment.
//
// Attachment for the Dragon's Tooth Sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothAttachment extends BallisticMeleeAttachment;

var   bool					bRedTeam;	//Owned by red team?
var   bool					bNoGlow;	//The layout's blade does not glow

replication
{
	reliable if ( Role==ROLE_Authority )
		bRedTeam;
}

simulated function ApplyModel()
{
	local string Tags;

	Super.ApplyModel();

	if (LayoutIndex >= WeaponClass.static.GetParams().default.Layouts.Length)
		return;

	// The light of the first person blade's glow: red, blue or none at all
	Tags = WeaponClass.static.GetParams().default.Layouts[LayoutIndex].LayoutTags;
	if (InStr(Tags, "red") != -1)
		LightHue = class'DragonsToothBladeEffectR'.default.LightHue;
	else if (InStr(Tags, "black") != -1 || InStr(Tags, "gold") != -1)
		bNoGlow = true;
}

// The first person blade lights the place up for the one holding it. Everyone else gets it from here, and so does he in behind view.
// The light is where this was last drawn, so it goes out when it is not on screen.
simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bNoGlow || (Instigator != None && Instigator.IsFirstPerson()) || Level.TimeSeconds - LastRenderTime > 0.2)
		LightType = LT_None;
	else
		LightType = LT_Steady;
}

simulated function PostNetBeginPlay()
{
     Super.PostNetBeginPlay();
     
	if (Instigator != None)
	{
		if ((Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) || bRedTeam )
		{
			if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 || bRedTeam )
			{
				Skins[0] = Shader'BWBP_SKC_Tex.DragonToothSword.DTS-Red3rd';
				LightHue=5;
			}			
			else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
				Skins[0] = Shader'BWBP_SKC_Tex.DragonToothSword.DTS-Shine3rd';
		}
	}
}

defaultproperties
{
	WeaponClass=class'DragonsToothSword'
	ImpactManager=Class'BWBP_SKC_Pro.IM_DTS'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	bHeavy=True
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=160
	LightSaturation=64
	LightBrightness=224.000000
	LightRadius=12.000000
	bDynamicLight=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.DTS_TPm'
	RelativeLocation=(Y=-3.000000,Z=6.000000)
	DrawScale=0.120000
}
