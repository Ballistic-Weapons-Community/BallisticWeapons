class LDGJBBotSquadJail extends JBBotSquadJail;

static function bool IsPlayerFighting(Controller Controller, optional bool bIgnorePendingWeapon)
{
  if (Controller      == None ||
      Controller.Pawn == None)
    return False;

  if (CountWeaponsFor(Controller.Pawn) <= 1)
    return False;
    
  return (Controller.Pawn.Weapon.bMeleeWeapon ||
         (Controller.Pawn.PendingWeapon != None && Controller.Pawn.PendingWeapon.bMeleeWeapon && !bIgnorePendingWeapon));
}

defaultproperties
{
}
