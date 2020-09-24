//=============================================================================
// DTEKS43KatanaHead.
//
// Damagetype for EKS43 Katana head slices
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTEKS43KatanaHead extends DTEKS43Katana;

defaultproperties
{
     DeathStrings(0)="%k lifted off %o's head with %kh katana."
     DeathStrings(1)="%k ran %kh sword across %o's eyeballs."
     DeathStrings(2)="%o's melon was removed by %k's sword."
     DeathStrings(3)="%o got %vh head destroyed by %k's EKS43."
     bHeaddie=True
     DeathString="%k lifted off %o's head with %kh katana."
     bAlwaysSevers=True
	 BlockFatiguePenalty=0.2
     bSpecial=True
}
