class XM20ShieldEffect extends Actor;

#exec OBJ LOAD FILE=BallisticRecolors5A.utx

var float Brightness, DesiredBrightness;
var() Material		MatShot;
var() Material          MatDam;
var bool	bDamaged;

function Flash(int Drain, int ShieldPower)
{
    Brightness = FMin(Brightness + Drain / 2, 250.0);
    Skins[0] = MatShot;
	if (ShieldPower < 40)
		bDamaged = true;
	else
		bDamaged = false;
    SetTimer(0.2, false);
}


function Timer()
{
	if (bDamaged)
    	Skins[0] = MatDam;
	else
    	Skins[0] = default.Skins[0];
}

function SetBrightness(int b)
{
    DesiredBrightness = FMin(50+b*2, 250.0);
}

defaultproperties
{
     Brightness=250.000000
     DesiredBrightness=250.000000
     MatShot=Shader'BallisticRecolors4TexPro.PUMA.PUMA-ShieldSD'
     MatDam=Shader'BallisticRecolors4TexPro.PUMA.PUMA-ShieldSD'
     DrawType=DT_StaticMesh
	 StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.PUMA.PUMAShield'
     bHidden=True
     bOnlyOwnerSee=True
     RemoteRole=ROLE_None
     Skins(0)=FinalBlend'BallisticRecolors4TexPro.PUMA.PUMAShield3rdFB'
     AmbientGlow=250
     bUnlit=True
}
