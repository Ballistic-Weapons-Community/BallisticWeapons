class KeyBindEdit extends GUIEditBox
   dependsOn(Interactions);

var byte KeyCode;
var string KeyStr;
var bool bCapturing;

Delegate OnInitKey(out byte Key) { Key = 0; }
Delegate OnKeyChanged(byte Key) {}

function InitComponent( GUIController InController, GUIComponent InOwner )
{
   OnInitKey(KeyCode);
   KeyStr = class'Interactions'.static.GetFriendlyName(EInputKey(KeyCode));
   
   if (InStr(KeyStr, "Unknown") != -1 || KeyStr == "Escape")
      KeyStr = "None";
      
   Caption = KeyStr;
   bReadOnly = true;
   Super.InitComponent(InController, InOwner);   
}

function MenuStateChange(eMenuState Newstate)
{
   Super.MenuStateChange(Newstate);
   
   if(Newstate == MSAT_Blurry)
   {
      bCapturing = false;
      Caption = KeyStr;
   }
}

function bool MouseClick(GUIComponent Sender)
{
   bCapturing = true;
   Caption = "";
   return true;
}

function bool InternalOnKeyType(out byte Key, optional string Unicode)
{   
   return false;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
   local string keyName;
   
   if (State != 1 || !bCapturing)
      return false;
   
   //get the keyName from the interaction
   keyName = class'Interactions'.static.GetFriendlyName(EInputKey(Key));
   
   if (InStr(keyName, "Unknown") != -1 || keyName == "Escape")
   {
      KeyCode = 0;
      KeyStr = "None";
      
   }
   else
   {
      KeyCode = Key;
      KeyStr = keyName;
   }
   
   Caption = KeyStr;   
   OnKeyChanged(KeyCode);
   bCapturing = false;
   return true;
}

defaultproperties
{
     bCaptureMouse=True
     OnClick=KeyBindEdit.MouseClick
}
