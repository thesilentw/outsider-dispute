/// ODWeapon.zsc
/// outsider-dispute prototype weapon
///
Class ODWeapon : DoomWeapon abstract {
//for some reason abstract doesn't work, which irritates me
	default {
		inventory.pickupMessage "OBTAINED DEFAULT WEAPON - THIS IS A BUG - PLEASE REPORT THIS!";
		weapon.slotNumber 1;
		weapon.SelectionOrder 1000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "Clip";
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 0.8;
		Weapon.BobRangeY 1.0;
		+WEAPON.NODEATHINPUT;
		Decal "BulletChip";
		Weapon.yadjust 11;
	}	
	
    enum ComboWeaponConstants {
        WRF_ALL =	WRF_ALLOWRELOAD|WRF_ALLOWZOOM|
					WRF_ALLOWUSER1|WRF_ALLOWUSER2|
					WRF_ALLOWUSER3|WRF_ALLOWUSER4,
        WRF_NONE = 	WRF_NOFIRE|WRF_DISABLESWITCH,
    }
    action void SetWeaponState(statelabel st,int layer=PSP_WEAPON) {
        if(player) player.setpsprite(layer,invoker.findstate(st));
    }
    action bool PressingFire(){return player.cmd.buttons & BT_ATTACK;}
    action bool PressingAltfire(){return player.cmd.buttons & BT_ALTATTACK;}
    action bool PressingReload(){return player.cmd.buttons & BT_RELOAD;}
    action bool PressingZoom(){return player.cmd.buttons & BT_ZOOM;}
    action bool PressingUser1(){return player.cmd.buttons & BT_USER1;}
    action bool PressingUser2(){return player.cmd.buttons & BT_USER2;}
    action bool PressingUser3(){return player.cmd.buttons & BT_USER3;}
    action bool PressingUser4(){return player.cmd.buttons & BT_USER4;}
    action bool PressingUse(){return player.cmd.buttons & BT_USE;}
    action bool JustPressed(int which) {
        return player.cmd.buttons & which && !(player.oldbuttons & which);
    }
    action bool JustReleased(int which) {
        return !(player.cmd.buttons & which) && player.oldbuttons & which;
    }
    action double TurnSpeed() {
        return((double(player.cmd.pitch),double(player.cmd.yaw)).length());
    }
    double LastCheckedTurnSpeed;
    action bool JustPressedFire() {
        return (player.cmd.buttons & BT_ATTACK && !(player.oldbuttons & BT_ATTACK));
    }
    int PreviousTicsButtons[16];
	
	action bool	A_MeleeWithResult(int damage = 0, bool canZerk = true) {
		FTranslatedLineTarget t;
		
		int attackDamage = damage; //(random(1,2)*15);		
		
		if (FindInventory("PowerStrength") && canZerk) {
			attackDamage = damage*10; //(random(1,3)*80);
		}
		
		double ang = angle + Random2[Punch]() * (5.625 / 256);
		double pitch = AimLineAttack (ang, DEFMELEERANGE, null, 0., ALF_CHECK3D);

		LineAttack (ang, DEFMELEERANGE, pitch, attackDamage, 'Melee', "BulletPuff", LAF_ISMELEEATTACK, t);

		// turn to face target
		if (t.linetarget)
		{
			A_PlaySound ("*fist", CHAN_WEAPON);
			angle = t.angleFromSource;
			return true;
		}
		else {
			return false;
		}
	}
	
	states {
		Spawn:
			TNT1 A -1;
			Loop;
		Ready:
			SHTG A 1 A_WeaponReady();
			Loop;
		Select:
			SHTG A 1 A_Raise();
			Loop;
		Deselect:
			SHTG A 1 A_Lower();
			Loop;
		Fire:
			SHTG A 17 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("misc/oof");
			}
			SHTG A 1 A_WeaponReady();
			Goto Ready;
	}
}

//eof