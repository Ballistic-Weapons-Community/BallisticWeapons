//=============================================================================
// xDOMMonitorA - Domination monitor (two screens).
//=============================================================================
class xDOMMonitorA extends xDOMMonitor;

defaultproperties
{   
    Tag='DomChangeA'
    RedShader=Material'RedScreenAS'
    BlueShader=Material'BlueScreenAS'
    ActiveShader=Material'GreyScreenAS'    
    InactiveShader=Material'BlackScreenAS'
}
