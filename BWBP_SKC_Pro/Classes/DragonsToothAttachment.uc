//=============================================================================
// DragonsToothAttachment.
//
// Attachment for the Dragon's Tooth Sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothAttachment extends BallisticMeleeAttachment;

var   bool					bNoGlow;	//The layout's blade does not glow
var   Shader				BladeShader;	//The camo's skin, blended in for this mesh

// The camos' skins are the first person ones. On that mesh the glass of the blade is a material of its own and the main skin
// leaves the blade out; this mesh has the one material, and only the cracks were left of the nanoblack and royal blades.
// So the skin is blended in here, the way the mesh's own DTS-Shine3rd is.
simulated function ApplyCamo()
{
	local Shader CamoShader;

	Super.ApplyCamo();

	if (Level.NetMode == NM_DedicatedServer || Skins.Length == 0)
		return;

	CamoShader = Shader(Skins[0]);
	if (CamoShader == None || CamoShader == BladeShader || CamoShader.OutputBlending != OB_Masked)
		return;

	if (BladeShader == None)
		BladeShader = Shader(Level.ObjectPool.AllocateObject(class'DTSBladeShader'));
	if (BladeShader == None)
		return;

	BladeShader.Diffuse = CamoShader.Diffuse;
	BladeShader.Opacity = CamoShader.Opacity;
	BladeShader.Specular = CamoShader.Specular;
	BladeShader.SpecularityMask = CamoShader.SpecularityMask;
	BladeShader.SelfIllumination = CamoShader.SelfIllumination;
	BladeShader.SelfIlluminationMask = CamoShader.SelfIlluminationMask;
	BladeShader.Detail = CamoShader.Detail;
	BladeShader.DetailScale = CamoShader.DetailScale;
	BladeShader.TwoSided = CamoShader.TwoSided;
	BladeShader.Wireframe = CamoShader.Wireframe;
	BladeShader.PerformLightingOnSpecularPass = CamoShader.PerformLightingOnSpecularPass;
	BladeShader.ModulateSpecular2X = CamoShader.ModulateSpecular2X;
	BladeShader.FallbackMaterial = CamoShader.FallbackMaterial;
	BladeShader.OutputBlending = OB_Normal;
	Skins[0] = BladeShader;
}

simulated function Destroyed()
{
	if (BladeShader != None)
	{
		Level.ObjectPool.FreeObject(BladeShader);
		BladeShader = None;
	}

	Super.Destroyed();
}

simulated function ApplyModel()
{
	local string Tags;

	Super.ApplyModel();

	if (LayoutIndex >= WeaponClass.static.GetParams().default.Layouts.Length)
		return;

	// The light of the first person blade's glow: red, blue or none at all
	Tags = WeaponClass.static.GetParams().default.Layouts[LayoutIndex].LayoutTags;
	if (InStr(Tags, "red") != -1)
		LightHue = class'DragonsToothBladeEffectR'.default.LightHue;
	else if (InStr(Tags, "black") != -1 || InStr(Tags, "gold") != -1)
		bNoGlow = true;
}

// The first person blade lights the place up for the one holding it. Everyone else gets it from here, and so does he in behind view.
// The light is where this was last drawn, so it goes out when it is not on screen.
simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bNoGlow || (Instigator != None && Instigator.IsFirstPerson()) || Level.TimeSeconds - LastRenderTime > 0.2)
		LightType = LT_None;
	else
		LightType = LT_Steady;
}

defaultproperties
{
	WeaponClass=class'DragonsToothSword'
	ImpactManager=Class'BWBP_SKC_Pro.IM_DTS'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	bHeavy=True
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=160
	LightSaturation=64
	LightBrightness=224.000000
	LightRadius=12.000000
	bDynamicLight=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.DTS_TPm'
	RelativeLocation=(Y=-3.000000,Z=6.000000)
	DrawScale=0.120000
}
