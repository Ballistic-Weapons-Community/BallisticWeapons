class TargetDesignatorWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{    
    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

    Begin Object Class=AimParams Name=UniversalAimParams
        ViewBindFactor=0.00
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

    Begin Object Class=WeaponParams Name=UniversalParams
        PlayerSpeedFactor=1.150000
        MagAmmo=1
        InventorySize=24
        ZoomType=ZT_Smooth
		//WeaponModes(0)=(ModeName="AIM-9 Missiles",ModeID="WM_FullAuto")
		//WeaponModes(1)=(ModeName="Carpet Bombing",ModeID="WM_FullAuto")
		//WeaponModes(2)=(ModeName="CBU-30 Chemical Cluster Bomb")
		//WeaponModes(3)=(ModeName="CBU-58 Incendiary Cluster Bomb",ModeID="WM_FullAuto")
		//WeaponModes(4)=(ModeName="CBU-72 Cluster Bomb",ModeID="WM_FullAuto")
		//WeaponModes(5)=(ModeName="CBU-100 Cluster Bomb",ModeID="WM_FullAuto")
		//WeaponModes(6)=(ModeName="GBU-57 MOP",ModeID="WM_FullAuto")
		//WeaponModes(7)=(ModeName="AGM-154 JSOW",ModeID="WM_FullAuto")
		//WeaponModes(8)=(ModeName="MC1 Chemical Bomb",ModeID="WM_FullAuto")
		//WeaponModes(9)=(ModeName="MK-77 Incendiary Bomb",ModeID="WM_FullAuto")
		//WeaponModes(10)=(ModeName="MLRS Rocket Barrage",ModeID="WM_FullAuto")
		//WeaponModes(11)=(ModeName="Napalm Carpet Bombing",ModeID="WM_FullAuto")
		//WeaponModes(12)=(ModeName="BLU-82 'Daisy Cutter'",ModeID="WM_FullAuto")
		//WeaponModes(13)=(ModeName="BLU-96 Fuel-Air Bomb",ModeID="WM_FullAuto")
		//WeaponModes(14)=(ModeName="GBU-38 500lb JDAM",ModeID="WM_FullAuto")
		//WeaponModes(15)=(ModeName="GBU-43 MOAB",ModeID="WM_FullAuto")
		//WeaponModes(16)=(ModeName="LUU-4 Illumination Flare",ModeID="WM_FullAuto")
		//WeaponModes(17)=(ModeName="W54 Nuclear Warhead",ModeID="WM_FullAuto")
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}