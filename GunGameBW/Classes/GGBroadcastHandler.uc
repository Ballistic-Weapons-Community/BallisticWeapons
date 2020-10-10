class GGBroadcastHandler extends BroadcastHandler;

function PostBeginPlay()
{
     Super.PostBeginPlay();
     bPartitionSpectators = true;
}

static event bool AcceptPlayInfoProperty(string PropertyName)
{
     if ( PropertyName ~= "bPartitionSpectators" )
          return false;

     return Super.AcceptPlayInfoProperty(PropertyName);
}

defaultproperties
{
}
