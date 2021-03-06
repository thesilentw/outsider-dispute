/// spazershot.zsc
/// lever/pump shotgun
/// lever action primary, or hold secondary to pump and then UNLEASH HELL
///
Class ODSpazershot : ODWeapon replaces Shotgun {
	float randOffset;
	
	default {
		inventory.pickupMessage "Secured a SpazerShot!";
		weapon.slotNumber 3;
		weapon.SelectionOrder 1000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 15;
		Weapon.AmmoType "Shell";
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 1.0;
		Weapon.BobRangeY 0.5;
		+WEAPON.NODEATHINPUT;
	}	
	
	states {
		Spawn:
			SPAP A -1;
			Loop;
		Ready:
			SPAZ A 1 A_WeaponReady();
			Loop;
		Select:
			SPAZ A 1 A_Raise();
			Loop;
		Deselect:
			SPAZ A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 0 {
				if (CountInv("Shell") < 1) {
					return ResolveState("NoAmmo");
				}
				return ResolveState(Null);
			}
			SPAZ A 2 A_PlaySound("weapons/spazerprimary", CHAN_WEAPON);
			SPAF A 3 Bright {
				invoker.randOffset = Random(-4, 4);
				for (int i = 0; i <= 7; i++) {
					A_FireProjectile("SpazerBolt", angle: frandom(-1.0, 1.0), useammo: false, flags: 0, pitch: frandom(-0.7, 0.7));
				}
				A_WeaponOffset(invoker.randOffset, 10, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			SPAZ A 5 A_WeaponOffset((invoker.randOffset*-1), -10, WOF_ADD);
			SPAZ A 5 A_WeaponOffset(-20, 0, WOF_ADD);
			SPAZ C 3 {
				A_WeaponOffset(-40, 10, WOF_ADD);
				A_PlaySound("weapons/spazerleverfull", CHAN_AUTO);
			}
			SPAZ E 7 A_WeaponOffset(-6, 3, WOF_ADD);
			SPAZ C 7 A_WeaponOffset(6, -3, WOF_ADD);
			SPAZ A 7 A_WeaponOffset(60, -10, WOF_ADD);
			TNT1 A 0 A_Refire();
			Goto Ready;
		NoAmmo:
			SPAZ A 2 {
				A_PlaySound("misc/dry");
				A_WeaponOffset(2, 3, WOF_ADD);
			}
			SPAZ A 4 A_WeaponOffset(-2, -3, WOF_ADD);
			Goto Ready;
		AltFire:
			TNT1 A 0 {
				if (CountInv("Shell") < 1) {
					return ResolveState("NoAmmo");
				}
				return ResolveState(Null);
			}
			SPAZ C 7;
			SPAZ D 5 A_PlaySound("weapons/spazerpumpfwd", CHAN_AUTO);
			SPAZ C 15 A_PlaySound("weapons/spazerpumpbk", CHAN_AUTO);
			SPAZ A 2 A_PlaySound("weapons/spazersecondary", CHAN_WEAPON);
			SPAF A 3 Bright {
				invoker.randOffset = Random(-7, 7);
				for (int i = 0; i <= 7; i++) {
					A_FireProjectile("SpazerBolt", angle: frandom(-4.0, 4.0), useammo: false, flags: 0, pitch: frandom(-3.0, 3.0));
				}
				A_WeaponOffset(invoker.randOffset, 12, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			SPAZ A 1 A_Refire("AutoFire");
			Goto Ready;
		Autofire:
			TNT1 A 0 {
				if (CountInv("Shell") < 1) {
					return ResolveState("NoAmmo");
				}
				return ResolveState(Null);
			}
			SPAZ A 1 A_PlaySound("weapons/spazersecondary", CHAN_WEAPON);
			SPAZ A 1 A_WeaponOffset(invoker.randOffset*-1, -12, WOF_ADD);
			SPAF A 4 Bright {
				invoker.randOffset = Random(-7, 7);
				for (int i = 0; i <= 7; i++) {
					A_FireProjectile("SpazerBolt", angle: frandom(-3.0, 3.0), useammo: false, flags: 0, pitch: frandom(-3.0, 3.0));
				}
				A_WeaponOffset(invoker.randOffset, 12, WOF_ADD);
				A_TakeInventory("Shell", 1);
				return ResolveState(Null);
			}
			SPAZ A 4 A_Refire("AutoFire");
			Goto Ready;
	}
}


Class SpazerBolt : FastProjectile {
	int particleCount;
	
	Default {
		Radius 2;
		Height 4;
		Scale 1;
		Speed 777;
		DamageFunction (20);
		MissileType "BulletTrail";
		MissileHeight 8;
		Projectile;
		+RANDOMIZE
		+BLOODSPLATTER
		RenderStyle "Add";
		DeathSound "weapons/laserhit";
		Alpha 1;
		Decal "RailScorchLower";
		Translation "YellowLightning";
	}
	
	override void PostBeginPlay() {
		particleCount = 120;
		super.postbeginplay();
	}
	
	States {
		Spawn:
			PUFF A 1 Bright;
			Loop;
		Death:
			TNT1 A 0 {
				while (particlecount > 0) {
					A_SpawnParticle("Yellow",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 20,
						size: 2,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Orange",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 15,
						size: 2,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Yellow",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 4,
						size: 4,
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
/*
			A_SpawnParticle("Yellow",
			flags: SPF_FullBright|SPF_RelAng|SPF_RelVel,
			lifetime: 10,
			size: 5,
			angle: 0,
			xoff: 0,
			yoff: 0,
			zoff: 0,
			velx: frandom(-10,10),
			vely: frandom(-10,10),
			velz: frandom(-10,10),
			accelx: 0,
			accely: 0,
			accelz: -1);
	
		A_SpawnParticle(
			color color1,
			int flags,
			int lifetime,
			float size,
			float angle,
			float xoff,
			float yoff,
			float zoff,
			float velx,
			float vely,
			float velz,
			float accelx,
			float accely,
			float accelz,
			float startalphaf,
			float fadestepf,
			float sizestep
			);	
*/

//eof