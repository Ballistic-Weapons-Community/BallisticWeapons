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
	StyleName="Tactical"
	
	RecoilScale=0.75
	RecoilShotScale=1

	bRunInADS=False

	MaxInventoryCapacity=12

	ConflictWeaponSlots=10
	ConflictEquipmentSlots=2

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bNoReloading=False
	bAlternativePickups=False

    bBrightPlayers=False
	bUniversalMineLights=False

	bHealthRegeneration=False
	StartingHealth=100
	PlayerHealthMax=100
	PlayerSuperHealthMax=100

	bShieldRegeneration=False
	StartingShield=25
	PlayerShieldMax=25

	bPlayerDeceleration=True
	bAllowDodging=True
	bAllowDoubleJump=False
	PlayerStrafeScale=1
	PlayerBackpedalScale=1
	PlayerGroundSpeed=210
	PlayerAnimationGroundSpeed=270
	PlayerAirSpeed=210
	PlayerAccelRate=1536
	PlayerJumpZ=294
	PlayerDodgeZ=170

	PlayerWalkSpeedFactor=0.6f
	PlayerCrouchSpeedFactor=0.35f

	bEnableSprint=True
	StaminaChargeRate=5
	StaminaDrainRate=5
	SprintSpeedFactor=1.5f
	JumpDrain=10

	HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=25
	KillRewardShieldMax=25
}