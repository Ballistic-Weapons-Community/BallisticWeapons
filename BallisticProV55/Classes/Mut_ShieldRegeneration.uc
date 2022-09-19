//=============================================================================
// Mut_ShieldRegeneration.
//
// Periodically restores shield to players.
// Also adds a rules class that awards a health bonus for killing players.
//=============================================================================
class Mut_ShieldRegeneration extends Mutator
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var globalconfig bool     	bUseShieldRegen;
var globalconfig float		RegenRate;			// Amount of time between restoring 'RegenAmount' health to players.
var globalconfig int		RegenAmount;		// How much health to restore every 'RegenRate'.
var globalconfig float		RegenDelay;			// Amount of time between a player being damaged and the regeneration starting.
var globalconfig int		ShieldCap;			// The maximum amount of health a player can regenerate.

event Timer()
{
	local int i, MaxShield;
    local Controller C;
    local xPawn P;

	if (!bUseShieldRegen)
        return;

    for (i = 0; i < Level.GRI.PRIArray.Length; i++)
    {
        if(Level.GRI.PRIArray[i] == None)
            continue;
        
        C = Controller(Level.GRI.PRIArray[i].Owner);
        
        if (C == None)
            continue;

        P = xPawn(C.Pawn);

        if (P == None || P.LastDamagedTime < (Level.TimeSeconds - RegenDelay))
            continue;

        MaxShield = FMin(ShieldCap, P.ShieldStrengthMax);
        
        if (MaxShield > P.ShieldStrength)
            P.AddShieldStrength(Clamp(MaxShield - P.ShieldStrength, 0, RegenAmount));
    }
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if (bUseShieldRegen)
	{
		SetTimer(RegenRate, true);

		if(!bDeleteMe)
			Level.Game.AddGameModifier(Spawn(class'Rules_Regen'));
	}
}

defaultproperties
{
     bUseShieldRegen=True
	 RegenRate=1.000000
     RegenAmount=10
     RegenDelay=4.000000
     ShieldCap=100
     FriendlyName="BallisticPro: Shield Regeneration"
     Description="Players will periodically regenerate shields.||http://www.runestorm.com"
}
