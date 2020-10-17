class RandomWeaponDummy extends BallisticWeapon;

defaultproperties
{
     InventoryGroup=99
     ItemName="Random Weapon"

     Begin Object Class=RecoilParams Name=RandomWeaponRecoilParams
          PitchFactor=0.000000
          YawFactor=0.000000
     End Object
     RecoilParamsList(0)=RecoilParams'RandomWeaponRecoilParams'
}
