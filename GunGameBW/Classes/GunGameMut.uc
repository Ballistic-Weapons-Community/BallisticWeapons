class GunGameMut extends DMMutator
          HideDropDown
          CacheExempt;

var bool bNoHealth;
var bool bNoShield;
var bool bNoAdrenaline;
var bool bNoDoubleDamage;

function bool CheckReplacement( Actor Other, out byte bSuperRelevant ) //Remove stuff from map, prepare Controllers and Weapons
{
     local int i, j;
     local byte WBClasses;

     bSuperRelevant = 0;

     if ( GunGame(Level.Game) != None || TeamGunGame(Level.Game) != None )
     {
          if ( PlayerController(Other) != None || Bot(Other) != None )  //Assign new PlayerReplicationInfo
          {
               Controller(Other).PlayerReplicationInfoClass = Class'GunGameBW.GunGamePRI';
          }
          if ( xPawn(Other) != none )  //Do not allow to spawn the default inventory
          {
               UnrealPawn(Other).bNoDefaultInventory = true;
          }
          if ( Weapon(Other) != None )  //Weapons are not allowed to be thrown out
          {
               Weapon(Other).bCanThrow = false;
          }
          if ( xWeaponBase(Other) != None )  //Remove all weapon pickups
          {
               xWeaponBase(Other).WeaponType = None;

               if ( xWeaponBase(Other).myPickUp != None )
                    xWeaponBase(Other).myPickUp.Destroy();
          }
          if ( Pickup(Other) != None )
          {
               if ( TournamentPickUp(Other) != None )   //Remove other pickups (health/shield/doubledamage)
               {
                    if ( bNoHealth && TournamentHealth(Other) != None )
                         return false;
                    else if ( bNoShield && ShieldPickup(Other) != None )
                         return false;
                    else if ( bNoAdrenaline && AdrenalinePickup(Other) != None )
                         return false;
                    else if ( bNoDoubleDamage && UDamagePack(Other) != None )
                         return false;
               }
               else if ( WeaponLocker(Other) != None )  //Remove possible WeaponLockers, rather unlikely but possible
                    return false;
               else if ( Ammo(Other) != None )          //Remove ammo pickups
                    return false;
          }
          if ( WildcardBase(Other) != None )  //Check Wildcardbase pickups
          {
               WBClasses = WildcardBase(Other).NumClasses;

               for ( i=0; i<8; i++ ) //Remove unsuitable pickup classes
               {
                    if ( WildcardBase(Other).PickupClasses[i] != None )
                    {
                         if ( bNoHealth && ClassIsChildOf( WildcardBase(Other).PickupClasses[i], class'TournamentHealth' ) )
                         {
                              WildcardBase(Other).PickupClasses[i] = None;
                              WBClasses--;
                         }
                         else if ( bNoShield && ClassIsChildOf( WildcardBase(Other).PickupClasses[i], class'ShieldPickup' ) )
                         {
                              WildcardBase(Other).PickupClasses[i] = None;
                              WBClasses--;
                         }
                         else if ( bNoAdrenaline && ClassIsChildOf( WildcardBase(Other).PickupClasses[i], class'AdrenalinePickup' ) )
                         {
                              WildcardBase(Other).PickupClasses[i] = None;
                              WBClasses--;
                         }
                         else if ( bNoDoubleDamage && ClassIsChildOf( WildcardBase(Other).PickupClasses[i], class'UDamagePack' ) )
                         {
                              WildcardBase(Other).PickupClasses[i] = None;
                              WBClasses--;
                         }
                    }
               }

               WildcardBase(Other).NumClasses = WBClasses;
               j = -1; //j points to the current index which is 'None'

               for ( i=0; i<8; i++ )  //Sort the class array
               {
                    if ( WildcardBase(Other).PickupClasses[i] == None && j == -1 )
                         j = i;
                    else if ( WildcardBase(Other).PickupClasses[i] != None )
                    {
                         if ( j != -1 )
                         {
                              WildcardBase(Other).PickupClasses[j] = WildcardBase(Other).PickupClasses[i];
                              WildcardBase(Other).PickupClasses[i] = None;
                              i = j;
                              j = -1;
                         }
                         if ( i == WBClasses-1 )  //All valid classes has been set in order
                              break;
                    }
               }
          }
		  if ( xPickupBase(Other) != None )	//Remove any leftover pickup bases
		  {
			   Other.bHidden = true;
			   
			   if (xPickupBase(Other).myMarker != None)
					xPickupBase(Other).myMarker.bBlocked = True;
					
			   if (xPickupBase(Other).myEmitter != None)
					xPickupBase(Other).myEmitter.Destroy();
		  }
     }

     return true;
}

defaultproperties
{
}
