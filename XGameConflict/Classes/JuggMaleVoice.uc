//=============================================================================
// Jugg Male Voice.
//=============================================================================
class JuggMaleVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.mj_redleader
	NameSound(1)=TauntPack.mj_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.mj_affirmative
	AckSound(1)=TauntPack.mj_got_it
	AckSound(2)=TauntPack.mj_im_on_it
	AckSound(3)=TauntPack.mj_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.mj_im_on_your_team
	FFireSound(1)=TauntPack.mj_im_on_your_team_idiot
	FFireSound(2)=TauntPack.mj_same_team

	////////////////// TAUNTS
	numTaunts=27

	// GENERIC
	TauntSound(0)=TauntPack.mj_and_stay_down
	TauntSound(1)=TauntPack.mj_anyoneelsewantsome
	TauntSound(2)=TauntPack.mj_boom
	TauntSound(3)=TauntPack.mj_burnbaby
	TauntSound(4)=TauntPack.mj_diebitch
	TauntSound(5)=TauntPack.mj_eatthat
	TauntSound(6)=TauntPack.mj_fightlikenali
	TauntSound(7)=TauntPack.mj_isthatyourbest
	TauntSound(8)=TauntPack.mj_kissmyass
	TauntSound(9)=TauntPack.mj_loser
	TauntSound(10)=TauntPack.mj_myhouse
	TauntSound(11)=TauntPack.mj_next
	TauntSound(12)=TauntPack.mj_ohyeah
	TauntSound(13)=TauntPack.mj_ownage
	TauntSound(14)=TauntPack.mj_seeya
	TauntSound(15)=TauntPack.mj_that_had_to_hurt
	TauntSound(16)=TauntPack.mj_useless
	TauntSound(17)=TauntPack.mj_you_play_like_a_girl
	TauntSound(18)=TauntPack.mj_youbedead
	TauntSound(19)=TauntPack.mj_youlikethat
	TauntSound(20)=TauntPack.mj_youwhore

	// CUSTOM
	TauntSound(21)=TauntPack.mj_life_is_pain_get_over_it
	TauntString(21)="Life Is Pain, Get Over It"

	TauntSound(22)=TauntPack.mj_right_between_the_eyes
	TauntString(22)="Right Between The Eyes"

	TauntSound(23)=TauntPack.mj_tag_em_and_bag_em
	TauntString(23)="Tag 'Em And Bag 'Em"

	TauntSound(24)=TauntPack.mj_that_was_nasty
	TauntString(24)="That Was Nasty"

	TauntSound(25)=TauntPack.mj_you_bleed_better_than_you_shoot
	TauntString(25)="You Bleed Better Than You Shoot"

	TauntSound(26)=TauntPack.mj_you_suck
	TauntString(26)="You Suck"

	HumanOnlyTaunt(28)=1
	HumanOnlyTaunt(32)=1

	////////////////// DEATH
	NumDeathPhrases=4

	// GENERIC
	DeathPhrases(0)=TauntPack.mj_medic
	DeathPhrases(1)=TauntPack.mj_nice

	// CUSTOM
	DeathPhrases(2)=TauntPack.mj_cant_feel_my_legs
	DeathPhrases(3)=TauntPack.mj_nice_shot

	////////////////// ORDERS

	OrderSound(0)=TauntPack.mj_defend_the_base
	OrderSound(1)=TauntPack.mj_HoldThisPosition
	OrderSound(2)=TauntPack.mj_attack_their_base
	OrderSound(3)=TauntPack.mj_cover_me
	OrderSound(4)=TauntPack.mj_SearchAndDestroy
	OrderSound(10)=TauntPack.mj_Take_Their_Flag
	OrderSound(11)=TauntPack.mj_Defend_The_Flag
	OrderSound(12)=TauntPack.mj_AttackAlpha
	OrderSound(13)=TauntPack.mj_AttackBravo
	OrderSound(14)=TauntPack.mj_GetTheBall

	////////////////// OTHERS

	OtherSound(0)=TauntPack.mj_base_is_undefended
	OtherSound(1)=TauntPack.mj_get_our_flag_back
	OtherSound(2)=TauntPack.mj_igottheflag
	OtherSound(3)=TauntPack.mj_ive_got_your_back
	OtherSound(4)=TauntPack.mj_im_hit
	OtherSound(5)=TauntPack.mj_man_down
	OtherSound(6)=TauntPack.mj_im_all_alone_here
	OtherSound(7)=TauntPack.mj_Negative
	OtherSound(8)=TauntPack.mj_got_it
	OtherSound(9)=TauntPack.mj_in_position
	OtherSound(10)=TauntPack.mj_im_going_in
	OtherSound(11)=TauntPack.mj_area_secure
	OtherSound(12)=TauntPack.mj_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.mj_i_need_backup
	OtherSound(14)=TauntPack.mj_incoming
	OtherSound(15)=TauntPack.mj_ball_carrier_is_here
	OtherSound(16)=TauntPack.mj_point_alpha_secure
	OtherSound(17)=TauntPack.mj_point_bravo_secure
	OtherSound(18)=TauntPack.mj_attackalpha
	OtherSound(19)=TauntPack.mj_attackbravo
	OtherSound(20)=TauntPack.mj_the_base_is_under_attack
	OtherSound(21)=TauntPack.mj_were_being_overrun
	OtherSound(22)=TauntPack.mj_under_heavy_attack
	OtherSound(23)=TauntPack.mj_defend_point_alpha
	OtherSound(24)=TauntPack.mj_defend_point_bravo
	OtherSound(25)=TauntPack.mj_gettheball
	OtherSound(26)=TauntPack.mj_im_on_defense
	OtherSound(27)=TauntPack.mj_im_on_offense
	OtherSound(28)=TauntPack.mj_take_point_alpha
	OtherSound(29)=TauntPack.mj_take_point_bravo
	OtherSound(30)=TauntPack.mj_medic
	OtherSound(31)=TauntPack.mj_nice

	OtherSound(32)=TauntPack.mj_cant_feel_my_legs
	OtherString(32)="I Can't Feel My Legs"

	OtherSound(33)=TauntPack.mj_nice_shot
	OtherString(33)="Nice Shot"

	VoicePackName="Male Juggernaut"
	VoiceGender=VG_Male
}
