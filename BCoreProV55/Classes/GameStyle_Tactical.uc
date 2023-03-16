//=============================================================================
// GameStyle_Tactical
//
// Defines the Ballistic Tactical game style.
//=============================================================================
class GameStyle_Tactical extends BC_GameStyle_Fixed
	config(BallisticProV55);

defaultproperties
{
	Index=GS_Tactical
	Name="Tactical"
	RecoilScale=0.8

	bRunInADS=True

	MaxInventoryCapacity=12

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bNoReloading=False
	bAlternativePickups=False

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
	PlayerAirSpeed=200
	PlayerAccelRate=1536
	PlayerJumpZ=294
	PlayerDodgeZ=170

	PlayerWalkSpeedFactor=0.85f
	PlayerCrouchSpeedFactor=0.45f

	bEnableSprint=true
	StaminaChargeRate=5
	StaminaDrainRate=5
	SprintSpeedFactor=1.5f
	JumpDrainFactor=2

	HealthKillReward=25
	KillRewardHealthMax=100
	ShieldKillReward=0
	KillRewardShieldMax=0
}