class LDGDamagePopup extends xEmitter
	config(User);

var int Damage;
var color FontColor;
var ScriptedTexture STexture;
var TexRotator TexRot;

var ConstantColor STextureFallBack;
var Font DrawFont;

var config bool bShowDamagePopup;

function Destroyed()
{
	if(STexture != None)
	{
		STexture.Client = None;
		Level.ObjectPool.FreeObject(STexture);
	}
	
	if(STextureFallBack != None)
		Level.ObjectPool.FreeObject(STextureFallBack);
	
	if(TexRot != None)
		Level.ObjectPool.FreeObject(TexRot);
	
	Super.Destroyed();
}

function Initialize()
{
	STexture = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
	STexture.SetSize(64,64);
	STexture.FallBackMaterial = STextureFallBack;
	STexture.Client = Self;

	STextureFallBack  = ConstantColor(Level.ObjectPool.AllocateObject(class'ConstantColor'));
	STextureFallBack.Color.A = 0;
	STextureFallBack.Color.R = 0;
	STextureFallBack.Color.G = 0;
	STextureFallBack.Color.B = 0;

	TexRot = TexRotator(Level.ObjectPool.AllocateObject(class'TexRotator'));
	TexRot.Material=STexture;
	TexRot.Rotation.Yaw=8192;
	TexRot.UOffset=32;
	TexRot.VOffset=32;
	
	//	DrawFont = Font(DynamicLoadObject("Engine.DefaultFont", class'Font'));
	DrawFont = Font(DynamicLoadObject("UT2003Fonts.FontEurostile14", class'Font'));
	Texture = TexRot;
	Skins[0] = TexRot;
	SetRotation(rot(16384,0,0));
	mStartParticles=1;

}

event RenderTexture(ScriptedTexture Tex)
{
	local int SizeX, SizeY;
	local string text;
	local color BackColor;
	
	BackColor.R=0;
	BackColor.G=0;
	BackColor.B=0;
	BackColor.A=0;

	if (Damage < 0)
		return;
	
	Text = string(damage);

	Tex.TextSize(text, DrawFont, SizeX, SizeY);
	Tex.DrawTile(0, 0, Tex.USize, Tex.VSize, 0, 0, Tex.USize, Tex.VSize, STextureFallback, BackColor);
	Tex.DrawText((Tex.USize - SizeX) * 0.5, 8, text, DrawFont, FontColor);
}

defaultproperties
{
     Damage=-1
     FontColor=(A=255)
     DrawFont=Font'Engine.DefaultFont'
     bShowDamagePopup=True
     mStartParticles=0
     mMaxParticles=1
     mSpeedRange(0)=300.000000
     mSpeedRange(1)=300.000000
     mMassRange(0)=2.000000
     mMassRange(1)=2.000000
     mAirResistance=1.000000
     mSizeRange(0)=50.000000
     mSizeRange(1)=50.000000
     mAttenuate=False
     DrawType=DT_Sprite
     LifeSpan=1.000000
     Rotation=(Pitch=16383)
     Texture=None
     Skins(0)=None
     Style=STY_Alpha
}
