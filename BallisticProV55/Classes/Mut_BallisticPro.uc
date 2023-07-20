//=============================================================================
// Mut_BallisticPro
//
// Implements Ballistic Pro style.
//=============================================================================
class Mut_BallisticPro extends Mut_BallisticStyle
	config(BallisticProV55);

defaultproperties
{
     OverrideStyle=GS_Pro
	 ConfigMenuClassName="BallisticProV55.MutConfigMenu_Pro"
     FriendlyName="Ballistic Weapons: Pro Style"
     Description="Applies the Pro style of the Ballistic Weapons mod, which replaces the game's weaponset and behaviours with more realistic ones.||This style is based around faster-paced arena shooter style play, with weapon balancing, sprint boost dodging, strong hipfire mechanics and a higher time to kill.||This style is standardized, and allows only for very limited configuration from the Mutator menu."
}
