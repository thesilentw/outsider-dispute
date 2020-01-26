/// ILS.zsc
/// it's the... individual.... laser.... shooter? I have NO IDEA.
///	primary fire is a 2-burst, secondary is 4-load, charge, burstfire.
///
Class ODILS : ODWeapon replaces SuperShotgun {
	float randOffset;
	float randOffsetAcc;

	default {
		inventory.pickupMessage "Ah! A rare and valuable... uh... whatever this is.";
		weapon.slotNumber 3;
		weapon.SelectionOrder 1000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 60;
		Weapon.AmmoType "Shell";
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 1.0;
		Weapon.BobRangeY 0.3;
		+WEAPON.NODEATHINPUT;
		Decal "BulletChip";
	}	
	
	states {
		Spawn:
			ILSP A -1;
			Loop;
		Ready:
			ILSR A 1 A_WeaponReady();
			Loop;
		Select: 
			ILSR A 1 A_Raise();
			Loop;
		Deselect:
			ILSR A 1 A_Lower();
			Loop;
		Fire:
			ILFC B 3 Bright {
				invoker.randOffsetAcc = 0;
				invoker.randOffset = Random(-6, 6);
				invoker.randOffsetAcc += invoker.randOffset;
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: frandom(-1.2, 1.2), useammo: false, flags: 0, pitch: frandom(-1., 1.));
				}
				A_WeaponOffset(invoker.randOffset, 10, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR A 1;
			ILFC A 3 Bright {
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				invoker.randOffset = Random(-6, 6);
				invoker.randOffsetAcc += invoker.randOffset;
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: frandom(-1.2, 1.2), useammo: false, flags: 0, pitch: frandom(-1., 1.));
				}
				A_WeaponOffset(invoker.randOffset, 10, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR A 10 A_WeaponOffset((invoker.randOffsetAcc*-1), -20, WOF_ADD);
			ILSR B 2 A_PlaySound("weapons/ilsopen2", CHAN_6);
			ILSR C 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR DE 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR D 2 A_PlaySound("weapons/ilsclose", CHAN_7);
			ILSR E 2;
			ILSR CBA 1;
			ILSR A 15;
			Goto Ready;
		AltFire:
			ILSR A 2 {
				A_PlaySound("weapons/ilsopen2", CHAN_6);
				invoker.randOffsetAcc = 0;
			}
			ILSR B 2;
			ILSR C 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR DE 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR DE 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR DE 2;
			ILSR D 2 A_PlaySound("weapons/ilsload2", CHAN_AUTO);
			ILSR DE 2;
			ILSR FGHIJK 2;
			ILFO B 2 Bright {
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				invoker.randOffset = Random(-12, 12);
				invoker.randOffsetAcc += invoker.randOffset;
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: -frandom(0, 2), useammo: false, flags: 0, pitch: frandom(-0.2, 0.2));
				}
				A_WeaponOffset(invoker.randOffset, 8, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR D 1;
			ILFO A 2 Bright {
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				invoker.randOffset = Random(-12, 12);
				invoker.randOffsetAcc += invoker.randOffset;
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: frandom(0, 2), useammo: false, flags: 0, pitch: frandom(-0.2, 0.2));
				}
				A_WeaponOffset(invoker.randOffset, 6, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR D 1;
			ILFO B 2 Bright {
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				invoker.randOffset = Random(-12, 12);
				invoker.randOffsetAcc += invoker.randOffset;
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: frandom(-2, 1), useammo: false, flags: 0, pitch: frandom(-0.2, 0.2));
				}
				A_WeaponOffset(invoker.randOffset, 4, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR D 1;
			ILFO A 2 Bright {
				A_PlaySound("weapons/ilsprimary", CHAN_WEAPON);
				invoker.randOffset = Random(-12, 12);
				invoker.randOffsetAcc += invoker.randOffset;
				for (int i = 0; i <= 5; i++) {
					A_FireProjectile("ILSPellet", angle: frandom(-1, 2), useammo: false, flags: 0, pitch: frandom(-0.2, 0.2));
				}
				A_WeaponOffset(invoker.randOffset, 2, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			ILSR D 28 A_WeaponOffset((invoker.randOffsetAcc*-1), -20, WOF_ADD);
			ILSR D 2 A_PlaySound("weapons/ilsclose", CHAN_7);
			ILSR CBA 2;
			ILSR A 5;
			Goto Ready;
	}
}

Class ILSPellet : Actor {
	int particleCount;
	
	Default {
		Radius 2;
		Height 4;
		Scale 1;
		Speed 120;
		DamageFunction (20);
		MissileType "BulletTrail";
		MissileHeight 8;
		Projectile;
		+RANDOMIZE
		+BLOODSPLATTER
		RenderStyle "Add";
		//BounceType "Doom";
		//BounceFactor 0.1;
		//WallBounceFactor 0.25;
		///BounceCount 2;
		Alpha 1;
		Decal "BulletChip";
	}
	
	override void PostBeginPlay() {
		particleCount = 30;
		super.postbeginplay();
	}
	
	States {
		Spawn:
			PUFF A 1 Bright;
			Loop;
		Bounce:
			PUFF A 1 Bright;
			Loop;
		Death:
			TNT1 A 0 {
				while (particlecount > 0) {
					A_SpawnParticle("White",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 20,
						size: 1,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Yellow",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 15,
						size: 2,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Orange",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 7,
						size: 3,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					particlecount--;
				}
				return ResolveState(Null);
			}
			PUFF ABC 1 A_FadeOut(0.2);
			Stop;
	}
}

//eof