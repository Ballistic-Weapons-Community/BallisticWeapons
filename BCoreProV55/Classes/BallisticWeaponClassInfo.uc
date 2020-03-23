class BallisticWeaponClassInfo extends Object;

const NUM_CLASSES = 11;

var() localized string  Headings[12];
var() localized string  ClassDescriptions[NUM_CLASSES];

static function String GetHeading (int i)
{
	if (i == 0)
        return default.Headings[9];
        
	return default.Headings[i-1];
}

static function string GetClassDescription(string category)
{
    local int i;

    for ( i = 0; i < 10; ++i)
    {
        if (category ~= default.Headings[i])
            return default.ClassDescriptions[i+1];
    }

    return "";
}

defaultproperties
{
    Headings(0)="Melee"
    Headings(1)="Sidearms"
    Headings(2)="Sub Machineguns"
    Headings(3)="Assault Rifles"
    Headings(4)="Energy Weapons"
    Headings(5)="Heavy Machineguns"
    Headings(6)="Shotguns"
    Headings(7)="Ordnance"
    Headings(8)="Sniper Rifles"
    Headings(9)="Grenades"
    Headings(10)="Miscellaneous"
    Headings(11)="Non-BW"

    ClassDescriptions(0)="Generally powerful explosive or area-effect weapons with very limited supply.||Most grenades have a pin which can be pulled with the Weapon Special or Reload key before firing, which will begin the fuse countdown."
    ClassDescriptions(1)="Optimized for very close combat, these weapons grant a 15% move speed bonus, are generally quick to switch to, and their attacks are capable of locking down enemies using ranged weapons, preventing them from firing for a short period of time.||Swinging a melee weapon is tiring, and you will begin to swing more slowly after a while. Your level of fatigue with a melee weapon is shown by the charge bar at the lower right of the HUD.||Many melee weapons can block melee attacks when holding the Weapon Special key."
    ClassDescriptions(2)="Sidearm-class weapons are quick to switch to, can be aimed very quickly, and generally have good hip fire properties. They are less affected by the lockdown of melee weapons, and have no speed penalty when aimed.||However, as they are smaller than full size weapons, they have particular drawbacks,such as lower damage output, lower range, smaller magazine size or unfavourable recoil properties."
    ClassDescriptions(3)="Personal defense weapons are intended for close combat. They can be aimed quickly and deal good damage, but are ineffective outside of close range.||Submachine guns are very controllable with strong hipfire.||Machine pistols have even higher damage output, but sacrifice controllability and effective range." 
    ClassDescriptions(4)="Assault rifles are generally effective at mid range, with good surface penetration abilities. Assault rifles also have a versatile range of secondary fire modes.||However, aiming time is longer than lighter weapons, and they are less controllable when hipfired."
    ClassDescriptions(5)="Energy weapons encompass a broad range of weaponry, from instant-hit laser rifles to plasma-based projectile weapons.||Energy weapons usually have very low recoil and additional damage mechanics, such as gaining damage over range or heating up the target to do additional damage with successive shots.||However, energy weapons do not penetrate surfaces."
    ClassDescriptions(6)="Machine guns and miniguns deal heavy damage with strong wall penetration abilities, and have large magazines or belt feeds. Due to their weight, they also have favourable recoil properties.||Weapons in this class reduce the wielder's movement speed and take a long time to aim. Hipfire is also very poor."
    ClassDescriptions(7)="Shotguns inflict heavy damage in a single shot and tend to be very accurate when aimed. More compact shotguns aim more quickly at the cost of effective range, while full-size shotguns have good range, but take time to aim. All shotguns have weak hip firing abilities, and many can only be reloaded one shell at a time."
    ClassDescriptions(8)="Ordnance weapons use explosive damage to accomplish their goals. Their high damage and explosions are very powerful against groups of enemies, and their explosions will damage targets through walls, but they are generally projectile attacks and require accuracy to use against single targets."
    ClassDescriptions(9)="Sniper rifles come in two varieties, scoped and unscoped. Unscoped rifles have better hipfire and aiming time, but have a shorter effective range and may be more difficult to use at long range. Scoped rifles have a very long range, and their powerful hits can temporarily prevent an enemy from firing, but they require a long time to aim."
    ClassDescriptions(10)="Generally powerful explosive or area-effect weapons with very limited supply.||Most grenades have a pin which can be pulled with the Weapon Special or Reload key before firing, which will begin the fuse countdown."
}
    

