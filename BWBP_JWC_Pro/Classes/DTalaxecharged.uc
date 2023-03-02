//=============================================================================
// DTalaxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTalaxecharged extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o stood next to %k and got killed by %kh exploding axe."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=None
     DeathString="%o got disintegrated by %k."
     FemaleSuicide="%o got killed by an exploding alien axe."
     MaleSuicide="%o got killed by an exploding alien axe"
     bAlwaysGibs=True
     bNeverSevers=False
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
}
