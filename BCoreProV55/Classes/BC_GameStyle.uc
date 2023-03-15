//=============================================================================
// BC_GameStyle
//
// Stores the parameters which are specific to a certain game style. Applies 
// these to the BallisticReplicationInfo, which thereafter serves as the 
// source of this information in the game.
//
// by Azarael
//=============================================================================
class BC_GameStyle extends Object
    abstract
	config(BallisticProV55);

enum EGameStyle
{
	GS_Pro,		// BallisticPro: fast arena-type gameplay
	GS_Classic,	// BallisticV25: classic gameplay
	GS_Realism,	// Kab
	GS_Tactical	// Slower, more tactical gameplay
};

var EGameStyle  		Index;
var string				StyleName;
var bool				bHasFineConfig;

//=============================================================================
// CONFIG VARIABLES
//=============================================================================	
var() config float		AccuracyScale;			    // Scales weapon sway
var() config float		DamageScale;				// Scales weapon damage
var() config float		RecoilScale;			    // Scales weapon recoil

final function InitializeReplicationInfo(BallisticReplicationInfo rep)
{
	rep.GameStyle 		= Index;

	rep.AccuracyScale	= AccuracyScale;
	rep.DamageScale		= DamageScale;
	rep.RecoilScale		= RecoilScale;

	// style-specific properties here
	FillReplicationInfo(rep);

	rep.BindDefaults();
}

protected function FillReplicationInfo(BallisticReplicationInfo rep);

defaultproperties
{
    Index=GS_Arena
	StyleName="Pro"
	bHasFineConfig=False

	AccuracyScale=1.0f
	DamageScale=1.0f
    RecoilScale=1.0f
}