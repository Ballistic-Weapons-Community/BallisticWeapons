//=============================================================================
// Alien Male Voice.
//=============================================================================
class AlienMaleVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.mn_redleader
	NameSound(1)=TauntPack.mn_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.mn_affirmative
	AckSound(1)=TauntPack.mn_got_it
	AckSound(2)=TauntPack.mn_im_on_it
	AckSound(3)=TauntPack.mn_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.mn_im_on_your_team
	FFireSound(1)=TauntPack.mn_im_on_your_team_idiot
	FFireSound(2)=TauntPack.mn_same_team

	////////////////// TAUNTS
	numTaunts=28

	// GENERIC
	TauntSound(0)=TauntPack.mn_and_stay_down
	TauntSound(1)=TauntPack.mn_anyoneelsewantsome
	TauntSound(2)=TauntPack.mn_boom
	TauntSound(3)=TauntPack.mn_burnbaby
	TauntSound(4)=TauntPack.mn_diebitch
	TauntSound(5)=TauntPack.mn_eatthat
	TauntSound(6)=TauntPack.mn_fightlikenali
	TauntSound(7)=TauntPack.mn_isthatyourbest
	TauntSound(8)=TauntPack.mn_kissmyass
	TauntSound(9)=TauntPack.mn_loser
	TauntSound(10)=TauntPack.mn_myhouse
	TauntSound(11)=TauntPack.mn_next
	TauntSound(12)=TauntPack.mn_ohyeah
	TauntSound(13)=TauntPack.mn_ownage
	TauntSound(14)=TauntPack.mn_seeya
	TauntSound(15)=TauntPack.mn_that_had_to_hurt
	TauntSound(16)=TauntPack.mn_useless
	TauntSound(17)=TauntPack.mn_you_play_like_a_girl
	TauntSound(18)=TauntPack.mn_youbedead
	TauntSound(19)=TauntPack.mn_youlikethat
	TauntSound(20)=TauntPack.mn_youwhore

	TauntSound(21)=TauntPack.mn_blowme
	TauntSound(22)=TauntPack.mn_camper
	TauntSound(23)=TauntPack.mn_douchebag
	TauntSound(24)=TauntPack.mn_spammer
	TauntSound(25)=TauntPack.mn_sucker
	TauntSound(26)=TauntPack.mn_talktothehand
	TauntSound(27)=TauntPack.mn_youdick

	TauntString(21)="Blow me"
	TauntString(22)="Camper!"
	TauntString(23)="Douche bag!"
	TauntString(24)="Spammer!"
	TauntString(25)="Sucker"
	TauntString(26)="Talk to the hand"
	TauntString(27)="You dick!"

	MatureTaunt(21)=1
	MatureTaunt(23)=1
	MatureTaunt(27)=1

	HumanOnlyTaunt(22)=1
	HumanOnlyTaunt(24)=1
	HumanOnlyTaunt(26)=1

	////////////////// DEATH
	NumDeathPhrases=2

	// GENERIC
	DeathPhrases(0)=TauntPack.mn_medic
	DeathPhrases(1)=TauntPack.mn_nice

	// CUSTOM

	////////////////// ORDERS

	OrderSound(0)=TauntPack.mn_defend_the_base
	OrderSound(1)=TauntPack.mn_HoldThisPosition
	OrderSound(2)=TauntPack.mn_attack_their_base
	OrderSound(3)=TauntPack.mn_cover_me
	OrderSound(4)=TauntPack.mn_SearchAndDestroy
	OrderSound(10)=TauntPack.mn_Take_Their_Flag
	OrderSound(11)=TauntPack.mn_Defend_The_Flag
	OrderSound(12)=TauntPack.mn_AttackAlpha
	OrderSound(13)=TauntPack.mn_AttackBravo
	OrderSound(14)=TauntPack.mn_GetTheBall

	////////////////// OTHERS

	OtherSound(0)=TauntPack.mn_base_is_undefended
	OtherSound(1)=TauntPack.mn_get_our_flag_back
	OtherSound(2)=TauntPack.mn_igottheflag
	OtherSound(3)=TauntPack.mn_ive_got_your_back
	OtherSound(4)=TauntPack.mn_im_hit
	OtherSound(5)=TauntPack.mn_man_down
	OtherSound(6)=TauntPack.mn_im_all_alone_here
	OtherSound(7)=TauntPack.mn_Negative
	OtherSound(8)=TauntPack.mn_got_it
	OtherSound(9)=TauntPack.mn_in_position
	OtherSound(10)=TauntPack.mn_im_going_in
	OtherSound(11)=TauntPack.mn_area_secure
	OtherSound(12)=TauntPack.mn_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.mn_i_need_backup
	OtherSound(14)=TauntPack.mn_incoming
	OtherSound(15)=TauntPack.mn_ball_carrier_is_here
	OtherSound(16)=TauntPack.mn_point_alpha_secure
	OtherSound(17)=TauntPack.mn_point_bravo_secure
	OtherSound(18)=TauntPack.mn_attackalpha
	OtherSound(19)=TauntPack.mn_attackbravo
	OtherSound(20)=TauntPack.mn_the_base_is_under_attack
	OtherSound(21)=TauntPack.mn_were_being_overrun
	OtherSound(22)=TauntPack.mn_under_heavy_attack
	OtherSound(23)=TauntPack.mn_defend_point_alpha
	OtherSound(24)=TauntPack.mn_defend_point_bravo
	OtherSound(25)=TauntPack.mn_gettheball
	OtherSound(26)=TauntPack.mn_im_on_defense
	OtherSound(27)=TauntPack.mn_im_on_offense
	OtherSound(28)=TauntPack.mn_take_point_alpha
	OtherSound(29)=TauntPack.mn_take_point_bravo
	OtherSound(30)=TauntPack.mn_medic
	OtherSound(31)=TauntPack.mn_nice

	VoicePackName="Male Alien"
	VoiceGender=VG_Male
}
