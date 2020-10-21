class RandomWeaponDummy extends BallisticWeapon;

defaultproperties
{
     InventoryGroup=99
     ItemName="Random Weapon"

     Begin Object Class=RecoilParams Name=DummyRecoilParams
          PitchFactor=0.000000
          YawFactor=0.000000
     End Object
     RecoilParamsList(0)=RecoilParams'DummyRecoilParams'

     Begin Object Class=AimParams Name=DummyAimParams
     End Object
     AimParamsList(0)=AimParams'DummyAimParams'
}
