//=============================================================================
// Merc Male Voice.
//=============================================================================
class MercMaleVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.mm_redleader
	NameSound(1)=TauntPack.mm_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.mm_affirmative
	AckSound(1)=TauntPack.mm_got_it
	AckSound(2)=TauntPack.mm_im_on_it
	AckSound(3)=TauntPack.mm_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.mm_im_on_your_team
	FFireSound(1)=TauntPack.mm_im_on_your_team_idiot
	FFireSound(2)=TauntPack.mm_same_team

	////////////////// TAUNTS
	numTaunts=32

	// GENERIC
	TauntSound(0)=TauntPack.mm_and_stay_down
	TauntSound(1)=TauntPack.mm_anyoneelsewantsome
	TauntSound(2)=TauntPack.mm_boom
	TauntSound(3)=TauntPack.mm_burnbaby
	TauntSound(4)=TauntPack.mm_diebitch
	TauntSound(5)=TauntPack.mm_eatthat
	TauntSound(6)=TauntPack.mm_fightlikenali
	TauntSound(7)=TauntPack.mm_isthatyourbest
	TauntSound(8)=TauntPack.mm_kissmyass
	TauntSound(9)=TauntPack.mm_loser
	TauntSound(10)=TauntPack.mm_myhouse
	TauntSound(11)=TauntPack.mm_next
	TauntSound(12)=TauntPack.mm_ohyeah
	TauntSound(13)=TauntPack.mm_ownage
	TauntSound(14)=TauntPack.mm_seeya
	TauntSound(15)=TauntPack.mm_that_had_to_hurt
	TauntSound(16)=TauntPack.mm_useless
	TauntSound(17)=TauntPack.mm_you_play_like_a_girl
	TauntSound(18)=TauntPack.mm_youbedead
	TauntSound(19)=TauntPack.mm_youlikethat
	TauntSound(20)=TauntPack.mm_youwhore

	// CUSTOM
	TauntSound(21)=TauntPack.mm_duck_faster_next_time
	TauntString(21)="Duck Faster Next Time"

	TauntSound(22)=TauntPack.mm_hold_still_dammit
	TauntString(22)="Hold Still Dammit"

	TauntSound(23)=TauntPack.mm_holy_shit
	TauntString(23)="Holy Shit"

	TauntSound(24)=TauntPack.mm_just_hold_still_and_ill_make_it_quick
	TauntString(24)="Just Hold Still And I'll Make It Quick"
	TauntAbbrev(24)="Just Hold Still"

	TauntSound(25)=TauntPack.mm_kill_em_all
	TauntString(25)="Kill Em All"

	TauntSound(26)=TauntPack.mm_nailed_him
	TauntString(26)="Nailed Him"

	TauntSound(27)=TauntPack.mm_not_even_close
	TauntString(27)="Not Even Close"

	TauntSound(28)=TauntPack.mm_step_aside
	TauntString(28)="Step Aside"

	TauntSound(29)=TauntPack.mm_suck_on_this
	TauntString(29)="Suck On This"

	TauntSound(30)=TauntPack.mm_try_turning_the_safety_off
	TauntString(30)="Try Turning The Safety Off"

	TauntSound(31)=TauntPack.mm_you_die_too_easily
	TauntString(31)="You Die Too Easily"

	MatureTaunt(23)=1

	////////////////// DEATH
	NumDeathPhrases=3

	// GENERIC
	DeathPhrases(0)=TauntPack.mm_medic
	DeathPhrases(1)=TauntPack.mm_nice

	// CUSTOM
	DeathPhrases(2)=TauntPack.mm_not_bad

	////////////////// ORDERS

	OrderSound(0)=TauntPack.mm_defend_the_base
	OrderSound(1)=TauntPack.mm_HoldThisPosition
	OrderSound(2)=TauntPack.mm_attack_their_base
	OrderSound(3)=TauntPack.mm_cover_me
	OrderSound(4)=TauntPack.mm_SearchAndDestroy
	OrderSound(10)=TauntPack.mm_Take_Their_Flag
	OrderSound(11)=TauntPack.mm_Defend_The_Flag
	OrderSound(12)=TauntPack.mm_AttackAlpha
	OrderSound(13)=TauntPack.mm_AttackBravo
	OrderSound(14)=TauntPack.mm_GetTheBall


	////////////////// OTHERS

	OtherSound(0)=TauntPack.mm_base_is_undefended
	OtherSound(1)=TauntPack.mm_get_our_flag_back
	OtherSound(2)=TauntPack.mm_igottheflag
	OtherSound(3)=TauntPack.mm_ive_got_your_back
	OtherSound(4)=TauntPack.mm_im_hit
	OtherSound(5)=TauntPack.mm_man_down
	OtherSound(6)=TauntPack.mm_im_all_alone_here
	OtherSound(7)=TauntPack.mm_Negative
	OtherSound(8)=TauntPack.mm_got_it
	OtherSound(9)=TauntPack.mm_in_position
	OtherSound(10)=TauntPack.mm_im_going_in
	OtherSound(11)=TauntPack.mm_area_secure
	OtherSound(12)=TauntPack.mm_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.mm_i_need_backup
	OtherSound(14)=TauntPack.mm_incoming
	OtherSound(15)=TauntPack.mm_ball_carrier_is_here
	OtherSound(16)=TauntPack.mm_point_alpha_secure
	OtherSound(17)=TauntPack.mm_point_bravo_secure
	OtherSound(18)=TauntPack.mm_attackalpha
	OtherSound(19)=TauntPack.mm_attackbravo
	OtherSound(20)=TauntPack.mm_the_base_is_under_attack
	OtherSound(21)=TauntPack.mm_were_being_overrun
	OtherSound(22)=TauntPack.mm_under_heavy_attack
	OtherSound(23)=TauntPack.mm_defend_point_alpha
	OtherSound(24)=TauntPack.mm_defend_point_bravo
	OtherSound(25)=TauntPack.mm_gettheball
	OtherSound(26)=TauntPack.mm_im_on_defense
	OtherSound(27)=TauntPack.mm_im_on_offense
	OtherSound(28)=TauntPack.mm_take_point_alpha
	OtherSound(29)=TauntPack.mm_take_point_bravo
	OtherSound(30)=TauntPack.mm_medic
	OtherSound(31)=TauntPack.mm_nice

	OtherSound(32)=TauntPack.mm_not_bad
	OtherString(32)="Not Bad"

	VoicePackName="Male Mercenary"
	VoiceGender=VG_Male
}
