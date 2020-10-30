class BallisticShotgun extends BallisticWeapon
	abstract
	HideDropDown
	CacheExempt;

simulated function OnScopeViewChanged()
{
	Super.OnScopeViewChanged();

	if (Role == ROLE_Authority)
		BallisticShotgunAttachment(ThirdPersonActor).bScoped = bScopeView;
}

defaultproperties
{
	 SightZoomFactor=0.85
}
