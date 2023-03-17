//=============================================================================
// GameStyle_Pro
//
// Defines the Ballistic Pro game style.
//=============================================================================
class GameStyle_Pro extends BC_GameStyle_Fixed
	config(BallisticProV55);

defaultproperties
{
	Index=GS_Pro
	StyleName="Pro"

	DamageScale=1.25
	RecoilScale=0.7
	bRunInADS=True

	// General
	MaxInventoryCapacity=12
    bAlternativePickups=False
	bUniversalMineLights=True

	// Pawn
	bBrightPlayers=True

    StartingHealth=100
    PlayerHealthMax=100
    PlayerSuperHealthMax=200
	bShieldRegeneration=True
    StartingShield=100
	PlayerShieldMax=200

	// Movement
	bPlayerDeceleration=False
	bAllowDodging=True
	bAllowDoubleJump=True
	// this value is a fallback which is overridden by weapon ADS move factor,
	// and should be the highest possible ADS movement multiplier for your style
    PlayerWalkSpeedFactor=0.9
	PlayerCrouchSpeedFactor=0.45
    PlayerStrafeScale=1
    PlayerBackpedalScale=1
    PlayerGroundSpeed=260.000000
	PlayerAnimationGroundSpeed=340
    PlayerAirSpeed=260.000000
    PlayerAccelRate=2048.000000
    PlayerJumpZ=294
    PlayerDodgeZ=210

	bEnableSprint=true
	StaminaChargeRate=25
	StaminaDrainRate=20
	SprintSpeedFactor=1.5f
	JumpDrainFactor=2

    HealthKillReward=25
	KillRewardHealthMax=100
	ShieldKillReward=0
	KillRewardShieldMax=0
}