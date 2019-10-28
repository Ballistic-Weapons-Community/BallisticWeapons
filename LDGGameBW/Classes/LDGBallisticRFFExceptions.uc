class LDGBallisticRFFExceptions extends object
	config(LDGGameBW);
	
struct RFFException
{
	var string DamageType;
	var float RFFOverride;
};

var config array<RFFException> RFFExceptions;

static function float GetRFF(string DamageType)
{
	local int i;
	
	for (i = 0; i < default.RFFExceptions.Length; i++)
	{
		if (default.RFFExceptions[i].DamageType ~= DamageType)
			return FClamp(default.RFFExceptions[i].RFFOverride, 0.0, 1.0);
	}
	
	return 1.0;
}

defaultproperties
{
}
