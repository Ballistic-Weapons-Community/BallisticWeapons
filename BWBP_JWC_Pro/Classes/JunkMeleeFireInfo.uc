//=============================================================================
// JunkMeleeFireInfo.
//
// Extention of JunkFireInfo to add melee specific info.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkMeleeFireInfo extends JunkFireInfo;

var(Melee)	Range					MeleeRange;					// Range
var(Melee)	int						SwipeHitWallPoint;			// Point in swipepoints list that should be used for wall hits
var(Melee)  array<BallisticMeleeFire.SwipePoint> SwipePoints;	// Rotational offset points used by hit detection to map out a swipe 'curve'
var(Melee)	class<BCImpactManager>	ImpactManager;				// ImpactManger to sue for this fire
var(Melee)	EBreakType				DestroyOn;					// Junk can get destroyed when hit is like this
var(Melee)	EBreakType				MorphOn;					// Junk can morph into MorphJunk when hit is like this
var(Melee)	bool					bUseRunningDamage;			// Calculate damage bonus/attenuation when charging towards/away from enemy.
var(Melee) float					HookStopFactor;				// How much force is applied to counteract victim running. This * Victim.GroundSpeed
var(Melee) float					HookPullForce;				// Velocity amount added to pull victim towards instigator

defaultproperties
{
     ImpactManager=Class'BWBP_JWC_Pro.IM_PipeHitWall'
}
