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
	PreloadMeshActor = ViewportOwner.Actor.Spawn(class'BallisticPreloadMesh',ViewportOwner.Actor.Pawn);
}

//0 =STY_None 1 = STY_Normal 2 = STY_Masked 3 = STY_Translucent 4 = STY_Modulated 5 = STY_Alpha 6 = STY_Additive 7 = STY_Subtractive 8 = STY_Particle 9 = STY_AlphaZ
simulated function PostRender(Canvas Canvas)
{
	local Canvas C;
	local BallisticPreloadReplicationInfo RI;
	local vector X,Y,Z, FinalLoc;
	local Mesh WeaponMesh;

	PreloadMeshActor.bHidden = true;	//comment this line to show the weapon meshes load in front of you

	C = Canvas;
	if(ViewportOwner.Actor.Pawn != None)
	{
		if(MyRI != None)
		{
			Pause++;
			if(Pause == 15)
			{
				Pause = 0;
				WeaponNumber++;
			}

			if (WeaponNumber > MyRI.PreloadNum)
			{
				if(PreloadMeshActor != None)
				{
					PreloadMeshActor.Destroy();
				}

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
					C.DrawTextClipped("Preloading Weapon: " @ MyRI.CurrentName[WeaponNumber]);
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
			
			if (PreloadMeshActor != None && MyRI.MeshList[WeaponNumber] != "")
			{
				WeaponMesh = Mesh(DynamicLoadObject(MyRI.MeshList[WeaponNumber],class'Mesh',True));
				ViewportOwner.Actor.Pawn.GetAxes(ViewportOwner.Actor.Pawn.Rotation,X,Y,Z);
				FinalLoc = ViewportOwner.Actor.Pawn.Location + (LocOffSetX * X) + (LocOffSetZ * Z);
				PreloadMeshActor.SetLocation(FinalLoc);
				PreloadMeshActor.LinkMesh(WeaponMesh,false);
			}		
		}
		else
		{
			foreach ViewportOwner.Actor.DynamicActors(class'BallisticPreloadReplicationInfo', RI)
			{
				if(RI != None)
					MyRI = RI;
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
