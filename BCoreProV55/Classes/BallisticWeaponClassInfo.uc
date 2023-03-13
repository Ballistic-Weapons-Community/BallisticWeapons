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
    Headings(1)="Handguns"
    Headings(2)="SMGs & PDWs"
    Headings(3)="Assault Rifles"
    Headings(4)="Energy Weapons"
    Headings(5)="Machineguns"
    Headings(6)="Shotguns"
    Headings(7)="Ordnance"
    Headings(8)="Sniper Rifles"
    Headings(9)="Grenades"
    Headings(10)="Miscellaneous"
    Headings(11)="Non-BW"

    ClassDescriptions(0)="Generally powerful explosive or area-effect weapons with very limited supply.||Most grenades have a pin which can be pulled with the Weapon Special or Reload key before firing, which will begin the fuse countdown."
    ClassDescriptions(1)="Optimized for very close combat, these weapons are generally quick to switch to, and their attacks are capable of locking down enemies using ranged weapons, preventing them from firing for a short period of time.||Swinging a melee weapon is tiring, and you will begin to swing more slowly after a while. Your level of fatigue with a melee weapon is shown by the charge bar at the lower right of the HUD.||Many melee weapons can block melee attacks when holding the Weapon Special key."
    ClassDescriptions(2)="Handguns weapons are quick to switch to, can be aimed very quickly with good movement speed, and generally have good point shooting properties. They are less affected by the lockdown of melee weapons, and have no speed penalty when aimed.||However, as they are smaller than full size weapons, they have particular drawbacks,such as lower damage output, lower range, smaller magazine size or unfavourable recoil properties."
    ClassDescriptions(3)="Sub machineguns and personal defense weapons are intended for close combat. They can be aimed quickly with good movement speed, deal good damage and are effective when shoulder fired, but are ineffective outside of close range.||Submachine guns provide very controllable automatic fire.||Machine pistols consume less inventory space, but sacrifice effective range and controllability." 
    ClassDescriptions(4)="Assault rifles are generally effective at mid range, with good surface penetration abilities. Assault rifles also have a versatile range of secondary fire modes.||However, aiming time is longer than lighter weapons, and they are less controllable when shoulder fired."
    ClassDescriptions(5)="Energy weapons encompass a broad range of weaponry, from instant-hit laser rifles to plasma-based projectile weapons.||Energy weapons usually have very low recoil and additional damage mechanics, such as gaining damage over range or heating up the target to do additional damage with successive shots.||However, energy weapons do not penetrate surfaces."
    ClassDescriptions(6)="Machineguns and miniguns deal heavy damage with strong wall penetration abilities, and have large magazines or belt feeds. Due to their weight, they also have favourable recoil properties.||Weapons in this class are unwieldy, and reduce the wielder's movement speed. They also take a long time to aim and are more difficult to keep on target."
    ClassDescriptions(7)="Shotguns inflict heavy damage in a single shot. All shotguns choke their spread when aimed. More compact shotguns have stronger hip fire capability at the cost of range, while full-size shotguns have good range, but take time to aim. Many shotguns can only be reloaded one shell at a time."
    ClassDescriptions(8)="Ordnance weapons use explosive damage to accomplish their goals. Their high damage and explosions are very powerful against groups of enemies, and their explosions will damage targets through walls, but they are generally projectile attacks and require accuracy to use against single targets."
    ClassDescriptions(9)="Sniper rifles come in two varieties, scoped and unscoped. Unscoped rifles have better shoulder fire, can be aimed more quickly and can be moved with more quickly while aiming, but have a shorter effective range and may be more difficult to use at long range. Scoped rifles have a very long range, and their powerful hits can temporarily prevent an enemy from firing, but they require a long time to aim and movement is slow while aiming."
    ClassDescriptions(10)="Generally powerful explosive or area-effect weapons with very limited supply.||Most grenades have a pin which can be pulled with the Weapon Special or Reload key before firing, which will begin the fuse countdown."
}
    

