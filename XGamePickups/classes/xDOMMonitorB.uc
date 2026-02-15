//=============================================================================
// xDOMMonitorB - Domination monitor (two screens).
//=============================================================================
class xDOMMonitorB extends xDOMMonitor;

defaultproperties
{   
    Tag='DomChangeB'
    RedShader=Material'RedScreenBS'
    BlueShader=Material'BlueScreenBS'
    ActiveShader=Material'GreyScreenBS'    
    InactiveShader=Material'BlackScreenBS'    
}
