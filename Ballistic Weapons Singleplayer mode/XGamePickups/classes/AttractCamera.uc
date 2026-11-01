//=============================================================================
// Attract-mode camera points
// Copyright 2001 Digital Extremes - All Rights Reserved.
// Confidential.
//=============================================================================

class AttractCamera extends Keypoint;

var() float ViewAngle;
var() float MinZoomDist;
var() float MaxZoomDist;

defaultproperties
{
	bStasis=true
    ViewAngle=100
    MinZoomDist=600
    MaxZoomDist=1200
}
