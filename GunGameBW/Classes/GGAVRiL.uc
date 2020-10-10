//=============================================================================
// GunGame AVRiL
//=============================================================================
class GGAVRiL extends ONSAVRiL
          config(GunGameBW);

function float GetAIRating() //Normally bots (especially stronger bots) won't use it against players, so make it more likely they do so
{
     local Bot B;
     local float EnemyDist;

     B = Bot(Instigator.Controller);
     if ( B == None )
          return AIRating;

     if ( B.Enemy == None )
          return AIRating;

     EnemyDist = VSize(B.Enemy.Location - Instigator.Location);

     if ( (B.IsRetreating() || B.Stopped()) && EnemyDist<=200 )
          return ( AIRating + 0.4 );
     if ( EnemyDist<=100 )
          return (AIRating + 0.3);
     if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
          return (AIRating + 0.2);

     return 0.2;
}

defaultproperties
{
     ItemName="GG AVRiL"
}
