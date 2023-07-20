class KF8XAttachment extends BallisticAttachment;

var byte DestAlpha;
var byte CurAlpha;

const FadeRate = 2;

// Support for player transparency
var array<Material>				OriginalSkins, Fades;
var bool                 					bTransparencyInitialized;
var bool									bTransparencyOn;
var byte									CurFade, LastFade, penalty;

var float									nextCheckTime;

replication
{
	reliable if (Role == ROLE_Authority)
		DestAlpha;
	reliable if (Role == ROLE_Authority && bNetInitial)
		CurAlpha;
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Coords C;
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (BallisticWeapon(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			C = Instigator.Weapon.GetBoneCoords('tip');
	}
	else
		C = GetBoneCoords('tip');
    return C.Origin;
}

/*
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		CurAlpha = 255;
		DestAlpha = 255;
	}
	
	if (BallisticPawn(Instigator) == None)
	{
		Log("No Ballistic Pawn detected for KF8XAttachment.");
		Disable('Tick');
		return;
	}
	
	CreateColorStyle();
	
	if (CurAlpha != 255)
		AdjustAlphaFade(CurAlpha);
}

simulated function CreateColorStyle()
{
	local int i;
	local Shader temp;
	
	local String texDetailString;
	local bool detailTexturesOn;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;

	for(i = 0;i < Skins.Length;i++)
	{
		OriginalSkins[i] = Skins[i];
		Skins[i] = Fades[curFade]; 
	}
	
	// Spot penalty for using low settings.
	texDetailString = Level.GetLocalPlayerController().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetailWorld");
	
	switch(texDetailString)
	{
		case "UltraLow": penalty = 2; break;
		case "VeryLow": penalty = 2; break;
		case "Low": penalty = 2; break;
		case "Lower": penalty = 1; break;
		case "Normal": penalty = 1; break;
		default: penalty = 0; break;	
	}
	
	if (!bool(Level.GetLocalPlayerController().ConsoleCommand("get ini:Engine.Engine.RenderDevice DetailTextures")))
		penalty += 1;
	
	bTransparencyInitialized = true;
}

simulated function AdjustAlphaFade(byte Amount)
{
	local int i;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (!bTransparencyInitialized)
	{
		if (Amount == 255)
			return;
			
		CreateColorStyle();

		bTransparencyOn = true;
		AmbientGlow = 0;		
		
		curFade = Min(Amount >> 3, 15);
		
		bDramaticLighting = (curFade > 5);
		
		if (penalty > 0)
		{	
			if (curFade >= penalty)
				curFade -= penalty;
			else curFade = 0;
		}
		
		for(i = 0; i < Skins.Length; ++i)
		{
			if (Skins[i] == None)
				continue;
			Skins[i] = Fades[curFade];				
		}
	}
	
	else if (bTransparencyOn)
	{
		if (Amount == 255)
		{
			for(i=0;i<Skins.Length;++i)
				Skins[i] = OriginalSkins[i];
			bTransparencyOn = false;
			bDramaticLighting = true;
		}
		else
		{
			// Update fade
			lastFade = curFade;
			curFade = Min(Amount >> 3, 15);
			
			bDramaticLighting = (curFade > 5);
			
			if (penalty > 0)
			{	
				if (curFade >= penalty)
					curFade -= penalty;
				else curFade = 0;
			}
			
			if (lastFade != curFade)
			{
				for(i = 0; i < Skins.Length; ++i)
				{
					if (Skins[i] == None)
						continue;
					Skins[i] = Fades[curFade];				
				}
			}
		}
	}
	
	else
	{
		if (Amount < 255)
		{
			bTransparencyOn = true;
			AmbientGlow = 0;
			
			// Update fade
			curFade = Min(Amount >> 3, 15);
			
			bDramaticLighting = (curFade > 5);
			
			if (penalty > 0)
			{	
				if (curFade >= penalty)
					curFade -= penalty;
				else curFade = 0;
			}
			
			for(i = 0; i < Skins.Length; ++i)
			{
				if (Skins[i] == None)
					continue;
				Skins[i] = Fades[curFade];				
			}
		}
	}
}

simulated function Destroyed()
{
	local int i;
	
	if (bTransparencyInitialized)
	{
		for (i=0; i<Skins.length; ++i)
			Skins[i] = OriginalSkins[i];	
	}
	
	if (BallisticPawn(Instigator) != None)
		BallisticPawn(Instigator).AdjustAlphaFade(255);
	
	Super.Destroyed();
}

// Refuse overlays when in transparent mode
simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	if (!bTransparencyOn)
		Super.SetOverlayMaterial(mat,time,bOverride);
}

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);
	
	if (Level.TimeSeconds < nextCheckTime)
		return;
	
	if (Role == ROLE_Authority)
		destAlpha = Min(128, 32 + VSize(Instigator.Velocity) * 0.2f);

	if (curAlpha < destAlpha)
	{
		if (destAlpha - curAlpha < FadeRate)
			curAlpha = destAlpha;
		else curAlpha += FadeRate * 2;
		
		//Log("Attachment Alpha Fade UP:"@curAlpha);
		
		AdjustAlphaFade(curAlpha);	
		BallisticPawn(Instigator).AdjustAlphaFade(curAlpha);
	}
		
	
	else if (curAlpha > destAlpha)
	{
			if (curAlpha - destAlpha < FadeRate )
			curAlpha = destAlpha;
		else curAlpha -= FadeRate;
		
		//Log("Attachment Alpha Fade DOWN:"@curAlpha);
		
		AdjustAlphaFade(curAlpha);	
		BallisticPawn(Instigator).AdjustAlphaFade(curAlpha);		
	}
	
	nextCheckTime = Level.TimeSeconds + 0.025f;
}
*/

defaultproperties
{
	WeaponClass=class'KF8XCrossbow'
     Fades(0)=Texture'BW_Core_WeaponTex.Icons.stealth_8'
     Fades(1)=Texture'BW_Core_WeaponTex.Icons.stealth_16'
     Fades(2)=Texture'BW_Core_WeaponTex.Icons.stealth_24'
     Fades(3)=Texture'BW_Core_WeaponTex.Icons.stealth_32'
     Fades(4)=Texture'BW_Core_WeaponTex.Icons.stealth_40'
     Fades(5)=Texture'BW_Core_WeaponTex.Icons.stealth_48'
     Fades(6)=Texture'BW_Core_WeaponTex.Icons.stealth_56'
     Fades(7)=Texture'BW_Core_WeaponTex.Icons.stealth_64'
     Fades(8)=Texture'BW_Core_WeaponTex.Icons.stealth_72'
     Fades(9)=Texture'BW_Core_WeaponTex.Icons.stealth_80'
     Fades(10)=Texture'BW_Core_WeaponTex.Icons.stealth_88'
     Fades(11)=Texture'BW_Core_WeaponTex.Icons.stealth_96'
     Fades(12)=Texture'BW_Core_WeaponTex.Icons.stealth_104'
     Fades(13)=Texture'BW_Core_WeaponTex.Icons.stealth_112'
     Fades(14)=Texture'BW_Core_WeaponTex.Icons.stealth_120'
     Fades(15)=Texture'BW_Core_WeaponTex.Icons.stealth_128'
	 
	 TracerClass=Class'TraceEmitter_KF8XCrossbow'
     TracerChance=1.000000
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
	 
     ImpactManager=class'IM_Bullet'
     AltFlashBone=
     FlashMode=MU_None
     LightMode=MU_None
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
	 ReloadAnim="Reload_MG"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=1.400000
     Mesh=SkeletalMesh'BWBP_OP_Anim.Crossbow_TPm'
     DrawScale=1.000000
     Skins(0)=Shader'BWBP_OP_Tex.XBow.XBow_SH1'
}
