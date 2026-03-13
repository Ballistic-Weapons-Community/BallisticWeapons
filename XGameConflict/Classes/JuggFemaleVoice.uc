//=============================================================================
// Jugg Female Voice.
//=============================================================================
class JuggFemaleVoice extends xVoicePack;

#exec OBJ LOAD FILE=TauntPack.uax

defaultproperties
{
	NameSound(0)=TauntPack.fj_redleader
	NameSound(1)=TauntPack.fj_blueleader

	////////////////// ACKNOWELDGEMENTS
	AckSound(0)=TauntPack.fj_affirmative
	AckSound(1)=TauntPack.fj_got_it
	AckSound(2)=TauntPack.fj_im_on_it
	AckSound(3)=TauntPack.fj_roger

	////////////////// FRIENDLY FIRE
	FFireSound(0)=TauntPack.fj_im_on_your_team
	FFireSound(1)=TauntPack.fj_im_on_your_team_idiot
	FFireSound(2)=TauntPack.fj_same_team

	////////////////// TAUNTS
	numTaunts=28

	// GENERIC
	TauntSound(0)=TauntPack.fj_and_stay_down
	TauntSound(1)=TauntPack.fj_anyoneelsewantsome
	TauntSound(2)=TauntPack.fj_boom
	TauntSound(3)=TauntPack.fj_burnbaby
	TauntSound(4)=TauntPack.fj_diebitch
	TauntSound(5)=TauntPack.fj_eatthat
	TauntSound(6)=TauntPack.fj_fightlikenali
	TauntSound(7)=TauntPack.fj_isthatyourbest
	TauntSound(8)=TauntPack.fj_kissmyass
	TauntSound(9)=TauntPack.fj_loser
	TauntSound(10)=TauntPack.fj_myhouse
	TauntSound(11)=TauntPack.fj_next
	TauntSound(12)=TauntPack.fj_ohyeah
	TauntSound(13)=TauntPack.fj_ownage
	TauntSound(14)=TauntPack.fj_seeya
	TauntSound(15)=TauntPack.fj_that_had_to_hurt
	TauntSound(16)=TauntPack.fj_useless
	TauntSound(17)=TauntPack.fj_you_play_like_a_girl
	TauntSound(18)=TauntPack.fj_youbedead
	TauntSound(19)=TauntPack.fj_youlikethat
	TauntSound(20)=TauntPack.fj_youwhore

	// CUSTOM
	TauntSound(21)=TauntPack.fj_life_is_pain_get_over_it
	TauntString(21)="Life Is Pain, Get Over It"

	TauntSound(22)=TauntPack.fj_right_between_the_eyes
	TauntString(22)="Right Between The Eyes"

	TauntSound(23)=TauntPack.fj_tag_em_and_bag_em
	TauntString(23)="Tag 'Em And Bag 'Em"

	TauntSound(24)=TauntPack.fj_that_was_nasty
	TauntString(24)="That Was Nasty"

	TauntSound(25)=TauntPack.fj_you_bleed_better_than_you_shoot
	TauntString(25)="You Bleed Better Than You Shoot"

	TauntSound(26)=TauntPack.fj_you_suck
	TauntString(26)="You Suck"

	TauntSound(27)=TauntPack.fj_blowme
	TauntString(27)="Lick me"
	MatureTaunt(27)=1

	////////////////// DEATH
	NumDeathPhrases=4

	// GENERIC
	DeathPhrases(0)=TauntPack.fj_medic
	DeathPhrases(1)=TauntPack.fj_nice

	// CUSTOM
	DeathPhrases(2)=TauntPack.fj_cant_feel_my_legs
	DeathPhrases(3)=TauntPack.fj_nice_shot

	////////////////// ORDERS

	OrderSound(0)=TauntPack.fj_defend_the_base
	OrderSound(1)=TauntPack.fj_HoldThisPosition
	OrderSound(2)=TauntPack.fj_attack_their_base
	OrderSound(3)=TauntPack.fj_cover_me
	OrderSound(4)=TauntPack.fj_SearchAndDestroy
	OrderSound(10)=TauntPack.fj_Take_Their_Flag
	OrderSound(11)=TauntPack.fj_Defend_The_Flag
	OrderSound(12)=TauntPack.fj_AttackAlpha
	OrderSound(13)=TauntPack.fj_AttackBravo
	OrderSound(14)=TauntPack.fj_GetTheBall

	////////////////// OTHERS

	OtherSound(0)=TauntPack.fj_base_is_undefended
	OtherSound(1)=TauntPack.fj_get_our_flag_back
	OtherSound(2)=TauntPack.fj_igottheflag
	OtherSound(3)=TauntPack.fj_ive_got_your_back
	OtherSound(4)=TauntPack.fj_im_hit
	OtherSound(5)=TauntPack.fj_man_down
	OtherSound(6)=TauntPack.fj_im_all_alone_here
	OtherSound(7)=TauntPack.fj_Negative
	OtherSound(8)=TauntPack.fj_got_it
	OtherSound(9)=TauntPack.fj_in_position
	OtherSound(10)=TauntPack.fj_im_going_in
	OtherSound(11)=TauntPack.fj_area_secure
	OtherSound(12)=TauntPack.fj_enemy_flag_carrier_is_here
	OtherSound(13)=TauntPack.fj_i_need_backup
	OtherSound(14)=TauntPack.fj_incoming
	OtherSound(15)=TauntPack.fj_ball_carrier_is_here
	OtherSound(16)=TauntPack.fj_point_alpha_secure
	OtherSound(17)=TauntPack.fj_point_bravo_secure
	OtherSound(18)=TauntPack.fj_attackalpha
	OtherSound(19)=TauntPack.fj_attackbravo
	OtherSound(20)=TauntPack.fj_the_base_is_under_attack
	OtherSound(21)=TauntPack.fj_were_being_overrun
	OtherSound(22)=TauntPack.fj_under_heavy_attack
	OtherSound(23)=TauntPack.fj_defend_point_alpha
	OtherSound(24)=TauntPack.fj_defend_point_bravo
	OtherSound(25)=TauntPack.fj_gettheball
	OtherSound(26)=TauntPack.fj_im_on_defense
	OtherSound(27)=TauntPack.fj_im_on_offense
	OtherSound(28)=TauntPack.fj_take_point_alpha
	OtherSound(29)=TauntPack.fj_take_point_bravo
	OtherSound(30)=TauntPack.fj_medic
	OtherSound(31)=TauntPack.fj_nice

	OtherSound(32)=TauntPack.fj_cant_feel_my_legs
	OtherString(32)="I Can't Feel My Legs"

	OtherSound(33)=TauntPack.fj_nice_shot
	OtherString(33)="Nice Shot"

	VoicePackName="Female Juggernaut"
	VoiceGender=VG_Female
}
