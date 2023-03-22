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
	
	RecoilScale=0.8 // 0.6 with no scaling is about right
	RecoilShotScale=0.625 // move penalty will do the rest

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

	PlayerWalkSpeedFactor=0.75f
	PlayerCrouchSpeedFactor=0.33f

	bEnableSprint=True
	StaminaChargeRate=5
	StaminaDrainRate=5
	SprintSpeedFactor=1.5f
	JumpDrainFactor=2

	HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=25
	KillRewardShieldMax=25
}