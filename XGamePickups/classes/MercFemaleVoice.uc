//=============================================================================
// Merc Female Voice.
//=============================================================================
class MercFemaleVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.fm_redleader
	NameSound(1)=TauntPack.fm_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.fm_affirmative
	AckSound(1)=TauntPack.fm_got_it
	AckSound(2)=TauntPack.fm_im_on_it
	AckSound(3)=TauntPack.fm_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.fm_im_on_your_team
	FFireSound(1)=TauntPack.fm_im_on_your_team_idiot
	FFireSound(2)=TauntPack.fm_same_team

	////////////////// TAUNTS
	numTaunts=31

	// GENERIC
	TauntSound(0)=TauntPack.fm_and_stay_down
	TauntSound(1)=TauntPack.fm_anyoneelsewantsome
	TauntSound(2)=TauntPack.fm_boom
	TauntSound(3)=TauntPack.fm_burnbaby
	TauntSound(4)=TauntPack.fm_diebitch
	TauntSound(5)=TauntPack.fm_eatthat
	TauntSound(6)=TauntPack.fm_fightlikenali
	TauntSound(7)=TauntPack.fm_isthatyourbest
	TauntSound(8)=TauntPack.fm_kissmyass
	TauntSound(9)=TauntPack.fm_loser
	TauntSound(10)=TauntPack.fm_myhouse
	TauntSound(11)=TauntPack.fm_next
	TauntSound(12)=TauntPack.fm_ohyeah
	TauntSound(13)=TauntPack.fm_ownage
	TauntSound(14)=TauntPack.fm_seeya
	TauntSound(15)=TauntPack.fm_that_had_to_hurt
	TauntSound(16)=TauntPack.fm_useless
	TauntSound(17)=TauntPack.fm_you_play_like_a_girl
	TauntSound(18)=TauntPack.fm_youbedead
	TauntSound(19)=TauntPack.fm_youlikethat
	TauntSound(20)=TauntPack.fm_youwhore

	// CUSTOM
	TauntSound(21)=TauntPack.fm_duck_faster_next_time
	TauntString(21)="Duck Faster Next Time"

	TauntSound(22)=TauntPack.fm_hold_still_dammit
	TauntString(22)="Hold Still Dammit"

	TauntSound(23)=TauntPack.fm_holy_shit
	TauntString(23)="Holy Shit"
	MatureTaunt(23)=1

	TauntSound(24)=TauntPack.fm_just_hold_still_and_ill_make_it_quick
	TauntString(24)="Just Hold Still And I'll Make It Quick"
	TauntAbbrev(24)="Just Hold Still"

	TauntSound(25)=TauntPack.fm_kill_em_all
	TauntString(25)="Kill Em All"

	TauntSound(26)=TauntPack.fm_nailed_him
	TauntString(26)="Nailed Him"

	TauntSound(27)=TauntPack.fm_not_even_close
	TauntString(27)="Not Even Close"

	TauntSound(28)=TauntPack.fm_step_aside
	TauntString(28)="Step Aside"

	TauntSound(29)=TauntPack.fm_suck_on_this
	TauntString(29)="Suck On This"

	TauntSound(30)=TauntPack.fm_try_turning_the_safety_off
	TauntString(30)="Try Turning The Safety Off"

	////////////////// DEATH
	NumDeathPhrases=3

	// GENERIC
	DeathPhrases(0)=TauntPack.fm_medic
	DeathPhrases(1)=TauntPack.fm_nice

	// CUSTOM
	DeathPhrases(2)=TauntPack.fm_not_bad

	////////////////// ORDERS

	OrderSound(0)=TauntPack.fm_defend_the_base
	OrderSound(1)=TauntPack.fm_HoldThisPosition
	OrderSound(2)=TauntPack.fm_attack_their_base
	OrderSound(3)=TauntPack.fm_cover_me
	OrderSound(4)=TauntPack.fm_SearchAndDestroy
	OrderSound(10)=TauntPack.fm_Take_Their_Flag
	OrderSound(11)=TauntPack.fm_Defend_The_Flag
	OrderSound(12)=TauntPack.fm_AttackAlpha
	OrderSound(13)=TauntPack.fm_AttackBravo
	OrderSound(14)=TauntPack.fm_GetTheBall


	////////////////// OTHERS

	OtherSound(0)=TauntPack.fm_base_is_undefended
	OtherSound(1)=TauntPack.fm_get_our_flag_back
	OtherSound(2)=TauntPack.fm_igottheflag
	OtherSound(3)=TauntPack.fm_ive_got_your_back
	OtherSound(4)=TauntPack.fm_im_hit
	OtherSound(5)=TauntPack.fm_man_down
	OtherSound(6)=TauntPack.fm_im_all_alone_here
	OtherSound(7)=TauntPack.fm_Negative
	OtherSound(8)=TauntPack.fm_got_it
	OtherSound(9)=TauntPack.fm_in_position
	OtherSound(10)=TauntPack.fm_im_going_in
	OtherSound(11)=TauntPack.fm_area_secure
	OtherSound(12)=TauntPack.fm_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.fm_i_need_backup
	OtherSound(14)=TauntPack.fm_incoming
	OtherSound(15)=TauntPack.fm_ball_carrier_is_here
	OtherSound(16)=TauntPack.fm_point_alpha_secure
	OtherSound(17)=TauntPack.fm_point_bravo_secure
	OtherSound(18)=TauntPack.fm_attackalpha
	OtherSound(19)=TauntPack.fm_attackbravo
	OtherSound(20)=TauntPack.fm_the_base_is_under_attack
	OtherSound(21)=TauntPack.fm_were_being_overrun
	OtherSound(22)=TauntPack.fm_under_heavy_attack
	OtherSound(23)=TauntPack.fm_defend_point_alpha
	OtherSound(24)=TauntPack.fm_defend_point_bravo
	OtherSound(25)=TauntPack.fm_gettheball
	OtherSound(26)=TauntPack.fm_im_on_defense
	OtherSound(27)=TauntPack.fm_im_on_offense
	OtherSound(28)=TauntPack.fm_take_point_alpha
	OtherSound(29)=TauntPack.fm_take_point_bravo
	OtherSound(30)=TauntPack.fm_medic
	OtherSound(31)=TauntPack.fm_nice

	OtherSound(32)=TauntPack.fm_not_bad
	OtherString(32)="Not Bad"

	VoicePackName="Female Mercenary"
	VoiceGender=VG_Female
}
