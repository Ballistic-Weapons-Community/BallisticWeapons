// =================================================================================================================
// RegistryClass:
//
// - supervise player, like a controller class
// - add circularly ammo to User.Pawn if AmmoHandling = 0; otherwise keep track of weapon if it has gone out of ammo
// - remove old weapons from User.Pawn's Inventory
//
// =================================================================================================================

class GGRegistry extends Info;

var bool bUnlimited;       //Unlimited ammo has been chosen in settings
var bool bBlockMultiKills;
var bool bBlocked;         //This is only triggered by the (Team)GunGameInfo to block the ammo function when levelling up/down
var GunGame GG;
var TeamGunGame TGG;
var GunGamePRI PlayerPRI;
var Controller User;
var VolumeTimer VT;       //Used to remove old weapons
var Inventory Inv;
var array<Weapon> OldWeapons;       //Old weapons will be stored here in order to be deleted
var int OldWeaponsLengthTPop;       //Delayed length TPop works with
var class<Weapon> NoAmmoSwitch;
var class<Weapon> StandardWeapon;
var class<Weapon> NewWeaponClass;   //Current weaponclass of User.Pawn
var class<Weapon> NewWeaponTPop;    //The same as NewWeaponClass, but its value will be changed with a delay of 0.4 sec. Only TimerPop uses it.
var float GunSwitchTime;
var bool bUpdateAmmo;   //Used for Timer to update ammo every second cycle, to gain some performance
var byte FireMode;      //Iterate through firemodes to check if ammo is needed
var bool bNoticeCall;   //Used for TimerPop

struct HitInfo
{
     var Controller Player;
     var class<WeaponDamageType> HitDamage;  //WeaponDamage, Telefragging and Jumpkills -> all damagetypes that can be caused by players (filter out WorldDamage)
     var float HitTime;
};

var array<HitInfo> HitList;

function PostBeginPlay()
{
     if ( Controller(Owner) == None )
     {
          Destroy();
          return;
     }

     if ( GunGamePRI(Controller(Owner).PlayerReplicationInfo) == None )
     {
          Destroy();
          return;
     }

     if ( GunGame(Level.Game) != None )
     {
          GG = GunGame(Level.Game);
          bUnlimited = (GG.AmmoHandling == 0);
     }
     else if ( TeamGunGame(Level.Game) != None )
     {
          TGG = TeamGunGame(Level.Game);
          bUnlimited = (TGG.AmmoHandling == 0);
     }
     else
     {
          Destroy();
          return;
     }

     User = Controller(Owner);
     PlayerPRI = GunGamePRI(User.PlayerReplicationInfo);
     VT = Spawn(class'VolumeTimer', Self);
     VT.TimerFrequency = 0.0;

     SetTimer(1.4+FRand()*0.2, true);  //Randomize a bit here so that all registries won't be updated at the same time
}

function Timer()
{
     if ( bBlockMultiKills )
     {
          bBlockMultiKills = false;
          SetTimer(1.5, true);
     }

     if ( User != None )
     {
          if ( User.Pawn != None && !bBlocked )
          {
               if ( bUnlimited )
               {
                    if ( NoAmmoSwitch != None )
                    {
                         if ( !User.Pawn.IsFiring() )
                              ClientSetWeapon(NoAmmoSwitch);

                         NoAmmoSwitch = None;
                    }

                    if ( !bUpdateAmmo )
                    {
                         for (Inv=User.Pawn.Inventory; Inv!= None; Inv=Inv.Inventory)
                         {
                              if ( Weapon(Inv) != None && ( Inv.Class == NewWeaponClass || Inv.Class == StandardWeapon ) )  //Supply new weapon and stad weapon only
                              {
                                   //If a weapon has gone out of ammo, rather unlikely but possible (Redeemer), then auto-switch back to it after maxing out ammo
                                   if ( !Weapon(Inv).HasAmmo() )
                                        NoAmmoSwitch = Weapon(Inv).Class;

                                   for ( FireMode=0; FireMode<Weapon(Inv).NUM_FIRE_MODES; FireMode++  )
                                   {
                                        if ( Weapon(Inv).NeedAmmo(FireMode) )  //Max out ammo if weapon needs it -> performance
                                        {
                                             Weapon(Inv).MaxOutAmmo();
                                             break;
                                        }
                                   }
                              }
                         }
                    }
               }
               else
               {
                    if ( NoAmmoSwitch != None )
                    {
                         if ( !User.Pawn.IsFiring() )
                              ClientSetWeapon(NoAmmoSwitch);

                         NoAmmoSwitch = None;
                    }

                    for (Inv=User.Pawn.Inventory; Inv!= None; Inv=Inv.Inventory)
                    {
                         if ( Weapon(Inv) != None )
                         {
                              //Standard weapon and first weapon do always have unlimited ammo, if standard weapon is not the current weapon in WeaponList
                              if ( Inv.Class == StandardWeapon || PlayerPRI.GunLevel == 1 )
                              {
                                   if ( NewWeaponClass != StandardWeapon && bUpdateAmmo )  //When current weapon in list is standard weapon do not give ammo
                                   {
                                        //If a weapon has gone out of ammo, rather unlikely but possible (Redeemer), then auto-switch back to it after maxing out ammo
                                        if ( !Weapon(Inv).HasAmmo() )
                                             NoAmmoSwitch = Weapon(Inv).Class;

                                        for ( FireMode=0; FireMode<Weapon(Inv).NUM_FIRE_MODES; FireMode++  )
                                        {
                                             if ( Weapon(Inv).NeedAmmo(FireMode) )
                                             {
                                                  Weapon(Inv).FillToInitialAmmo();;
                                                  break;
                                             }
                                        }
                                   }
                              }
                              else if ( Inv.Class == NewWeaponClass )  //If current weapon is out of ammo downgrade GunLevel and give previous weapon of WeaponList
                              {
                                   if ( !Weapon(Inv).HasAmmo() )
                                   {
                                        if ( NoProjectiles(Weapon(Inv).class) )
                                        {
                                             PlayerPRI.AdjustLevel( -1 );

                                             if ( GG != None )
                                                  GG.SetEquipment(PlayerPRI, User.Pawn);
                                             else
                                                  TGG.SetEquipment(PlayerPRI, User.Pawn);
                                        }
                                   }
                              }
                         }
                    }
               }
          }
     }
     else
     {
          SetTimer(0.0, false);
          Disable('Timer');
     }

     //Toggle bUpdateAmmo
     if ( !bUpdateAmmo )
          bUpdateAmmo = true;
     else
          bUpdateAmmo = false;

     bBlocked = false;  //Unblock AmmoCheck, set by (Team)GunGameInfo
}

//This function decides whether to downgrade player's GunLevel by checking if there are any projectiles alive fired by this player.
function bool NoProjectiles(class<Weapon> WeaponClass)
{
     local Projectile P;
     local class<WeaponDamageType> WT;

     ForEach DynamicActors(class'Projectile', P)
     {
          if ( P != None )
          {
               if ( P.InstigatorController == User )
               {
                    WT = class<WeaponDamageType>(P.MyDamageType);

                    /*If there is one projectile of the player's weaponclass, then do not downgrade his GunLevel.
                      I have to do this, so that if you are out of ammo, but one projectile is still on its way, you won't be downgraded. (E.g. for Redeemer)*/
                    if ( WT != None )
                         if ( ClassIsChildOf(WeaponClass, WT.Default.WeaponClass) )
                              return false;
               }
          }
     }

     return true;
}

//Add an entry/adjust existing entry if an enemy has been damaged by a weapon. Called by (Team)GunGameInfo's ReduceDamage()
function EnemyHit( Controller Victim, class<WeaponDamageType> Damage )
{
     local byte i;

     if ( Victim != None )
     {
          for ( i=0; i<HitList.Length; i++ )
          {
               if ( HitList[i].Player == Victim )
               {
                    HitList[i].HitTime = Level.TimeSeconds;
                    HitList[i].HitDamage = Damage;
                    return;
               }
          }

          HitList.Insert(HitList.Length, 1);
          HitList[HitList.Length-1].Player = Victim;
          HitList[HitList.Length-1].HitDamage = Damage;
          HitList[HitList.Length-1].HitTime = Level.TimeSeconds;
     }
}

//Delete exiting player from HitList
function NotifyLogout(Controller C)
{
     local byte i;

     for ( i=0; i<HitList.Length; i++ )
     {
          if ( HitList[i].Player == C )
          {
               HitList.Remove(i, 1);
               break;
          }
     }
}

function class<WeaponDamageType> LastWeaponsDamageDoneTo( Controller Victim )
{
     local byte i;

     for ( i=0; i<HitList.Length; i++ )
     {
          if ( HitList[i].Player == Victim )
               return HitList[i].HitDamage;
     }

     return None;
}

//The time when the victim has been hit must be greater than the weapon switch time. This is the only way to determine whether a kill has been done with an elder weapon or not.
function bool CheckKillValidity( Controller Victim )
{
     local byte i;

     for ( i=0; i<HitList.Length; i++ )
     {
          if ( HitList[i].Player == Victim )
               if ( HitList[i].HitTime >= GunSwitchTime )
                    return true;
               else
                    return false;
     }

     return false;
}

//Just to avoid some accessed none errors on grounds of that
function ClientSetWeapon(class<Weapon> W)
{
     if ( User.Pawn != None )
          User.ClientSetWeapon(W);
}

function DisposeOfWeapon(Weapon Trash, class<Weapon> W)
{
     GunSwitchTime = Level.TimeSeconds;
     OldWeapons.Insert(OldWeapons.Length, 1);
     OldWeapons[OldWeapons.Length-1] = Trash;
     NewWeaponClass = W;

     VT.TimerFrequency = 0.1;
     VT.SetTimer(0.1, false);
     bNoticeCall = true;      //Say TimerPop that new Weapon has been assigned
}

//This is a complex Timer construct.
//It has to do only one job: delete the old weapon safely.
function TimerPop(VolumeTimer T)
{
     local byte i;

     if ( bNoticeCall )  //I need the delay for online play, so client has time to get the new weapon from server, otherwise clientsetweapon() won't work
     {
          VT.TimerFrequency = 0.4;
          NewWeaponTPop = NewWeaponClass;
          OldWeaponsLengthTPop = OldWeapons.Length;  //A fix value, so that new elements won't be deleted too early
          bNoticeCall = false;
     }
     else
     {
          if ( User.Pawn == None || NewWeaponTPop == None || OldWeapons.Length == 0 )  //Exit conditions
          {
               VT.TimerFrequency = 0.0;
               return;
          }

          if ( VT.TimerFrequency != 0.1 )  //Reset timer frequency
               VT.TimerFrequency = 0.1;

          if ( User.Pawn.Weapon.Class != NewWeaponTPop )
          {
               if ( OldWeapons[OldWeaponsLengthTPop-1] != None )
                    OldWeapons[OldWeaponsLengthTPop-1].HolderDied();  //Release last shot

               ClientSetWeapon(NewWeaponTPop);
          }
          else
          {
               //Imagine the player levels up right now, so I get a new OldWeapons entry right now. This entry has not undergone the delay and would be deleted too early here.
               //Therefore I use the fix array length value, so that the length won't change here anymore and newer elements will be considered after the delay.
               for ( i=0; i<OldWeaponsLengthTPop; i++ )  //Destroy remaining old weapons
               {
                    if ( OldWeapons[i] != None && User.Pawn.Weapon != OldWeapons[i] )
                    {
                         if ( StandardWeapon != OldWeapons[i].Class )
                         {
                              OldWeapons[i].ClientWeaponThrown();
                              OldWeapons[i].Destroy();
                              OldWeapons[i] = None;
                         }
                         else
                              OldWeapons[i] = None;
                    }

                    if ( OldWeapons[i] == None && OldWeaponsLengthTPop > 0 )
                    {
                         OldWeapons.Remove(i, 1);
                         OldWeaponsLengthTPop--;
                         i--;
                    }
               }
          }
     }
}

defaultproperties
{
}
