//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFPickupWidget extends Actor;

var PlayerController pc;
var BallisticWeaponPickup bwPickUp;

var ScriptedTexture LicensePlate;
var Material        LicensePlateBackground;
var Material 		IconMaterial;
var Material 		ChargeBar;
var string          LicensePlateName;
var string			InventoryGroupName;
var Font            LicensePlateFont;
var Font            InventoryGroupFont;
var color			ammoColor;
var float			ammoLength;
var int 			magAmmo;

var string InventoryGroupNameL[11];

var bool bInit;

replication
{
	reliable if(Role==ROLE_Authority)
		bwPickUp, magAmmo ; // a reference to the pickup and the bw ammo left in the pickup
}

simulated function PostNetBeginPlay()
{
	if (!bInit)
	{
	  	InitWidget();
	}
	Super.PostNetBeginPlay();
}

simulated Event PostBeginPlay()
{
	pc = Level.GetLocalPlayerController();

	Super.PostBeginPlay();
	if(Level.NetMode != NM_DedicatedServer)
	{
		LicensePlate = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
		LicensePlate.SetSize(256,128);
		LicensePlate.Client = Self;
		Skins[0] = LicensePlate;
		LicensePlateFont = Font(DynamicLoadObject("2K4Fonts.Verdana10", class'Font'));
		InventoryGroupFont = Font(DynamicLoadObject("2K4Fonts.Verdana8", class'Font'));
	}
}

simulated function InitWidget()
{
	local int invGroup, bwinvGroup;

	if(bwPickUp != none)
	{
		bInit=True;

		LicensePlateName = bwPickUp.InventoryType.default.ItemName;

		IconMaterial = bwPickUp.InventoryType.default.IconMaterial;
		CullDistance = 3*bwPickUp.default.CollisionRadius;

		invGroup=bwPickUp.InventoryType.default.InventoryGroup;
		bwinvGroup=class<BallisticWeapon>(bwPickUp.InventoryType).default.InventoryGroup;

		if(bwinvGroup > 0 && bwinvGroup <10)
		{
			InventoryGroupName = InventoryGroupNameL[bwinvGroup-1];
		}else if(bwinvGroup == 254 && invGroup > 0 && invGroup < 10)
		{
			InventoryGroupName = InventoryGroupNameL[invGroup-1];
		}else if(bwinvGroup == 0)
		{
			InventoryGroupName = InventoryGroupNameL[9];
		}else
		{
			InventoryGroupName = InventoryGroupNameL[10];
		}
	}
}

simulated event Tick(float dt)
{
	local float percentage;
	if(Level.NetMode != NM_DedicatedServer && bInit)
	{
		if(!bHidden)
		 SetRotation(pc.GetViewRotation());

		if(bwPickUp != none && bwPickUp.Velocity == vect(0,0,0) && bHidden)
		{
			bHidden=false;
			SetLocation(bwPickUp.Location+vect(0,0,32));
			percentage = magAmmo * 100 / (class<BallisticWeapon>(bwPickUp.InventoryType).default.MagAmmo); // thats the ammo left in percentage

			// here we calculate the color of the bar
			ammoColor.B=0;
			ammoColor.A=255;

			if(percentage == 0)
			{
				// standard red
				ammoColor.R=255;
				ammoColor.G=0;
			}
			else if(percentage == 100)
			{
				// standard green
				ammoColor.R=0;
				ammoColor.G=255;
				ammoColor.B=0;
			}else if(percentage == 50)
			{
				// standard yellow
				ammoColor.R=255;
				ammoColor.G=255;
				ammoColor.B=0;
			}else if(percentage < 50)
			{
				ammoColor.R=255;
				ammoColor.G = Round((percentage * 2 / 100) * 255);
			}else if(percentage > 50)
			{
				ammoColor.G = 255;
				ammoColor.R = Round(((percentage * 2 / 100) * 255)-255);
			}

			// here we calculate the lenght of the bar
		 	ammoLength = min(100, percentage);
		}
	}
	Super.Tick(dt);
}

simulated event RenderTexture(ScriptedTexture Tex)
{
	local int SizeX,  SizeY;
	local color BackColor, ForegroundColor, HighLightColor;

	HighLightColor.R=255;
	HighLightColor.G=255;
	HighLightColor.B=255;
	HighLightColor.A=255;

	ForegroundColor.R=0;
	ForegroundColor.G=0;
	ForegroundColor.B=0;
	ForegroundColor.A=255;

	BackColor.R=128;
	BackColor.G=128;
	BackColor.B=128;
	BackColor.A=50;

		Tex.TextSize(LicensePlateName, LicensePlateFont, SizeX, SizeY);

		Tex.DrawTile(0,0,Tex.USize,Tex.VSize,0,0,Tex.USize,Tex.VSize,LicensePlateBackground,BackColor);
		Tex.DrawText((Tex.USize - SizeX) * 0.5, 20, LicensePlateName, LicensePlateFont, HighLightColor);

		Tex.DrawTile(0,50,128,32,0,0,128,32,IconMaterial,ForegroundColor);
		Tex.DrawTile(128,60,ammoLength,10,0,0,ammoLength,10,ChargeBar,ammoColor);

		Tex.TextSize(InventoryGroupName, InventoryGroupFont, SizeX, SizeY);
		Tex.DrawText((Tex.USize - SizeX) * 0.5, 90, InventoryGroupName, InventoryGroupFont, HighLightColor);
}

simulated event Destroyed()
{
	if (LicensePlate != None && Level.NetMode != NM_DedicatedServer)
	{

		LicensePlate.Client = None;
		Level.ObjectPool.FreeObject(LicensePlate);
	}

	Super.Destroyed();
}

defaultproperties
{
     LicensePlate=ScriptedTexture'BW_Core_WeaponTex.PickupWidget.PickupWidget-ST'
     LicensePlateBackground=Texture'BW_Core_WeaponTex.PickupWidget.PickupWidgetBG'
     LicensePlateName="Init"
     MagAmmo=-1
     InventoryGroupNameL(0)="- Melee -"
     InventoryGroupNameL(1)="- Sidearm -"
     InventoryGroupNameL(2)="- Personal Defence Weapon -"
     InventoryGroupNameL(3)="- Assault Rifle -"
     InventoryGroupNameL(4)="- Energy Weapon -"
     InventoryGroupNameL(5)="- Heavy Machingun -"
     InventoryGroupNameL(6)="- Shotgun -"
     InventoryGroupNameL(7)="- Ordnance -"
     InventoryGroupNameL(8)="- Sniper Rifle -"
     InventoryGroupNameL(9)="- Grenade / Explosive -"
     InventoryGroupNameL(10)="- Misc -"
     DrawType=DT_StaticMesh
     //StaticMesh=StaticMesh'BWBP_SKC_Static.PickupWidget.PickupWidgetStatic'
     bHidden=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=0.250000
     DrawScale3D=(Z=0.750000)
     bUnlit=True
     bNetNotify=True
}
