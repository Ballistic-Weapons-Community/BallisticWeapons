class Misc_Pawn extends BallisticPawn;

var Misc_Player MyOwner;

/* brightskins */
var bool bBrightskins;

var Material SavedBody;
var Material OrigBody;
var Combiner Combined;
var ConstantColor SkinColor;
var ConstantColor OverlayColor;

var Color RedColor;
var Color BlueColor;

var byte  OverlayType;
var Color OverlayColors[4];
/* brightskins */


var xEmitter InvisEmitter;

replication
{
    unreliable if(Role == ROLE_Authority)
        OverlayType;   
}

simulated function Destroyed()
{
    if(InvisEmitter != None)
    {
        InvisEmitter.mRegen = false;
        InvisEmitter.Destroy();
        InvisEmitter = None;
    }

    Super.Destroyed();
}

function bool InCurrentCombo()
{
    if(TAM_GRI(Level.GRI) == None || TAM_GRI(Level.GRI).bDisableTeamCombos)
        return Super.InCurrentCombo();
    return false;
}

function GiveWeaponClass(class<Weapon> WeaponClass)
{
    local Weapon NewWeapon;

    if(FindInventoryType(WeaponClass) != None)
        return;

    NewWeapon = Spawn(WeaponClass);
    if(NewWeapon != None)
        NewWeapon.GiveTo(self);
}

// changed to save adren
function RemovePowerups()
{
    local float Adren;

    if(TAM_GRI(Level.GRI) == None || TAM_GRI(Level.GRI).bDisableTeamCombos)
    {
        Super.RemovePowerups();
        return;
    }

    if(Controller != None && Misc_DynCombo(CurrentCombo) != None)
    {
        Adren = Controller.Adrenaline;
        Super.RemovePowerups();
        Controller.Adrenaline = Adren; 

        return;
    }

    Super.RemovePowerups();
}

// 75% armor absorbtion rate
function int ShieldAbsorb(int dam)
{
    local float Shield;

    if(ShieldStrength == 0)
        return dam;

    SetOverlayMaterial(ShieldHitMat, ShieldHitMatTime, false);
    PlaySound(Sound'WeaponSounds.ArmorHit', SLOT_Pain, 2 * TransientSoundVolume,, 400);

    Shield = ShieldStrength - (dam * 0.75 + 0.5);
    dam *= 0.25;
    if(Shield < 0)
    {
        dam += -(Shield);
        Shield = 0;
    }

    ShieldStrength = Shield;
    return dam;
}

simulated function SetOverlayMaterial(Material mat, float time, bool bOverride)
{
    if(mat == None)
        OverlayType = 0;
    else if(mat == ShieldHitMat)
    {
        OverlayType = 1;
        SetTimer(ShieldHitMatTime, false);
    }
    else if(OverlayType != 1)
    {
        if(mat == Shader'XGameShaders.PlayerShaders.LightningHit')
            OverlayType = 2;
        else if(mat == Shader'UT2004Weapons.Shaders.ShockHitShader')
            OverlayType = 3;
        else if(mat == Shader'XGameShaders.PlayerShaders.LinkHit')
            OverlayType = 4;   

        SetTimer(ShieldHitMatTime, false);
    }

    Super.SetOverlayMaterial(mat, time, bOverride);
}

/* brightskins related */
/* copied from a recent xpawn patch version.
   needed to stop GPFs in older versions. */
simulated function bool CheckValidFemaleDefault()
{
	return ( (PlacedFemaleCharacterName ~= "Tamika")
			|| (PlacedFemaleCharacterName ~= "Sapphire")
			|| (PlacedFemaleCharacterName ~= "Enigma")
			|| (PlacedFemaleCharacterName ~= "Cathode")
			|| (PlacedFemaleCharacterName ~= "Rylisa")
			|| (PlacedFemaleCharacterName ~= "Ophelia")
			|| (PlacedFemaleCharacterName ~= "Zarina") 
            || (PlacedFemaleCharacterName ~= "Nebri")
            || (PlacedFemaleCharacterName ~= "Subversa")
            || (PlacedFemaleCharacterName ~= "Diva") );
}

simulated function bool CheckValidMaleDefault()
{
	return ( (PlacedCharacterName ~= "Jakob")
			|| (PlacedCharacterName ~= "Gorge")
			|| (PlacedCharacterName ~= "Malcolm")
			|| (PlacedCharacterName ~= "Xan")
			|| (PlacedCharacterName ~= "Brock")
			|| (PlacedCharacterName ~= "Gaargod")
			|| (PlacedCharacterName ~= "Axon")
            || (PlacedCharacterName ~= "Barktooth")
            || (PlacedCharacterName ~= "Torch")
            || (PlacedCharacterName ~= "WidowMaker") );
}
/*
*/

simulated function string CheckAndGetCharacter()
{
    if(!CheckValidFemaleDefault() && !CheckValidMaleDefault())
    {
        if(!CheckValidFemaleDefault())
            PlacedFemaleCharacterName = "Rylisa";
        if(!CheckValidMaleDefault())
            PlacedCharacterName = "Gorge";
    }

    if(PlayerReplicationInfo != None && PlayerReplicationInfo.bIsFemale)
        return PlacedFemaleCharacterName;
    else
        return PlacedCharacterName;
}

simulated function string GetDefaultCharacter()
{
    local PlayerController P;
    local int MyTeam;
    local int OwnerTeam;
	
    if(!class'Misc_Player'.default.bForceRedEnemyModel && !class'Misc_Player'.default.bForceBlueAllyModel)
        return Super.GetDefaultCharacter();

    MyTeam = GetTeamNum();
    if(MyTeam == 255)
        return CheckAndGetCharacter();

    P = Level.GetLocalPlayerController();
    if(P != None || P.PlayerReplicationInfo != None)
    {
        OwnerTeam = P.GetTeamNum();

        if(class'Misc_Player'.default.bUseTeamModels || OwnerTeam == 255)
        {
            if(MyTeam == 1)
            {
                if(class'Misc_Player'.default.bForceBlueAllyModel)
                {
                    PlacedCharacterName = class'Misc_Player'.default.BlueAllyModel;
                    PlacedFemaleCharacterName = class'Misc_Player'.default.BlueAllyModel;
                }
                else
                    return CheckAndGetCharacter();
            }
            else
            {
                if(class'Misc_Player'.default.bForceRedEnemyModel)
                {
                    PlacedCharacterName = class'Misc_Player'.default.RedEnemyModel;
                    PlacedFemaleCharacterName = class'Misc_Player'.default.RedEnemyModel;
                }
                else
                    return CheckAndGetCharacter();
            }
        }
        else if(!class'Misc_Player'.default.bUseTeamModels)
        {
            if(MyTeam == OwnerTeam)
            {
                if(class'Misc_Player'.default.bForceBlueAllyModel)
                {
                    PlacedCharacterName = class'Misc_Player'.default.BlueAllyModel;
                    PlacedFemaleCharacterName = class'Misc_Player'.default.BlueAllyModel;
                }
                else
                    return CheckAndGetCharacter();
            }
            else
            {
                if(class'Misc_Player'.default.bForceRedEnemyModel)
                {
                    PlacedCharacterName = class'Misc_Player'.default.RedEnemyModel;
                    PlacedFemaleCharacterName = class'Misc_Player'.default.RedEnemyModel;
                }
                else
                    return CheckAndGetCharacter();
            }
        }
    }

    return CheckAndGetCharacter();
}

simulated function bool ForceDefaultCharacter()
{
	local PlayerController P;
    local int MyTeam;
    local int OwnerTeam;
	
    if(!class'Misc_Player'.default.bForceRedEnemyModel && !class'Misc_Player'.default.bForceBlueAllyModel)
        return Super.ForceDefaultCharacter();

    MyTeam = GetTeamNum();
    if(MyTeam == 255)
        return Super.ForceDefaultCharacter();

    P = Level.GetLocalPlayerController();
    if(P != None || P.PlayerReplicationInfo != None)
    {
        OwnerTeam = P.GetTeamNum();

        if(class'Misc_Player'.default.bUseTeamModels || OwnerTeam == 255)
        {
            if(MyTeam == 1)
                return class'Misc_Player'.default.bForceBlueAllyModel;
            else
                return class'Misc_Player'.default.bForceRedEnemyModel;
        }
        else if(!class'Misc_Player'.default.bUseTeamModels)
        {
            if(MyTeam == OwnerTeam)
                return class'Misc_Player'.default.bForceBlueAllyModel;
            else
                return class'Misc_Player'.default.bForceRedEnemyModel;
        }
    }

    return true;
}

simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
	local PlayerController p;
	
	//Exclude Matrix because it's cheap.
	if ( (rec.Species == None) || ForceDefaultCharacter())
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
	
	else
	{
		switch(PlayerReplicationInfo.CharacterName)
		{
			case "Abaddon": rec = class'xUtil'.static.FindPlayerRecord("AbaddonB"); break;
			case "Jakob": rec = class'xUtil'.static.FindPlayerRecord("JakobB"); break;
			case "Kaela": rec = class'xUtil'.static.FindPlayerRecord("KaelaB"); break;
			case "Zarina": rec = class'xUtil'.static.FindPlayerRecord("ZarinaB"); break;
			case "Matrix": rec = class'xUtil'.static.FindPlayerRecord("Enigma");
		}
	}

	Species = rec.Species;
	RagdollOverride = rec.Ragdoll;
	if ( !Species.static.Setup(self,rec) )
	{
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
		switch(rec.DefaultName)
		{
			case "Abaddon": rec = class'xUtil'.static.FindPlayerRecord("AbaddonB"); break;
			case "Jakob": rec = class'xUtil'.static.FindPlayerRecord("JakobB"); break;
			case "Kaela": rec = class'xUtil'.static.FindPlayerRecord("KaelaB"); break;
			case "Zarina": rec = class'xUtil'.static.FindPlayerRecord("ZarinaB"); break;
			case "Matrix": rec = class'xUtil'.static.FindPlayerRecord("Enigma");
		}
		if ( !Species.static.Setup(self,rec) )
			return;
	}
	
	ResetPhysicsBasedAnim();
	
	// Brighten July a bit
	if (rec.DefaultName == "July")
		AmbientGlow = 64;
	
	if(Level.NetMode==NM_DedicatedServer)
		return;

    p = Level.GetLocalPlayerController();
    if(p == None)
        return;

    bNoCoronas = true;

    if(MyOwner == None)
    {
		MyOwner = Misc_Player(p);

	    if(MyOwner == None)
		    return;
    }  
    
  //setup blood set
  BloodSet = class'BWBloodSetHunter'.static.GetBloodSetFor(self); 
}

simulated function RemoveFlamingEffects()
{
    local int i;

    if( Level.NetMode == NM_DedicatedServer )
        return;

    for(i = 0; i < Attached.length; i++)
    {
        if(Attached[i].IsA('xEmitter') && !Attached[i].IsA('BloodJet') 
            && !Attached[i].IsA('Emitter_SeeInvis') && !Attached[i].IsA('SpeedTrail')
            && !Attached[i].IsA('RegenCrosses') && !Attached[i].IsA('OffensiveEffect'))
        {
            xEmitter(Attached[i]).mRegen = false;
        }
    }
}

simulated function Tick(float DeltaTime)
{
    Super.Tick(DeltaTime);

    if(Level.NetMode == NM_DedicatedServer)
        return;

    if(MyOwner == None)
        MyOwner = Misc_Player(Level.GetLocalPlayerController());

    if(MyOwner != None)
    {
        if(bInvis)
        {
            if(MyOwner.bSeeInvis)
            {
                if(InvisEmitter == None)
                    InvisEmitter = Spawn(class'Emitter_SeeInvis', self,, Location, Rotation);
                AttachToBone(InvisEmitter, 'spine');
            }
            else if(InvisEmitter != None)
            {
                DetachFromBone(InvisEmitter);
                InvisEmitter.mRegen = false;
                InvisEmitter.Destroy();
                InvisEmitter = None;
            }

            return;
        }
        else if(InvisEmitter != None)
        {
            DetachFromBone(InvisEmitter);
            InvisEmitter.mRegen = false;
            InvisEmitter.Destroy();
            InvisEmitter = None;
        }
    }
    else if(bInvis)
        return;

    if(bPlayedDeath)
		return;
}

simulated function Material GetSkin()
{
    local Material TempSkin;
   	local string Skin;

	if(SavedBody != None)
		return SavedBody;

    Skin = String(Skins[0]);

    if(Right(Skin, 2) == "_0" || Right(Skin, 2) == "_1")
    {
        Skin = Left(Skin, Len(Skin) - 2);
    }
    else if(Right(Skin, 3) == "_0B" || Right(Skin, 3) == "_1B")
    {
        Skin = Right(Skin, Len(Skin) - 6);
        Skin = Left(Skin, Len(Skin) - 3);
    }

   	TempSkin = Material(DynamicLoadObject(Skin, class'Material', true));

    if(TempSkin == None)
        TempSkin = Skins[0];

	SavedBody = TempSkin;
	return SavedBody;
}

simulated function SetOverlaySkin()
{
    OverlayColor.Color = OverlayColors[OverlayType - 1];

    Combined.Material1 = GetSkin();
    Combined.Material2 = OverlayColor;
    Skins[0] = Combined;
}

function Timer()
{
    OverlayType = 0;
}
/* brightskins related */

defaultproperties
{
     RedColor=(R=100)
     BlueColor=(B=100,G=25)
     OverlayColors(0)=(G=80,R=128,A=128)
     OverlayColors(1)=(B=128,G=96,R=64,A=128)
     OverlayColors(2)=(B=110,R=80,A=128)
     OverlayColors(3)=(B=64,G=128,R=64,A=128)
     ShieldHitMatTime=0.350000
     RequiredEquipment(0)="XWeapons.ShieldGun"
     RequiredEquipment(1)=""
     bNoWeaponFiring=True
}
