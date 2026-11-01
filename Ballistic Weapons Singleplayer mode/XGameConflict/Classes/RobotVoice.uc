//=============================================================================
// Robot Voice.
//=============================================================================
class RobotVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.r_redleader
	NameSound(1)=TauntPack.r_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.r_affirmative
	AckSound(1)=TauntPack.r_got_it
	AckSound(2)=TauntPack.r_im_on_it
	AckSound(3)=TauntPack.r_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.r_im_on_your_team
	FFireSound(1)=TauntPack.r_im_on_your_team_idiot
	FFireSound(2)=TauntPack.r_same_team

	////////////////// TAUNTS
	numTaunts=32

	// GENERIC
	TauntSound(0)=TauntPack.r_and_stay_down
	TauntSound(1)=TauntPack.r_anyoneelsewantsome
	TauntSound(2)=TauntPack.r_boom
	TauntSound(3)=TauntPack.r_burnbaby
	TauntSound(4)=TauntPack.r_diebitch
	TauntSound(5)=TauntPack.r_eatthat
	TauntSound(6)=TauntPack.r_fightlikenali
	TauntSound(7)=TauntPack.r_isthatyourbest
	TauntSound(8)=TauntPack.r_kissmyass
	TauntSound(9)=TauntPack.r_loser
	TauntSound(10)=TauntPack.r_myhouse
	TauntSound(11)=TauntPack.r_next
	TauntSound(12)=TauntPack.r_ohyeah
	TauntSound(13)=TauntPack.r_ownage
	TauntSound(14)=TauntPack.r_seeya
	TauntSound(15)=TauntPack.r_that_had_to_hurt
	TauntSound(16)=TauntPack.r_useless
	TauntSound(17)=TauntPack.r_you_play_like_a_girl
	TauntSound(18)=TauntPack.r_youbedead
	TauntSound(19)=TauntPack.r_youlikethat
	TauntSound(20)=TauntPack.r_youwhore

	// CUSTOM
	TauntSound(21)=TauntPack.r_die_human
	TauntString(21)="Die Human"

	TauntSound(22)=TauntPack.r_faster_stronger_better
	TauntString(22)="Faster Stronger Better"

	TauntSound(23)=TauntPack.r_fear_me
	TauntString(23)="Fear Me"

	TauntSound(24)=TauntPack.r_flesh_is_a_design_flaw
	TauntString(24)="Flesh Is A Design Flaw"

	TauntSound(25)=TauntPack.r_my_victory_your_death
	TauntString(25)="My Victory Your Death"

	TauntSound(26)=TauntPack.r_not_unacceptable
	TauntString(26)="Not Unacceptable"

	TauntSound(27)=TauntPack.r_rogue_process_terminated
	TauntString(27)="Rogue Process Terminated"

	TauntSound(28)=TauntPack.r_witness_my_perfection
	TauntString(28)="Witness My Perfection"

	TauntSound(29)=TauntPack.r_you_die_too_easily
	TauntString(29)="You Die Too Easily"

	TauntSound(30)=TauntPack.r_you_make_easy_prey
	TauntString(30)="You Make Easy Prey"

	TauntSound(31)=TauntPack.r_your_programming_is_inferior
	TauntString(31)="Your Programming Is Inferior"

	////////////////// DEATH
	NumDeathPhrases=4

	// GENERIC
	DeathPhrases(0)=TauntPack.r_medic
	DeathPhrases(1)=TauntPack.r_nice

	// CUSTOM
	DeathPhrases(2)=TauntPack.r_rerouting_critical_systems
	DeathPhrases(3)=TauntPack.r_you_adapt_well

	////////////////// ORDERS

	OrderSound(0)=TauntPack.r_defend_the_base
	OrderSound(1)=TauntPack.r_HoldThisPosition
	OrderSound(2)=TauntPack.r_attack_their_base
	OrderSound(3)=TauntPack.r_cover_me
	OrderSound(4)=TauntPack.r_SearchAndDestroy
	OrderSound(10)=TauntPack.r_Take_Their_Flag
	OrderSound(11)=TauntPack.r_Defend_The_Flag
	OrderSound(12)=TauntPack.r_AttackAlpha
	OrderSound(13)=TauntPack.r_AttackBravo
	OrderSound(14)=TauntPack.r_GetTheBall


	////////////////// OTHERS

	OtherSound(0)=TauntPack.r_base_is_undefended
	OtherSound(1)=TauntPack.r_get_our_flag_back
	OtherSound(2)=TauntPack.r_igottheflag
	OtherSound(3)=TauntPack.r_ive_got_your_back
	OtherSound(4)=TauntPack.r_im_hit
	OtherSound(5)=TauntPack.r_man_down
	OtherSound(6)=TauntPack.r_im_all_alone_here
	OtherSound(7)=TauntPack.r_Negative
	OtherSound(8)=TauntPack.r_got_it
	OtherSound(9)=TauntPack.r_in_position
	OtherSound(10)=TauntPack.r_im_going_in
	OtherSound(11)=TauntPack.r_area_secure
	OtherSound(12)=TauntPack.r_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.r_i_need_backup
	OtherSound(14)=TauntPack.r_incoming
	OtherSound(15)=TauntPack.r_ball_carrier_is_here
	OtherSound(16)=TauntPack.r_point_alpha_secure
	OtherSound(17)=TauntPack.r_point_bravo_secure
	OtherSound(18)=TauntPack.r_attackalpha
	OtherSound(19)=TauntPack.r_attackbravo
	OtherSound(20)=TauntPack.r_the_base_is_under_attack
	OtherSound(21)=TauntPack.r_were_being_overrun
	OtherSound(22)=TauntPack.r_under_heavy_attack
	OtherSound(23)=TauntPack.r_defend_point_alpha
	OtherSound(24)=TauntPack.r_defend_point_bravo
	OtherSound(25)=TauntPack.r_gettheball
	OtherSound(26)=TauntPack.r_im_on_defense
	OtherSound(27)=TauntPack.r_im_on_offense
	OtherSound(28)=TauntPack.r_take_point_alpha
	OtherSound(29)=TauntPack.r_take_point_bravo
	OtherSound(30)=TauntPack.r_medic
	OtherSound(31)=TauntPack.r_nice

	OtherSound(32)=TauntPack.r_rerouting_critical_systems
	OtherString(32)="Rerouting Critical Systems"

	OtherSound(33)=TauntPack.r_you_adapt_well
	OtherString(33)="You Adapt Well"

	VoicePackName="Robot"
}
