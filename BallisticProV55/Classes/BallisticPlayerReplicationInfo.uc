//========================================================
// Ballistic player replication info.
//
// Linked replication info handling hitstats and Killstreak data
//========================================================
class BallisticPlayerReplicationInfo extends LinkedReplicationInfo;

/* hitstats */
struct HitStat
{
    var int Fired;
    var int Hit;
    var int Damage;
	var int Kills;
	var int DeathsWith;
};

var array<HitStat> HitStats[10]; //Based on Inventory Group, 1 is streak and 0 is grenades

var int         SGDamage;
var int         HeadShots;
var float       AveragePercent;
/* hitstats */

/* killstreaks */

var byte		NadeCount;

/* killstreaks */

function AddFireStat(int load, int InventoryGroup)
{
	HitStats[InventoryGroup].Fired += Load;
}

function ProcessHitStats()
{
		local int count, i;
		local bool bInc;
	   
		AveragePercent = 0.0;
	   
		for (i = 0; i < 10; i++)
		{
				switch (i)
				{
						case 0: bInc = HitStats[0].Fired > 2; break;
						case 1: bInc = HitStats[1].Fired > 2; break;
						case 2: bInc = HitStats[2].Fired > 9; break;
						case 3: bInc = HitStats[3].Fired > 0; break;
						case 4: bInc = HitStats[4].Fired > 4; break;
						case 5: bInc = HitStats[5].Fired > 9; break;
						case 6: bInc = HitStats[6].Fired > 19; break;
						case 7: bInc = HitStats[7].Fired > 19; break;
						case 8: bInc = HitStats[8].Fired > 2; break;
						case 9: bInc = HitStats[9].Fired > 2; break;
				}
			   
				if (bInc)
				{
						AveragePercent += GetPercentage(HitStats[i].Fired, HitStats[i].Hit);
						count++;
				}
		}
	   
		if(count > 0)
		  AveragePercent /= count;
}
 
function float GetPercentage(float f1, float f2)
{
	if(f1 == 0.0)
		return 0.0;
	return FMin(100.0, ((f2 / f1) * 100.0));
}

defaultproperties
{
}
