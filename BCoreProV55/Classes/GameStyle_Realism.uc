//=============================================================================
// GameStyle_Realism
//
// Defines the Ballistic Realism game style.
//=============================================================================
class GameStyle_Realism extends BC_GameStyle_Config
	config(BallisticProV55);

defaultproperties
{	
	Index=GS_Realism
	StyleName="Realism"
	bRunInADS=False
	SightBobScale=1f

	MaxInventoryCapacity=0

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=True
	bNoReloading=False
	bAlternativePickups=True

    bBrightPlayers=False
	bUniversalMineLights=False

	bHealthRegeneration=False
	StartingHealth=100
	PlayerHealthMax=100
	PlayerSuperHealthMax=200

	bShieldRegeneration=False
	StartingShield=50
	PlayerShieldMax=100

	bPlayerDeceleration=True
	bAllowDodging=True
	bAllowDoubleJump=False
	PlayerStrafeScale=1
	PlayerBackpedalScale=1
	PlayerGroundSpeed=200
	PlayerAnimationGroundSpeed=260
	PlayerAirSpeed=200
	PlayerAccelRate=1536
	PlayerJumpZ=294
	PlayerDodgeSpeedFactor=1.5
	PlayerDodgeZ=170

	PlayerWalkSpeedFactor=0.5f
	PlayerCrouchSpeedFactor=0.35f

	bEnableSprint=true
	StaminaChargeRate=10
	StaminaDrainRate=10
	SprintSpeedFactor=1.4f
	JumpDrain=2

	HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=0
	KillRewardShieldMax=0
}