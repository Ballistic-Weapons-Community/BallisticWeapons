//=============================================================================
// JunkRangedFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkPickupMessage extends LocalMessage;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if ( class<JunkObject>(OptionalObject) != None )
        return class<JunkObject>(OptionalObject).default.PickupMessage;
    return "";
}

defaultproperties
{
     bIsUnique=True
     bFadeMessage=True
     DrawColor=(B=0,G=192)
     PosY=0.850000
}
