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
	
	RecoilScale=0.50
	RecoilShotScale=1

	bRunInADS=False
	bForceViewShake=True
	SightBobScale=0.5f

	MaxInventoryCapacity=12

	ConflictWeaponSlots=10
	ConflictEquipmentSlots=2

	bWeaponJumpOffsetting=True
	bLongWeaponOffsetting=False
	bNoReloading=False
	bAlternativePickups=False

    bBrightPlayers=True
	bUniversalMineLights=False

	bHealthRegeneration=False
	StartingHealth=100
	PlayerHealthMax=100
	PlayerSuperHealthMax=100

	bShieldRegeneration=False
	StartingShield=50
	PlayerShieldMax=50

	bPlayerDeceleration=True
	bAllowDodging=True
	bAllowDoubleJump=False
	PlayerStrafeScale=1
	PlayerBackpedalScale=1
	PlayerGroundSpeed=210
	PlayerAnimationGroundSpeed=270
	PlayerAirSpeed=210
	PlayerAccelRate=2048
	PlayerJumpZ=294
	PlayerDodgeSpeedFactor=1.35
	PlayerDodgeZ=170

	PlayerWalkSpeedFactor=0.6f
	PlayerCrouchSpeedFactor=0.35f

	bEnableSprint=True
	StaminaChargeRate=25
	StaminaDrainRate=20
	SprintSpeedFactor=1.4f
	JumpDrain=10

	HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=25
	KillRewardShieldMax=50
}