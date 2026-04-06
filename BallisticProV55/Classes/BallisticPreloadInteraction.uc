//------------------------------------------
//INIQUITOUS 2011 D:
//------------------------------------------
class BallisticPreloadInteraction extends Interaction;

var() float FontScaleX, FontScaleY;
var() float TextOnePosX, TextOnePosY;
var() float TextTwoPosX, TextTwoPosY;

var() int BGStyle;
var() int BGMatSizeX, BGMatSizeY;
var() int BGMatPosX, BGMatPosY;
var() int MatOnePosX, MatOnePosY;
var() int MatTwoPosX, MatTwoPosY;
var() int MaterialSize;
var() int Pause;
var() int WeaponNumber;
var() int LocOffSetX, LocOffSetZ;

var() Font MessagesFont;
var() Color BGMatColour;
var() BallisticPreloadReplicationInfo MyRI;
var() Actor PreloadMeshActor;

var bool bDisplayDebugText;

event Initialized()
{
	Pause = 0;
	WeaponNumber = 0;
}

simulated function SpawnPreloadMeshActor()
{
	if (PreloadMeshActor == None && ViewportOwner.Actor.Pawn != None)
		PreloadMeshActor = ViewportOwner.Actor.Spawn(class'BallisticPreloadMesh', ViewportOwner.Actor.Pawn);
}

//0 =STY_None 1 = STY_Normal 2 = STY_Masked 3 = STY_Translucent 4 = STY_Modulated 5 = STY_Alpha 6 = STY_Additive 7 = STY_Subtractive 8 = STY_Particle 9 = STY_AlphaZ
simulated function PostRender(Canvas Canvas)
{
	local Canvas C;
	local BallisticPreloadReplicationInfo RI;
	local vector X,Y,Z, FinalLoc;
	local Mesh WeaponMesh;
	local class<Weapon> WeaponClass;
	local class<BallisticWeapon> BWClass;
	local class<BallisticWeaponParams> ParamsClass;
	local Material LoadedMat;
	local int j, k;
	local string DisplayName;

	C = Canvas;

	// Find the replication info as soon as it's available - doesn't need a Pawn
	if (MyRI == None)
	{
		foreach ViewportOwner.Actor.DynamicActors(class'BallisticPreloadReplicationInfo', RI)
		{
			if (RI != None)
				MyRI = RI;
		}
		return;
	}

	// Wait for replicated data to arrive before starting
	if (MyRI.PreloadNum == 0)
		return;

	Pause++;
	if (Pause == 15)
	{
		Pause = 0;
		WeaponNumber++;
	}

	if (WeaponNumber > MyRI.PreloadNum)
	{
		if (PreloadMeshActor != None)
			PreloadMeshActor.Destroy();

		Master.RemoveInteraction(Self);
		return;
	}

	if (bDisplayDebugText)
	{
		C.Font = MessagesFont;
		C.FontScaleX = FontScaleX;
		C.FontScaleY = FontScaleY;
		C.Style = 5;
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 0;
		C.SetPos(C.ClipX * TextOnePosX , C.ClipY * TextOnePosY);

		if (MyRI.CurrentName[WeaponNumber] != "")
		{
			DisplayName = MyRI.CurrentName[WeaponNumber];
			j = InStr(DisplayName, ".");
			if (j != -1)
				DisplayName = Mid(DisplayName, j + 1);
			C.DrawTextClipped("Preloading Weapon: " @ DisplayName);
		}
		else
			C.DrawTextClipped("Preloading Weapon ");

		C.Font = MessagesFont;
		C.FontScaleX = FontScaleX;
		C.FontScaleY = FontScaleY;
		C.Style = 5;
		C.DrawColor.R = 255;
		C.DrawColor.G = 150;
		C.DrawColor.B = 0;
		C.SetPos(C.ClipX * TextTwoPosX , C.ClipY * TextTwoPosY);
		C.DrawTextClipped("You may experience some lag");
		C.Reset();
	}

	if (MyRI.CurrentName[WeaponNumber] != "")
	{
		WeaponClass = class<Weapon>(DynamicLoadObject(MyRI.CurrentName[WeaponNumber], class'Class', True));

		BWClass = class<BallisticWeapon>(WeaponClass);

		// Only load materials on the first frame for each weapon
		if (BWClass != None && Pause == 1)
		{
			ParamsClass = BWClass.static.GetParams();
			if (ParamsClass == None)
			{
				Log("BW Preload: GetParams() returned None for" @ MyRI.CurrentName[WeaponNumber] @ "- GameStyle:" @ class'BallisticReplicationInfo'.default.GameStyle);
			}
			else
			{
				// Preload camo skins
				for (j = 0; j < ParamsClass.default.Camos.Length; j++)
				{
					if (ParamsClass.default.Camos[j] != None)
					{
						for (k = 0; k < ParamsClass.default.Camos[j].WeaponMaterialSwaps.Length; k++)
						{
							if (ParamsClass.default.Camos[j].WeaponMaterialSwaps[k].MaterialName != "")
							{
								LoadedMat = Material(DynamicLoadObject(ParamsClass.default.Camos[j].WeaponMaterialSwaps[k].MaterialName, class'Material', True));
								if (LoadedMat != None)
								{
									C.SetPos(0, 0);
									C.DrawTile(LoadedMat, 32, 32, 0, 0, 32, 32);
								}
							}
						}
					}
				}
			}
		}

		if (MyRI.MeshList[WeaponNumber] != "")
		{
			WeaponMesh = Mesh(DynamicLoadObject(MyRI.MeshList[WeaponNumber], class'Mesh', True));
			SpawnPreloadMeshActor();
			if (PreloadMeshActor != None && ViewportOwner.Actor.Pawn != None)
			{
				PreloadMeshActor.bHidden = true;
				ViewportOwner.Actor.Pawn.GetAxes(ViewportOwner.Actor.Pawn.Rotation, X, Y, Z);
				FinalLoc = ViewportOwner.Actor.Pawn.Location + (LocOffSetX * X) + (LocOffSetZ * Z);
				PreloadMeshActor.SetLocation(FinalLoc);
				PreloadMeshActor.LinkMesh(WeaponMesh, false);
			}
		}
	}
}

simulated function NotifyLevelChange()
{
    Master.RemoveInteraction(Self);
}

defaultproperties
{
	 bDisplayDebugText=True
     FontScaleX=0.500000
     FontScaleY=0.500000
     TextOnePosX=0.350000
     TextOnePosY=0.850000
     TextTwoPosX=0.350000
     TextTwoPosY=0.890000
     BGStyle=1
     BGMatSizeX=138
     BGMatSizeY=138
     BGMatPosX=8
     BGMatPosY=498
     MatOnePosX=10
     MatOnePosY=500
     MatTwoPosX=10
     MatTwoPosY=570
     MaterialSize=64
     LocOffSetX=128
     MessagesFont=Font'2k4Fonts.Verdana24'
     BGMatColour=(B=255,G=255,R=255,A=255)
     bVisible=True
     bRequiresTick=True
}
