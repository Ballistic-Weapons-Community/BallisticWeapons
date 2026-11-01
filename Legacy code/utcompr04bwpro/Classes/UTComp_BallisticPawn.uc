class UTComp_BallisticPawn extends BallisticPawn;

var xUtil.PlayerRecord PawnRec;
var color SavedColor, ShieldColor, LinkColor, ShockColor, LGColor;
var bool bShieldActive, bLinkActive, bShockActive, bLGActive, bOverlayActive, bEffectsCleared;
var PlayerController LocalPC;

var UTComp_SRI UTCompSRI;
var color BrightSkinColors[8];

var byte OldTeam;

replication
{
  unreliable if (Role == ROLE_Authority)
		bShieldActive, bLinkActive, bShockActive, bLGactive, bOverlayActive;
		
	reliable if (Role == ROLE_Authority && bNetInitial)
		UTCompSRI;
}

simulated function PreBeginPlay()
{
	local Mutator M;
	
	if (Role == ROLE_Authority)
	{
		for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
		{
			if (MutUTComp(M) != None)
			{
				UTCompSRI = MutUTComp(M).UTCompSRI;
				break;
			}
		}
	}
	
	Super.PreBeginPlay();
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Material'PurpleMarker');
	Super.UpdatePrecacheMaterials();
}

/* --- changed from xPawn's GetTeamNum() to get rid of a bug when
    getting team number in a vehicle client-side ---*/

simulated function int GetTeamNum()
{
	if ( Controller != None )
		return Controller.GetTeamNum();
		
	if ( (DrivenVehicle != None) && (DrivenVehicle.Controller != None) )
		return DrivenVehicle.Controller.GetTeamNum();
		
	if ( OldController != None )
		return OldController.GetTeamNum();
		
	if( PlayerReplicationInfo == None)
	{
		if(DrivenVehicle!=None)
			return DrivenVehicle.GetTeamNum();
			
		return 255;
	}
	
	if(PlayerReplicationInfo.Team==None)
		return 255;
		
	return PlayerReplicationInfo.Team.TeamIndex;
}

simulated function TickFX(float DeltaTime)
{
	local int i,NumSkins;
	local int colormode;

	if ( SimHitFxTicker != HitFxTicker )
		ProcessHitFX();

	if(bInvis && !bOldInvis) // Going invisible
	{
		if ( Left(string(Skins[0]),21) ~= "UT2004PlayerSkins.Xan" )
			Skins[2] = Material(DynamicLoadObject("UT2004PlayerSkins.XanMk3V2_abdomen", class'Material'));

		// Save the 'real' non-invis skin
		NumSkins = Clamp(Skins.Length,2,4);

		for ( i=0; i<NumSkins; i++ )
		{
			RealSkins[i] = Skins[i];
			Skins[i] = InvisMaterial;
		}

		// Remove/disallow projectors on invisible people
		Projectors.Remove(0, Projectors.Length);
		bAcceptsProjectors = false;

		// Invisible - no shadow
		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = false;

		// No giveaway flames either
		RemoveFlamingEffects();
	}
	else if(!bInvis && bOldInvis) // Going visible
	{
		NumSkins = Clamp(Skins.Length,2,4);

		for ( i=0; i<NumSkins; i++ )
			Skins[i] = RealSkins[i];

		bAcceptsProjectors = default.bAcceptsProjectors;

		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = true;
	}

	bOldInvis = bInvis;

	bDrawCorona = ( !bNoCoronas && !bInvis && (Level.NetMode != NM_DedicatedServer)	&& !bPlayedDeath && (Level.GRI != None) && Level.GRI.bAllowPlayerLights
		&& (PlayerReplicationInfo != None) && Min(UTCompSRI.EnableBrightSkinsMode, FindSkinMode()) < 3);

	if ( bDrawCorona && (PlayerReplicationInfo.Team != None) )
	{
		ColorMode = GetColorMode();
		if(ColorMode == 0)
			Texture = Texture'xEffects.GoldGlow';
		else if (ColorMode == 1)
			texture = texture'RedMarker_t';
		else if(ColorMode == 2)
			texture = texture'BlueMarker_t';
		else if(ColorMode == 3)
			texture = texture'PurpleMarker';
		else if ( PlayerReplicationInfo.Team.TeamIndex == 0 )
			texture = Texture'RedMarker_t';
		else
			Texture = Texture'BlueMarker_t';
	}
}

simulated function string GetDefaultCharacter()
{
	local int i;
	
	if (Level.NetMode == NM_DedicatedServer)
		return PlacedCharacterName;
	
	if(!PawnIsEnemyOrBlue(true))
	{
		for(i = 0; i<class'UTComp_Settings'.default.ClanSkins.Length; i++)
			if(PlayerReplicationInfo != None && InStrNonCaseSensitive(PlayerReplicationInfo.PlayerName, class'UTComp_Settings'.default.ClanSkins[i].PlayerName))
				return IsAcceptable(class'UTComp_Settings'.default.ClanSkins[i].ModelName);
	}
	
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedModels))
		return IsAcceptable(class'UTComp_Settings'.default.BlueEnemyModelName);
	else
		return IsAcceptable(class'UTComp_Settings'.default.RedTeammateModelName);
}

/* -- S2 in S -- */
simulated function bool InStrNonCaseSensitive(String S, string S2)
{
	local int i;
	
	for(i=0; i<=(Len(S)-Len(S2)); i++)
	{
		if(Mid(S, i, Len(s2)) ~= S2)
			return true;
	}
	
	return false;
}

simulated function bool ShouldForceModel()
{
	if(Level.NetMode == NM_DedicatedServer)
		return true;
	
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedModels))
		return class'UTComp_Settings'.default.bBlueEnemyModelsForced;
	else
		return class'UTComp_Settings'.default.bRedTeammateModelsForced;
}

/* Includes all defualt characters as of ECE release + July  
 * Yes potential abuse here, yes.
 */
simulated static function string IsAcceptable(string S)
{
	if (S~="Abaddon");
	else if (S~="Ambrosia");
	else if (S~="Annika");
	else if (S~="Arclite");
	else if (S~="Aryss");
	else if (S~="Asp");
	else if (S~="Axon");
	else if (S~="Azure");
	else if (S~="Baird");
	else if (S~="Barktooth");
	else if (S~="BlackJack");
	else if (S~="Brock");
	else if (S~="Brutalis");
	else if (S~="Cannonball");
	else if (S~="Cathode");
	else if (S~="ClanLord");
	else if (S~="Cleopatra");
	else if (S~="Cobalt");
	else if (S~="Corrosion");
	else if (S~="Cyclops");
	else if (S~="Damarus");
	else if (S~="Diva");
	else if (S~="Divisor");
	else if (S~="Domina");
	else if (S~="Dominator");
	else if (S~="Drekorig");
	else if (S~="Enigma");
	else if (S~="Faraleth");
	else if (S~="Fate");
	else if (S~="Frostbite");
	else if (S~="Gaargod");
	else if (S~="Garrett");
	else if (S~="Gkublok");
	else if (S~="Gorge");
	else if (S~="Greith");
	else if (S~="Guardian");
	else if (S~="Harlequin");
	else if (S~="Horus");
	else if (S~="Hyena");
	else if (S~="Jakob");
	else if (S~="July");
	else if (S~="Kaela");
	else if (S~="Kane");
	else if (S~="Karag");
	else if (S~="Komek");
	else if (S~="Kraagesh");
	else if (S~="Kragoth");
	else if (S~="Lauren");
	else if (S~="Lilith");
	else if (S~="Makreth");
	else if (S~="Malcolm");
	else if (S~="Mandible");
	else if (S~="Matrix");
	else if (S~="Mekkor");
	else if (S~="Memphis");
	else if (S~="Mokara");
	else if (S~="Motig");
	else if (S~="Mr.Crow");
	else if (S~="Nebri");
	else if (S~="Ophelia");
	else if (S~="Othello");
	else if (S~="Outlaw");
	else if (S~="Prism");
	else if (S~="Rae");
	else if (S~="Rapier");
	else if (S~="Ravage");
	else if (S~="Reinha");
	else if (S~="Remus");
	else if (S~="Renegade");
	else if (S~="Riker");
	else if (S~="Roc");
	else if (S~="Romulus");
	else if (S~="Rylisa");
	else if (S~="Sapphire");
	else if (S~="Satin");
	else if (S~="Scarab");
	else if (S~="Selig");
	else if (S~="Siren");
	else if (S~="Skakruk");
	else if (S~="Skrilax");
	else if (S~="Subversa");
	else if (S~="Syzygy");
	else if (S~="Tamika");
	else if (S~="Thannis");
	else if (S~="Torch");
	else if (S~="Thorax");
	else if (S~="Virus");
	else if (S~="Widowmaker");
	else if (S~="Wraith");
	else if (S~="Xan");
	else if (S~="Zarina");
	else return "Jakob";
	
	return S;
}

/* -- manages the hit effects for skins
   really big hack necessitated by dx9 renderer -- */
simulated function MakeOverlay()
{
	if(!bOverlayActive)
	{
		if(ConstantColor(Combiner(Skins[0]).Material2).color != SavedColor)
		{
			ConstantColor(Combiner(Skins[0]).Material2).color = SavedColor;
			OverlayMaterial = None;
			bEffectsCleared = true;
			return;
		}
	}
	
	if(bShieldActive)
	{
		if(ConstantColor(Combiner(Skins[0]).Material2).color != ShieldColor)
		{
			ConstantColor(Combiner(Skins[0]).Material2).color = ShieldColor;
			bEffectsCleared = false;
		}
		return;
	}
	
	if(bLinkActive && ConstantColor(Combiner(Skins[0]).Material2).color != LinkColor)
	{
		ConstantColor(Combiner(Skins[0]).Material2).color = LinkColor;
		bEffectsCleared = false;
	}
	else if(bShockActive && ConstantColor(Combiner(Skins[0]).Material2).color != ShockColor)
	{
		ConstantColor(Combiner(Skins[0]).Material2).color = ShockColor;
		bEffectsCleared=  false;
	}
	else if(bLGActive)
	{
		ConstantColor(Combiner(Skins[0]).Material2).color = LGColor;
		bEffectsCleared = false;
	}
}

//ToDo -- move the overly timer to a separate timer class
simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	if(UTCompSRI!=None && UTCompSRI.EnableBrightSkinsMode == 3)
	{
		if(mat==Shader'XGameShaders.PlayerShaders.LinkHit')
		{
			if(!bOverlayActive || (bOverlayActive && bLinkActive))
			{
				bLinkActive=true;
				bOverlayActive=true;
				SetTimer(0.150, false);
			}
		}
		else if(mat==Shader'UT2004Weapons.Shaders.ShockHitShader')
		{
			if(!bOverlayActive || (bOverlayActive && bShockActive))
			{
				bShockActive=true;
				bOverlayActive=true;
				SetTimer(0.30, false);
			}
		}
		else if(mat==Shader'XGameShaders.PlayerShaders.LightningHit')
		{
			if(!bOverlayActive || (bOverlayActive && bLGActive))
			{
				bLGActive=true;
				bOverlayActive=true;
				SetTimer(0.30, false);
			}
		}
		else if(mat==ShieldHitMat)
		{
			if(!bOverlayActive || (bOverlayActive && bShieldActive))
			{
				bShieldActive=true;
				bOverlayActive=true;
				
				if(time==default.shieldhitmattime)
					SetTimer(0.250, false);
				else
					SetTimer(time*0.60, false);
			}
		}
	}
	
	if ( Level.bDropDetail || Level.DetailMode == DM_Low)
		time *= 0.75;
		
	Super.SetOverlayMaterial(mat,time,bOverride);
}

function Timer()
{
	bShieldActive=false;
	bShockActive=false;
	bLGactive=false;
	bLinkActive=false;
	bOverlayActive=false;
}

simulated function bool PawnIsEnemyOrBlue(bool bEnemyBased)
{
	local int LocalPlayerTeamNum;
	local int PawnTeamNum;

	if (LocalPC == None)
		return GetTeamNum() == 1;
			
	LocalPlayerTeamNum = LocalPC.GetTeamNum();
	PawnTeamNum = GetTeamNum();
	
	if(PawnTeamNum == 255)
	{
		if(Controller == None || PlayerController(Controller) == None || PlayerController(Controller) != LocalPC)
			return true;
			
		return false;
	}
	
	if(bEnemyBased && LocalPC.PlayerReplicationInfo!=None && (!LocalPC.PlayerReplicationInfo.bOnlySpectator) )
		return (PawnTeamNum != LocalPlayerTeamNum);
	else
		return (PawnTeamNum == 1);
}

simulated function color CapColor(color ColorToCap, optional int LowerConstraint)
{
	ColorToCap.R = Min(ColorToCap.R, 128);
	ColorToCap.G = Min(ColorToCap.G, 128);
	ColorToCap.B = Min(ColorToCap.B, 128);
	
	if(LowerConstraint != 0)
	{
	  ColorToCap.R = Min(ColorToCap.R, LowerConstraint);
	  ColorToCap.G = Min(ColorToCap.G, LowerConstraint);
	  ColorToCap.B = Min(ColorToCap.B, LowerConstraint);
	}
	
	return ColorToCap;
}

state Dying
{
	simulated function BeginState()
	{
		Super.BeginState();
		AmbientSound = None;
		DarkSkinMe();
	}
	
	simulated function DarkSkinMe()
	{
		if(Level.NetMode == NM_DedicatedServer || !class'UTComp_Settings'.default.bEnableDarkSkinning)
			return;
			
		if(Skins.Length >= 1 && Skins[0].IsA('Combiner'))
		{
			if(Combiner(Skins[0]).Material2 == Combiner(Skins[0]).Material1 || Combiner(skins[0]).Material2.IsA('ConstantColor'))
				Combiner(Skins[0]).CombineOperation = CO_Use_Color_From_Material1;
		}
		
		OverlayMaterial = None;
		bUnlit = false;
		AmbientGlow = 0;
	}
}

simulated function bool ShouldUseModel(string S)
{
	local int i;
	
	for(i = 0; i < class'UTComp_Settings'.default.DisallowedEnemyNames.Length; i++)
	{
		if(class'UTComp_Settings'.default.DisallowedEnemyNames[i] ~= S)
			return false;
	}
	return true;
}

simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
	local Material CheckFaceSkin, CheckBodySkin;
	
	if ( (rec.Species == None) || (rec.MeshName == "") || (rec.BodySkinName == "") || (rec.FaceSkinName == "") || 
		( Level.NetMode == NM_DedicatedServer && class'DeathMatch'.Default.bForceDefaultCharacter) || (Level.NetMode != NM_DedicatedServer && ShouldForceModel()) )
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
	else
	{
		CheckFaceSkin = Material(DynamicLoadObject(rec.FaceSkinName, class'Material', true));
		CheckBodySkin = Material(DynamicLoadObject(rec.BodySkinName, class'Material', true));
		
		if (CheckFaceSkin == None || CheckBodySkin == None)
			rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
			
		if (rec.DefaultName ~= "Matrix")
			rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
	}
	
	if(!ShouldUseModel(rec.DefaultName))
		rec = class'xUtil'.static.FindPlayerRecord(class'UTComp_Settings'.default.FallbackCharacterName);

  Species = rec.Species;
	RagdollOverride = rec.Ragdoll;
	if ( !Species.static.Setup(self, rec) )
	{
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
		if ( !Species.static.Setup(self, rec) )
			return;
	}
	
	PawnRec = rec;
	ResetPhysicsBasedAnim(); 
	
	if(Level.NetMode != NM_DedicatedServer)
	{
		ColorSkins();
		
		//setup blood set
	  BloodSet = class'BWBloodSetHunter'.static.GetBloodSetFor(self);
	}
	
	//Exclude Matrix because it's cheap. Treat incoming Jakobs as the default character.
	if ( (rec.Species == None) || (PlayerReplicationInfo.CharacterName ~= "Matrix") || (PlayerReplicationInfo.CharacterName ~= "Jakob") || ForceDefaultCharacter() )
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
		
	if (PlayerReplicationInfo.CharacterName ~= "Abaddon")
		rec = class'xUtil'.static.FindPlayerRecord("AbaddonB");

    else if (PlayerReplicationInfo.CharacterName ~= "Kaela")
		rec = class'xUtil'.static.FindPlayerRecord("KaelaB");

    else if (PlayerReplicationInfo.CharacterName ~= "Zarina")
		rec = class'xUtil'.static.FindPlayerRecord("ZarinaB");

    else if (PlayerReplicationInfo.CharacterName ~= "Jakob")
		rec = class'xUtil'.static.FindPlayerRecord("JakobB");

	// If you're using an advantage-conferring skin you're going to be as bright as the bloody Sun
	if (rec.DefaultName == "July")
		AmbientGlow = 64;
}

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	
	if(Level.NetMode == NM_DedicatedServer)
		return;
	
	if(LocalPC == None)
		LocalPC = Level.GetLocalPlayerController();
	
	if(LocalPC != None && LocalPC.PlayerReplicationInfo != None && LocalPC.PlayerReplicationInfo.Team != None && LocalPC.PlayerReplicationInfo.Team.TeamIndex != OldTeam)
		ColorSkins();

	if( (!bEffectsCleared || bOverlayActive) && Skins.Length != 0 && Skins[0].IsA('Combiner') && Combiner(Skins[0]).Material2.IsA('ConstantColor'))
		MakeOverlay();
}

simulated function ColorSkins()
{
  local byte SkinMode;
  
	if(UTCompSRI == None || UTCompSRI.EnableBrightSkinsMode != 0)
	{
		if(UTCompSRI != None)
			SkinMode = Min(UTCompSRI.EnableBrightSkinsMode, FindSkinMode());
		else
			SkinMode = FindSkinMode();
	    
	  switch(SkinMode)
	  {
			case 1: 
				bUnlit = false;
	      ChangeOnlyColor(PawnRec);
	      break;
	    
	    case 2: 
				bUnlit = true;
				ChangeColorAndBrightness(PawnRec);
				break;
				
			case 3: 
				bUnlit = true;
				ChangeToUTCompSkin(PawnRec);
				break;
		}
	}
	
  //used for checking if the player changed teams mid-game
  if(LocalPC != None && LocalPC.PlayerReplicationInfo != None && LocalPC.PlayerReplicationInfo.Team != None)
		OldTeam = LocalPC.PlayerReplicationInfo.Team.TeamIndex;
}

simulated function byte FindSkinMode()
{
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
		return class'UTComp_Settings'.default.ClientSkinModeBlueEnemy;
	else
		return class'UTComp_Settings'.default.ClientSkinModeRedTeammate;
}

simulated function int GetColorMode()
{
	local int Mode;
	
	Mode = Min(UTCompSRI.EnableBrightSkinsMode, FindSkinMode());
	
	switch(Mode)
	{
		case 1:
			return GetColorModeEpic();
			
		case 2:
			return GetColorModeBright();
	
	}
	return 255;
}

simulated function int GetColorModeBright()
{
	local int ColorMode;
	
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
		ColorMode = class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
	else
		ColorMode = class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
		
	return ColorMode%4;
}

simulated function int GetColorModeEpic()
{
	local byte ColorMode;
	local byte OtherColorMode;
	
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
	{
		ColorMode = class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
		OtherColorMode = class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
	}
	else
	{
		ColorMode = class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
		OtherColorMode = class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
	}
	
	if(ColorMode > 3)
		ColorMode -= 4;
		
	if(OtherColorMode > 3)
		OtherColorMode -= 4;
		
	switch ColorMode
	{
		case 0:  
			return 0;
		
		case 1:
			return 1;
		
		case 2:
			return 2;
		
		case 3:
			if(OtherColorMode < 2)
				return 2;
			else
				return 1;
	}
	
	return 255;
}

simulated function ChangeOnlyColor(xUtil.PlayerRecord record)
{
	local byte ColorMode;
	local byte OtherColorMode;
	local Material Body, Face;

	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
	{
		ColorMode=class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
		OtherColorMode=class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
	}
	else
	{
		ColorMode=class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
		OtherColorMode=class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
	}
	
	if(ColorMode > 3)
		ColorMode -= 4;
		
	if(OtherColorMode > 3)
		OtherColorMode -= 4;

	switch ColorMode
  {
		case 0:  
			MakeDMSkin(record, Body, Face);
			break;
			
		case 1:  
			MakeRedSkin(record, Body, Face);
			break;
			
		case 2:  
			MakeBlueSkin(record, Body, Face);
			break;
			
		case 3:  
			if(OtherColorMode<2)
				MakeBlueSkin(record, Body, Face);
  		else
				MakeRedSkin(record, Body, Face);
				
			break;
  }
  
  Skins[0] = Body;
  Skins[1] = Face;
}

simulated function ChangeColorAndBrightness(xUtil.PlayerRecord record)
{
	local byte ColorMode;
	local Material Body, Face;

	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
		ColorMode=class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy;
	else
		ColorMode=class'UTComp_Settings'.default.PreferredSkinColorRedTeammate;
    
  switch ColorMode
  {
		case 0:
			MakeDMSkin(record, Body, Face);  
			break;
			
		case 1: 
			MakeRedSkin(record, Body, Face); 
			break;
			
		case 2:
			MakeBlueSkin(record, Body, Face); 
			break;
			
		case 3:  
			MakePurpleSkin(record, GetTeamNum(), Body, Face);
			break;
			
		case 4: 
			MakeBrightDMSkin(record, Body, Face);
		  break;
		  
		case 5:
			MakeBrightRedSkin(record, Body, Face);
			break;
               
		case 6:
			MakeBrightBlueSkin(record, Body, Face);
			break;
			
		case 7: 
			MakeBrightPurpleSkin(record, GetTeamNum(), Body, Face);
			break;
  }
  
  Skins[0] = Body;
  Skins[1] = Face;
}

simulated function ChangeToUTCompSkin(xUtil.PlayerRecord record)
{
	local Combiner C;
	local ConstantColor CC;
	local Material NewBodySkin, NewFaceSkin;
	
	GetSkin(record, 255, NewBodySkin, NewFaceSkin);

	C=New(None)Class'Combiner';
	CC=New(None)Class'ConstantColor';
	
	C.CombineOperation=CO_Add;
	C.Material1=CheckSkin(NewBodySkin);
	
	if(PawnIsEnemyOrBlue(class'UTComp_Settings'.default.bEnemyBasedSkins))
		CC.Color=MakeClanSkin(class'UTComp_Settings'.default.BlueEnemyUTCompSkinColor);
	else
		CC.Color=MakeClanSkin(class'UTComp_Settings'.default.RedTeammateUTCompSkinColor);

	SavedColor=CC.Color;
	C.Material2=CC;
	
  Skins[0] = C;
  Skins[1] = NewFaceSkin;
}

simulated function color MakeClanSkin(color PreviousColor)
{
	local int i;
	
  if(UTCompSRI == None || (UTCompSRI.bEnableClanSkins && !PawnIsEnemyOrBlue(true)))
  {
		for(i = 0; i<class'UTComp_Settings'.default.ClanSkins.Length && PlayerReplicationInfo != None; i++)
			if(InStrNonCaseSensitive(PlayerReplicationInfo.PlayerName, class'UTComp_Settings'.default.ClanSkins[i].PlayerName))
			{
				PreviousColor=class'UTComp_Settings'.default.ClanSkins[i].PlayerColor;
				break;
			}
  }
  
  return PreviousColor;
}

simulated static function Material CheckSkin(Material inSkin)
{
	if (FinalBlend(inSkin) != None && FinalBlend(inSkin).Material != None)
		inSkin = FinalBlend(inSkin).Material;
		
	if (Shader(inSkin) != None && Shader(inSkin).Diffuse != None )
		inSkin = Shader(inSkin).Diffuse;
	
	return inSkin;
}

simulated static function GetSkin(xUtil.PlayerRecord rec, byte TeamNum, out Material NewBodySkin, out Material NewFaceSkin)
{
	local string BodySkinName, FaceSkinName;
	local Material TeamFaceSkin;
	
	if (rec.FaceSkinName == "")
		NewFaceSkin = default.Skins[1];
	else
		NewFaceSkin = Material(DynamicLoadObject(rec.FaceSkinName, class'Material'));
	
	if (TeamNum == 255)
		NewBodySkin = Material(DynamicLoadObject(rec.BodySkinName, class'Material'));
	else
	{
		if (rec.BodySkinName == "")
			NewBodySkin = default.Skins[0];
		else
		{	
			if ( (Left(rec.BodySkinName,12) ~= "PlayerSkins.") )
			{
				BodySkinName = "Bright"$rec.BodySkinName$"_"$TeamNum$"B";
				NewBodySkin = Material(DynamicLoadObject(BodySkinName, class'Material',true));
			}
			
			if ( NewBodySkin == None )
			{
				BodySkinName = rec.BodySkinName$"_"$TeamNum;
				NewBodySkin = Material(DynamicLoadObject(BodySkinName, class'Material'));
	
				// allow team head skins with new skins
				if ( rec.TeamFace )
				{
					FaceSkinName = rec.FaceSkinName$"_"$TeamNum;
					TeamFaceSkin = Material(DynamicLoadObject(FaceSkinName, class'Material'));
					if ( TeamFaceSkin != None )
						NewFaceSkin = TeamFaceSkin;
				}
			}
			
			if ( NewBodySkin == None )
			{
				log("TeamSkin not found "$NewBodySkin);
				NewBodySkin = Material(DynamicLoadObject(rec.BodySkinName, class'Material'));
			}
		}
	}
}

simulated static function MakeDMSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{
	GetSkin(record, 255, NewBodySkin, NewFaceSkin);
}

simulated static function MakeRedSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{	
	GetSkin(record, 0, NewBodySkin, NewFaceSkin);
}

simulated static function MakeBlueSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{	
	GetSkin(record, 1, NewBodySkin, NewFaceSkin);
}

simulated static function MakePurpleSkin(xUtil.PlayerRecord record, byte TeamNum, out Material NewBodySkin, out Material NewFaceSkin)
{
	//was too noobish originally
  MakeBrightPurpleSkin(record, TeamNum, NewBodySkin, NewFaceSkin);
}

simulated static function MakeBrightDMSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{
  local Combiner B, F;

	GetSkin(record, 255, NewBodySkin, NewFaceSkin);

	if (Shader(NewBodySkin) == None && FinalBlend(NewBodySkin) == None)
	{
		B=New(None)class'Combiner';
	  B.CombineOperation=CO_Add;
	  B.Material1=NewBodySkin;
	  B.Material2=NewBodySkin;
		
		NewBodySkin = B;
	}
	
	if (Shader(NewFaceSkin) == None && FinalBlend(NewFaceSkin) == None)
	{
		F=New(None)class'Combiner';
	  F.CombineOperation=CO_Add;
	  F.Material1=NewFaceSkin;
	  F.Material2=NewFaceSkin;
		
		NewFaceSkin = F;
	}
}

simulated static function MakeBrightRedSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{
	local Combiner B, F;

	GetSkin(record, 0, NewBodySkin, NewFaceSkin);

	if (Shader(NewBodySkin) == None && FinalBlend(NewBodySkin) == None)
	{
		B=New(None)class'Combiner';
	  B.CombineOperation=CO_Add;
	  B.Material1=NewBodySkin;
	  B.Material2=NewBodySkin;
		
		NewBodySkin = B;
	}
	
	if (Shader(NewFaceSkin) == None && FinalBlend(NewFaceSkin) == None)
	{
		F=New(None)class'Combiner';
	  F.CombineOperation=CO_Add;
	  F.Material1=NewFaceSkin;
	  F.Material2=NewFaceSkin;
		
		NewFaceSkin = F;
	}
}

simulated static function MakeBrightBlueSkin(xUtil.PlayerRecord record, out Material NewBodySkin, out Material NewFaceSkin)
{
	local Combiner B, F;

	GetSkin(record, 1, NewBodySkin, NewFaceSkin);

	if (Shader(NewBodySkin) == None && FinalBlend(NewBodySkin) == None)
	{
		B=New(None)class'Combiner';
	  B.CombineOperation=CO_Add;
	  B.Material1=NewBodySkin;
	  B.Material2=NewBodySkin;
		
		NewBodySkin = B;
	}
	
	if (Shader(NewFaceSkin) == None && FinalBlend(NewFaceSkin) == None)
	{
		F=New(None)class'Combiner';
	  F.CombineOperation=CO_Add;
	  F.Material1=NewFaceSkin;
	  F.Material2=NewFaceSkin;
		
		NewFaceSkin = F;
	}
}

simulated static function MakeBrightPurpleSkin(xUtil.PlayerRecord record, byte TeamNum, out Material NewBodySkin, out Material NewFaceSkin)
{
	local Combiner B, F;
	local Shader S;
  local Material NewBodySkinR, NewFaceSkinR;
	local Material NewBodySkinB, NewFaceSkinB;

	GetSkin(record, 0, NewBodySkinR, NewFaceSkinR);
	GetSkin(record, 1, NewBodySkinB, NewFaceSkinB);

	NewBodySkinR = CheckSkin(NewBodySkinR);
	NewBodySkinB = CheckSkin(NewBodySkinB);
	
  B=New(None)class'Combiner';
  B.CombineOperation=CO_Add;
  
  if (TeamNum == 1)
	{
	  B.Material1=NewBodySkinR;
	  B.Material2=NewBodySkinB;
	}
	else
	{
		B.Material1=NewBodySkinB;
	  B.Material2=NewBodySkinR;
	}
	 
  NewBodySkin = B;	
  
  NewFaceSkinR = CheckSkin(NewFaceSkinR);
	NewFaceSkinB = CheckSkin(NewFaceSkinB);
  
  F=New(None)class'Combiner';
  S=New(None)class'Shader';
  F.CombineOperation=CO_Add;
  
  if (TeamNum == 1)
	{
	  F.Material1=NewFaceSkinR;
	  F.Material2=NewFaceSkinB;
	}
	else
	{
		F.Material1=NewFaceSkinB;
	  F.Material2=NewFaceSkinR;
	}
	
	S.Diffuse=F;
	S.OutputBlending=OB_Masked;
  S.Opacity=NewFaceSkinR;
	 
	NewFaceSkin = S;
}

function ShieldViewFlash(int damage)
{
    local int rnd;

    if (UTComp_xPlayer_BW(Controller) == None || damage == 0)
        return;

    rnd = FClamp(damage / 2, 25, 50);

	UTComp_xPlayer_BW(Controller).ClientDmgFlash( -0.017 * rnd, ShieldFlashV);    
}

function DamageViewFlash(int damage)
{
    local int rnd;

    if (UTComp_xPlayer_BW(Controller) == None || damage == 0)
        return;

    rnd = FClamp(damage / 2, 25, 50);

	UTComp_xPlayer_BW(Controller).ClientDmgFlash( -0.017 * rnd, BloodFlashV);    
}

defaultproperties
{
     ShieldColor=(G=65,R=105)
     LinkColor=(G=100)
     ShockColor=(B=80,R=80)
     LGColor=(B=80,G=40,R=40)
     bEffectsCleared=True
     BrightSkinColors(0)=(A=255)
     BrightSkinColors(1)=(R=200,A=255)
     BrightSkinColors(2)=(B=200,G=64,R=50,A=255)
     BrightSkinColors(3)=(B=200,G=64,R=200,A=255)
     BrightSkinColors(4)=(A=255)
     BrightSkinColors(5)=(R=200,A=255)
     BrightSkinColors(6)=(B=200,G=64,R=50,A=255)
     BrightSkinColors(7)=(B=200,G=64,R=200,A=255)
     WalkingPct=0.800000
     WalkAnims(0)="RunF"
     WalkAnims(1)="RunB"
     WalkAnims(2)="RunL"
     WalkAnims(3)="RunR"
}
