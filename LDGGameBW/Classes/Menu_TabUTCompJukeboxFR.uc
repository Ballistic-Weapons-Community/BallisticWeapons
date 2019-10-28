class Menu_TabUTCompJukeboxFR extends UT2k3TabPanel;

var GUIButton b_RefreshButton;
var GUIButton b_DownloadButton;
var GUIButton b_InstallButton;

var moComboBox co_MusicComboBox;

var moCheckBox ch_OverrideLevelMusic, ch_AutoDownloadLevelMusic;

var GUILabel l_Info;
var GUILabel l_MusicForThisMap;

var string MusicForThisMapText;
var color GoldColor;

var StreamInteraction       Handler;
var StreamInterface         FileManager;

var bool bRefreshing;

var string NoDownloadText;
var string ManualDownloadText;
var string AutomatedDownloadText;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	l_Info = GUILabel(Controls[1]);
	l_MusicForThisMap = GUILabel(Controls[2]);
	co_MusicComboBox = moComboBox(Controls[3]);
	ch_OverrideLevelMusic = moCheckBox(Controls[4]);
	ch_AutoDownloadLevelMusic = moCheckBox(Controls[5]);
	b_DownloadButton = GUIButton(Controls[6]);
	b_RefreshButton = GUIButton(Controls[7]);
	b_InstallButton = GUIButton(Controls[8]);
	
	Super.InitComponent(MyController, MyOwner);
}

event Opened(GUIComponent Sender)
{
	local string Song;
	local Freon_Player_UTComp_LDG PC;

	Super.Opened(Sender);

	PC = Freon_Player_UTComp_LDG(PlayerOwner());
	Song = PC.LevelOriginalSong;
	
	if (Song == "" || Song ~= "None")
		Song = "None";
	
	l_MusicForThisMap.Caption = MusicForThisMapText $ class'Gameinfo'.Static.MakeColorCode(GoldColor) $ Song;
	
	if (PC.bClientMusicDownloadInstalled)
		l_Info.Caption = AutomatedDownloadText;
	else if (PC.ClientMusicDownloadURL ~= "")
	{
		l_Info.Caption = NoDownloadText;
		b_DownloadButton.DisableMe();
		b_RefreshButton.DisableMe();
		ch_AutoDownloadLevelMusic.DisableMe();
	}
	else
	{
		l_Info.Caption = ManualDownloadText;
		ch_AutoDownloadLevelMusic.DisableMe();
	}
	
	if (SetFileManager())
		RefreshMusicList();
		
	bRefreshing = true;
	Song = PC.JKList.GetEntry(Left(string(PC.Level), InStr(string(PC.Level), ".")));
	ch_OverrideLevelMusic.Checked(song != "");
	if (PC.bClientMusicDownloadInstalled)
		ch_AutoDownloadLevelMusic.Checked(class'UTComp_xPlayer'.default.bDoDownloadMusic);
	else
		ch_AutoDownloadLevelMusic.Checked(false);
		
	if (PC.Loader == None || PC.Loader.bDownloaderInstalled)
		b_InstallButton.DisableMe();
		
	bRefreshing = false;
}

function bool SetFileManager()
{
	local int i;
	local PlayerController PC;
	
	PC = PlayerOwner();

	for ( i = 0; i < PC.Player.LocalInteractions.Length; i++ )
	{
		if ( StreamInteraction(PC.Player.LocalInteractions[i]) != None )
		{
			Handler = StreamInteraction(PC.Player.LocalInteractions[i]);
			FileManager = Handler.FileManager;
			return true;
		}
	}
	
	log("UTComp_Menu_Jukebox.SetFileManager() - no StreamInteractions found!");
	return false;
}

function RefreshMusicList()
{
	local int i, c, curr, pos;
	local array<string> MusicDirFiles;
	local string MusicName, MusicDir, MySong;
	local Freon_Player_UTComp_LDG PC;
	
	bRefreshing = true;
	PC = Freon_Player_UTComp_LDG(PlayerOwner());
	MusicDir = FileManager.GetBaseDirectory() $ "\\";
	co_MusicComboBox.ResetComponent();
	curr = -1;

	FileManager.GetDirectoryContents(MusicDirFiles, MusicDir, FILE_Stream);	
	MySong = PC.JKList.GetEntry(Left(string(PC.Level), InStr(string(PC.Level), ".")));
	if (MySong == "")
		MySong = PC.Level.Song;
	
	c = 0;
	
	for (i = 0; i < MusicDirFiles.Length; i++)
	{
		//Log("Music: " $ MusicDirFiles[i]);
		pos = InStr(Caps(MusicDirFiles[i]), ".OGG");
		
		if (pos != -1)
		{
			MusicName = Left(MusicDirFiles[i], pos);
			co_MusicComboBox.AddItem(MusicName);
			
			if (MusicName ~= MySong)
				curr = c;
			
			c++;
		}
	}
	
	if (curr == -1)
		co_MusicComboBox.SetIndex(0);
	else
		co_MusicComboBox.SetIndex(curr);
		
	bRefreshing = false;
}

function InternalOnChange(GUIComponent C)
{
	local Freon_Player_UTComp_LDG PC;
	local string Song;
	
	if (bRefreshing)
		return;
	
	PC = Freon_Player_UTComp_LDG(PlayerOwner());
	
	switch(C)
	{			
		case co_MusicComboBox:		
			if (ch_OverrideLevelMusic.IsChecked())		
			{
				PC.JKList.NewEntry(Left(string(PC.Level), InStr(string(PC.Level), ".")), co_MusicComboBox.GetItem(co_MusicComboBox.GetIndex()));
				Song = co_MusicComboBox.GetItem(co_MusicComboBox.GetIndex());
				PC.Level.Song = Song;
				PC.LevelCurrentSong = Song;
				PC.ClientSetMusic(Song, MTRAN_Fade);
			}
			break;
			
		case ch_OverrideLevelMusic:
			if (ch_OverrideLevelMusic.IsChecked())		
			{
				PC.JKList.NewEntry(Left(string(PC.Level), InStr(string(PC.Level), ".")), co_MusicComboBox.GetItem(co_MusicComboBox.GetIndex()));
				Song = co_MusicComboBox.GetItem(co_MusicComboBox.GetIndex());
				PC.Level.Song = Song;
				PC.LevelCurrentSong = Song;
				PC.ClientSetMusic(Song, MTRAN_Fade);
			}
			else
			{
				PC.JKList.RemoveEntry(Left(string(PC.Level), InStr(string(PC.Level), ".")));
				PC.Level.Song = PC.LevelOriginalSong;
				PC.LevelCurrentSong = PC.LevelOriginalSong;
				
				if (!PC.bClientMusicDownloadInstalled)
					PC.ClientSetMusic(PC.LevelOriginalSong, MTRAN_Fade);
				else
				{
					// Maybe we need to download it first
					if (PC.Loader != None && PC.Loader.bDownloaderInstalled)
					{
						if (!PC.Loader.IsMusicDownloaded(PC.LevelOriginalSong) && PC.LevelOriginalSong != "" && PC.LevelOriginalSong != "None")
						{
							if (!PC.Loader.DownloadMusic(Repl(PC.ClientMusicDownloadURL $ "/" $ PC.LevelOriginalSong, " ", "%20") $ ".ogg", PC.LevelOriginalSong))
								Log("Tried downloading " $ PC.LevelOriginalSong $ ".ogg but failed!");
						}
						else
							PC.ClientSetMusic(PC.LevelOriginalSong, MTRAN_Fade);
					}
					else
						PC.ClientSetMusic(PC.LevelOriginalSong, MTRAN_Fade);
				}
			}
			break;
			
		case ch_AutoDownloadLevelMusic:
			class'UTComp_xPlayer'.default.bDoDownloadMusic = ch_AutoDownloadLevelMusic.IsChecked();
			class'UTComp_xPlayer'.static.StaticSaveConfig();
			break;
	}
}

function bool InternalOnClick( GUIComponent Sender )
{
	local Freon_Player_UTComp_LDG PC;
	
	PC = Freon_Player_UTComp_LDG(PlayerOwner());
	
	switch (Sender)
	{			
		case b_DownloadButton:
			PC.ConsoleCommand("open " $ PC.ClientMusicDownloadURL);
			return true;
			
		case b_RefreshButton:
			if (SetFileManager())
				RefreshMusicList();
			
			if (!ch_OverrideLevelMusic.IsChecked())
				PC.ClientSetMusic(PC.Level.Song, MTRAN_Fade);
				
			return true;
			
		case b_InstallButton:
			if (PC.Loader != None && !PC.Loader.bDownloaderInstalled)
				PC.Loader.CheckOpenInstallDialogMenu();
			return true;
	}
	
  return true;
}

defaultproperties
{
     MusicForThisMapText="Music for this map: "
     GoldColor=(G=200,R=230)
     NoDownloadText="Don't have the music for this level? Doesn't matter. You can play your own music for this level.||To play custom music in this map, select it in the combo box and check "Override level music"."
     ManualDownloadText="Don't have the music for this level? Doesn't matter. You can play your own music for this level or download the original music.||To play custom music in this map, select it in the combo box and check "Override level music". To revert to the default music for the map uncheck "Override level music."||To download the custom music from our server, click on the "Download" button (opens your web browser) and download the music file to your UT2004 Music directory. Then press the "Refresh" button."
     AutomatedDownloadText="UTComp will automatically download the music from the server if you don't have it installed.||To play custom music in this map, select it in the combo box and check "Override level music". To revert to the default music for the map uncheck "Override level music."||To download other music from our server, click on the "Download" button (opens your web browser) and download the music file to your UT2004 Music directory. Then press the "Refresh" button."
     Begin Object Class=GUIImage Name=TabBackground
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(B=0,G=0,R=0)
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         bNeverFocus=True
     End Object
     Controls(0)=GUIImage'LDGGameBW.Menu_TabUTCompJukeboxFR.TabBackground'

     Begin Object Class=GUILabel Name=Info
         TextColor=(B=255,G=255,R=255)
         bMultiLine=True
         WinTop=0.050000
         WinLeft=0.096875
         WinWidth=0.806250
         WinHeight=0.500000
     End Object
     Controls(1)=GUILabel'LDGGameBW.Menu_TabUTCompJukeboxFR.Info'

     Begin Object Class=GUILabel Name=MusicForThisMap
         TextColor=(B=255,G=255,R=255)
         WinTop=0.505000
         WinLeft=0.296875
         WinHeight=0.040000
     End Object
     Controls(2)=GUILabel'LDGGameBW.Menu_TabUTCompJukeboxFR.MusicForThisMap'

     Begin Object Class=moComboBox Name=MusicComboBox
         bReadOnly=True
         Caption="Music List"
         OnCreateComponent=MusicComboBox.InternalOnCreateComponent
         WinTop=0.555000
         WinLeft=0.296875
         WinWidth=0.400000
         WinHeight=0.060000
         OnChange=Menu_TabUTCompJukeboxFR.InternalOnChange
     End Object
     Controls(3)=moComboBox'LDGGameBW.Menu_TabUTCompJukeboxFR.MusicComboBox'

     Begin Object Class=moCheckBox Name=OverrideLevelMusic
         Caption="Override level music"
         OnCreateComponent=OverrideLevelMusic.InternalOnCreateComponent
         WinTop=0.605000
         WinLeft=0.296875
         WinWidth=0.400000
         WinHeight=0.060000
         OnChange=Menu_TabUTCompJukeboxFR.InternalOnChange
     End Object
     Controls(4)=moCheckBox'LDGGameBW.Menu_TabUTCompJukeboxFR.OverrideLevelMusic'

     Begin Object Class=moCheckBox Name=AutoDownloadLevelMusic
         Caption="Automatically download music"
         OnCreateComponent=AutoDownloadLevelMusic.InternalOnCreateComponent
         WinTop=0.655000
         WinLeft=0.296875
         WinWidth=0.400000
         WinHeight=0.060000
         OnChange=Menu_TabUTCompJukeboxFR.InternalOnChange
     End Object
     Controls(5)=moCheckBox'LDGGameBW.Menu_TabUTCompJukeboxFR.AutoDownloadLevelMusic'

     Begin Object Class=GUIButton Name=DownloadButton
         Caption="Download"
         WinTop=0.705000
         WinLeft=0.297076
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=Menu_TabUTCompJukeboxFR.InternalOnClick
         OnKeyEvent=DownloadButton.InternalOnKeyEvent
     End Object
     Controls(6)=GUIButton'LDGGameBW.Menu_TabUTCompJukeboxFR.DownloadButton'

     Begin Object Class=GUIButton Name=RefreshButton
         Caption="Refresh"
         WinTop=0.705000
         WinLeft=0.517076
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=Menu_TabUTCompJukeboxFR.InternalOnClick
         OnKeyEvent=RefreshButton.InternalOnKeyEvent
     End Object
     Controls(7)=GUIButton'LDGGameBW.Menu_TabUTCompJukeboxFR.RefreshButton'

     Begin Object Class=GUIButton Name=InstallButton
         Caption="Install Downloader"
         WinTop=0.775000
         WinLeft=0.297076
         WinWidth=0.400000
         WinHeight=0.060000
         OnClick=Menu_TabUTCompJukeboxFR.InternalOnClick
         OnKeyEvent=InstallButton.InternalOnKeyEvent
     End Object
     Controls(8)=GUIButton'LDGGameBW.Menu_TabUTCompJukeboxFR.InstallButton'

}
