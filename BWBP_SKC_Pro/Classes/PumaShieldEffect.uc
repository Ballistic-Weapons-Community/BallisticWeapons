class PumaShieldEffect extends Actor;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

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
     MatShot=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSDO'
     MatDam=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSDR'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.PumaShield'
     bHidden=True
     bOnlyOwnerSee=True
     RemoteRole=ROLE_None
     Skins(0)=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSD'
     AmbientGlow=250
     bUnlit=True
}
