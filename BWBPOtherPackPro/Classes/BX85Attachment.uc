class BX85Attachment extends BallisticAttachment;

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
		Log("No Ballistic Pawn detected for BX85Attachment.");
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

// Refusue overlays when in transparent mode
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

defaultproperties
{
     Fades(0)=Texture'BallisticProTextures.Icons.stealth_8'
     Fades(1)=Texture'BallisticProTextures.Icons.stealth_16'
     Fades(2)=Texture'BallisticProTextures.Icons.stealth_24'
     Fades(3)=Texture'BallisticProTextures.Icons.stealth_32'
     Fades(4)=Texture'BallisticProTextures.Icons.stealth_40'
     Fades(5)=Texture'BallisticProTextures.Icons.stealth_48'
     Fades(6)=Texture'BallisticProTextures.Icons.stealth_56'
     Fades(7)=Texture'BallisticProTextures.Icons.stealth_64'
     Fades(8)=Texture'BallisticProTextures.Icons.stealth_72'
     Fades(9)=Texture'BallisticProTextures.Icons.stealth_80'
     Fades(10)=Texture'BallisticProTextures.Icons.stealth_88'
     Fades(11)=Texture'BallisticProTextures.Icons.stealth_96'
     Fades(12)=Texture'BallisticProTextures.Icons.stealth_104'
     Fades(13)=Texture'BallisticProTextures.Icons.stealth_112'
     Fades(14)=Texture'BallisticProTextures.Icons.stealth_120'
     Fades(15)=Texture'BallisticProTextures.Icons.stealth_128'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone=
     FlashMode=MU_None
     LightMode=MU_None
     ReloadAnim="Reload_MG"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=1.400000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Crossbow_TP'
     DrawScale=1.000000
     Skins(0)=Shader'BWBPOtherPackTex2.XBow.XBow_SH1'
}
