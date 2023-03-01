//=============================================================================
// M46AssaultRifleQS.
// 
// Red dot M46.
//=============================================================================
class M46AssaultRifleQS extends M46AssaultRifle HideDropDown CacheExempt;

defaultproperties
{
    LayoutIndex=1
    FullZoomFOV=80.000000
    SightDisplayFOV=25.000000
	ParamsClasses(0)=Class'M46WeaponParams'
	ParamsClasses(1)=Class'M46WeaponParamsClassic' 
	ParamsClasses(2)=Class'M46WeaponParamsRealistic' 
    ParamsClasses(3)=Class'M46WeaponParamsTactical'
    FireModeClass(0)=Class'BallisticProV55.M46PrimaryFireQS'
    FireModeClass(1)=Class'BallisticProV55.M46SecondaryFireQS'
    GroupOffset=2
    PickupClass=Class'BallisticProV55.M46PickupQS'
    AttachmentClass=Class'BallisticProV55.M46AttachmentQS'
    ItemName="M46 Red Dot Sight"
}
