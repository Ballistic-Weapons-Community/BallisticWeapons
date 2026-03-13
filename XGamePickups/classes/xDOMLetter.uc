//=============================================================================
// xDomLetter.
//=============================================================================
class xDomLetter extends Decoration
    abstract;

#exec OBJ LOAD FILE=XGameTextures.utx

var() Material  RedTeamShader;
var() Material  BlueTeamShader;
var() Material  NeutralShader;

defaultproperties
{   
    Skins(0)=Shader'XGameTextures.SuperPickups.DomABGS'
    RedTeamShader=Shader'XGameTextures.SuperPickups.DomABRS'
    BlueTeamShader=Shader'XGameTextures.SuperPickups.DomABBS'
    NeutralShader=Shader'XGameTextures.SuperPickups.DomABGS'
    bNetNotify=true
}
