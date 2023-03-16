//=============================================================================
// Mut_Ballistic Tactical
//
// Implements Ballistic Tactical style.
//=============================================================================
class Mut_BallisticTactical extends Mut_BallisticStyle
	config(BallisticProV55);

defaultproperties
{
     OverrideStyle=GS_Tactical
	 ConfigMenuClassName="BallisticProV55.MutConfigMenu_Tactical"
     FriendlyName="Ballistic Weapons: Tactical Style"
     Description="Applies the Tactical style of the Ballistic Weapons mod, which replaces the game's weaponset and behaviours with more realistic ones.||This style is based around tactical shooter style play, with slower movement and very high weapon damage.||This style is standardized, and allows only for very limited configuration from the Mutator menu."
}
