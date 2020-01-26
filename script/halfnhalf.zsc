/// halfnhalf.zsc
/// dual-flavour rocket launcher
///
Class ODHalfnhalf : ODWeapon replaces RocketLauncher {
	float randOffset;

	default {
		inventory.pickupMessage "Now THIS is some serious artillery!";
		weapon.slotNumber 5;
		weapon.SelectionOrder 9000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "RocketAmmo";
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 1.0;
		Weapon.BobRangeY 0.2;
		+WEAPON.NODEATHINPUT;
	}	
	
	states {
		Spawn:
			HNHP A -1;
			Loop;
		Ready:
			HNHI A 1 A_WeaponReady(WRF_ALL);
			Loop;		
		Select:
			HNHI A 1 A_Raise();
			Loop;
		Deselect:
			HNHI A 1 A_Lower();
			Loop;
		Fire:
			HNHS ABCCCC 2;
			HNHL A 2 Bright A_FireProjectile("HNHMissile", angle: frandom(-0.2, 0.2), useammo: true, flags: 0, pitch: frandom(-0.2, 0.2));
			HNHL B 3 Bright;
			HNHL C 2 Bright;
			HNHL D 4;
			HNHL E 2;
			HNHS C 10;
			HNHS CBA 2 A_Refire();
			Goto Ready;
		Hold:
			HNHL A 2 Bright A_FireProjectile("HNHMissile", angle: frandom(-0.2, 0.2), useammo: true, flags: 0, pitch: frandom(-0.2, 0.2));
			HNHL B 3 Bright;
			HNHL C 2 Bright;
			HNHL D 4;
			HNHL E 2;
			HNHS C 10;	
			HNHS CBA 2 A_Refire();
			Goto Ready;
		AltFire:
			HNHS ADEEEE 2;
			HNHR A 2 Bright A_FireProjectile("HNHMissile", angle: frandom(-0.2, 0.2), useammo: true, flags: 0, pitch: frandom(-0.2, 0.2));
			HNHR B 3 Bright;
			HNHR C 2 Bright;
			HNHR D 4;
			HNHR E 2;
			HNHS E 10;
			HNHS EDA 2 A_Refire();
			Goto Ready;
		AltHold:
			HNHR A 2 Bright A_FireProjectile("HNHMissile", angle: frandom(-0.2, 0.2), useammo: true, flags: 0, pitch: frandom(-0.2, 0.2));
			HNHR B 3 Bright;
			HNHR C 2 Bright;
			HNHR D 4;
			HNHR E 2;
			HNHS E 10;
			HNHS EDA 2 A_Refire();
			Goto Ready;
	}
}

Class HNHMissile : FastProjectile {
	int particleCount;
	
	Default {
		Speed 50;
		height 8;
		radius 8;
		//Scale 0.8;
		//alpha 0.95;
		-RANDOMIZE;
		DamageFunction (20);
		MissileHeight 8;
		RenderStyle "Add";
		Decal "DoomImpScorch";
		//Translation "CharcoalGrey";
	}
	
	override void PostBeginPlay() {
		particleCount = 400;
		super.postbeginplay();
	}
	
	States {
		Spawn:
			MISL A 1 Bright;
			Loop;
		Death:
			TNT1 A 0 {
				while (particlecount > 0) {
					A_SpawnParticle("White",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 20,
						size: 2,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Red",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 15,
						size: 3,
						velx: FRandom(-20,20),
						vely: FRandom(-20,20),
						velz: FRandom(-20,20),
						accelz: -1);
					A_SpawnParticle("Grey",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 30,
						size: 6,
						velx: FRandom(-30,30),
						vely: FRandom(-30,30),
						velz: FRandom(-30,30),
						accelz: -1);
					A_SpawnParticle("Yellow",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 10,
						size: 2,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					particlecount--;
				}
				return ResolveState(Null);
			}
			MISL BCD 2 Bright A_Fadeout(0.2);
			Stop;
	}
}


//eof