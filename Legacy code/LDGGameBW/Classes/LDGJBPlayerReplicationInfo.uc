class LDGJBPlayerReplicationInfo extends xPlayerReplicationInfo;

var bool bWarned;

var int CampCount;              // the number of times penalized for camping - NR
var int ConsecutiveCampCount;   // the number of times penalized for camping consecutively - NR

/* camping related */
var vector LocationHistory[10];
var int	   NextLocHistSlot;
var bool   bWarmedUp;
var int	   ReWarnTime;
/* camping related */

defaultproperties
{
}
