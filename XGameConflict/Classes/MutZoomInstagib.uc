class MutZoomInstaGib extends MutInstaGib;

function bool MutatorIsAllowed()
{
	return true;
}

defaultproperties
{
	AmmoName=ShockAmmo
	AmmoString="xWeapons.ShockAmmo"
	WeaponName=ZoomSuperShockRifle
	WeaponString="xWeapons.ZoomSuperShockRifle"
	DefaultWeaponName="xWeapons.ZoomSuperShockRifle"
	bAllowTranslocator=true

    IconMaterialName="MutatorArt.nosym"
    ConfigMenuClassName=""
    GroupName="Arena"
    FriendlyName="Zoom InstaGib"
    Description="Instant-kill combat with modified Shock Rifles with sniper zooms."
}