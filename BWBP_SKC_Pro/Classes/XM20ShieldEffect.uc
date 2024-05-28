class XM20ShieldEffect extends Actor;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

var float Brightness, DesiredBrightness;

var() 	Material		MatShot;
var() 	Material      	MatDam;
var 	bool			bDamaged;

function Flash(int Drain, int ShieldPower)
{
    Brightness = FMin(Brightness + Drain / 2, 250.0);
	
    Skins[0] = MatShot;
	
	bDamaged = ShieldPower < 40;
	
    SetTimer(0.2, false);
}

function Timer()
{
	if (bDamaged)
    	Skins[0] = MatDam;
	else
    	Skins[0] = MatShot;
}

function SetRedSkin()
{
	MatDam = FinalBlend'BWBP_SKC_Tex.AIMS.AIMSShield3rdFB';
	MatShot = FinalBlend'BWBP_SKC_Tex.AIMS.AIMSShield3rdFB';
	
	Skins[0] = MatShot;
	Skins[1] = MatShot;
}

function SetBrightness(int b)
{
    DesiredBrightness = FMin(50+b*2, 250.0);
}

defaultproperties
{
     Brightness=250.000000
     DesiredBrightness=250.000000
     MatShot=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSD'
     MatDam=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSD'
     DrawType=DT_StaticMesh
	 StaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.PUMAShield'
     bHidden=True
     bOnlyOwnerSee=True
     RemoteRole=ROLE_None
     Skins(0)=FinalBlend'BWBP_SKC_Tex.PUMA.PUMAShield3rdFB'
     AmbientGlow=250
     bUnlit=True
}
