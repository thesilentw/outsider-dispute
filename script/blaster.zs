/// blaster.zsc
/// pew pew pew
/// but don't pew too much or you'll be reduced to 
/// pew			pew			pew
///
Class ODBlaster : ODWeapon replaces Fist {
	float randOffset;
	
	default {
		inventory.pickupMessage "... How did you drop your blaster? That's what the lanyard is for!";
		weapon.slotNumber 1;
		weapon.SelectionOrder 1000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 19;
		Weapon.AmmoType "BCharge";
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 1.2;
		Weapon.BobRangeY 0.7;
		+WEAPON.NODEATHINPUT;
		+Weapon.Ammo_Optional;
	}	
	
	states {
		Spawn:
			TNT1 A -1;
			Loop;
		Ready:
			BLAS A 10 {
				A_WeaponReady();
				if (CountInv("BCharge") < 19) {
					A_GiveInventory("BCharge", 1);
				}
			}
			Loop;
		Select:
			BLAS A 1 A_Raise();
			Loop;
		Deselect:
			BLAS A 1 A_Lower();
			Loop;
		Fire:
			BLAF A 1 Bright {
				if (CountInv("BCharge") < 2) {
					return ResolveState("LowAmmo");
				}
				else {
					A_Light(1);
					invoker.randOffset = Random(-3, 3);
					A_FireProjectile("BBolt");
					A_PlaySound("weapons/blastershot");
					A_WeaponOffset(invoker.randOffset, 7, WOF_ADD);
					return ResolveState(Null);
				}
			}
			BLAF A 4 Bright;
			BLAS C 2 A_Light0();
			BLAS B 3;
			BLAS A 3 A_WeaponOffset((invoker.randOffset*-1), -7, WOF_ADD);
			TNT1 A 0 A_Refire();
			Goto Ready;
		LowAmmo:
			BLAF A 1 Bright {
				A_Light(1);
				invoker.randOffset = Random(-2, 2);
				A_FireProjectile("BBolt");
				A_TakeInventory("BCharge", 1);
				A_PlaySound("weapons/blastershot");
				A_WeaponOffset(invoker.randOffset, 3, WOF_ADD);
			}
			BLAF A 4 Bright;
			BLAS C 2 A_Light0();
			BLAS B 3;
			BLAS A 6 A_WeaponOffset((invoker.randOffset*-1), -3, WOF_ADD);
			BLAS A 4;
			TNT1 A 0 A_Refire();
			Goto Ready;
		AltFire:
			BLAF A 1 Bright {
				if (CountInv("BCharge") < 3) {
					return ResolveState("LowAmmo");
				}
				else {
					A_Light(1);
					invoker.randOffset = Random(-4, 4);
					A_FireProjectile("BBolt_Charged");
					A_PlaySound("weapons/blastershot");
					A_WeaponOffset(invoker.randOffset, 8, WOF_ADD);
					A_TakeInventory("BCharge", 1);
					return ResolveState(Null);
				}
			}
			BLAF A 2 Bright;
			BLAS C 2 {
				A_Light0();
				A_WeaponOffset((invoker.randOffset*-1), -7, WOF_ADD);
			}
			BLAF A 1 Bright {
				A_Light(1);
				invoker.randOffset = Random(-5, 5);
				A_FireProjectile("BBolt_Charged");
				A_PlaySound("weapons/blastershot");
				A_WeaponOffset(invoker.randOffset, 9, WOF_ADD);
				A_TakeInventory("BCharge", 1);
				return ResolveState(Null);
			}
			BLAF A 2 Bright;
			BLAS C 2 {
				A_Light0();
				A_WeaponOffset((invoker.randOffset*-1), -7, WOF_ADD);
			}
			BLAF A 1 Bright {
				A_Light(1);
				invoker.randOffset = Random(-6, 6);
				A_FireProjectile("BBolt_Charged");
				A_PlaySound("weapons/blastershot");
				A_WeaponOffset(invoker.randOffset, 10, WOF_ADD);
				A_TakeInventory("BCharge", 1);
				return ResolveState(Null);
			}
			BLAF A 2 Bright;
			BLAS C 2 A_Light0();
			BLAS B 3;
			BLAS A 6 A_WeaponOffset((invoker.randOffset*-1), -13, WOF_ADD);
			TNT1 A 0 A_Refire();
			Goto Ready;
	}
}

Class BCharge : Ammo {
	default {
		inventory.maxamount 19;
	}
}

Class BBolt : Actor {
	int particleCount;
	
	Default {
		Radius 2;
		Height 4;
		Scale 0.6;
		Speed 80;
		DamageFunction (7);
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
		particleCount = 60;
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
					particlecount--;
				}
				return ResolveState(Null);
			}
			PUFF ABC 1 A_FadeOut(0.2);
			Stop;
	}
}

Class BBolt_Charged : BBolt {
	
	default {
		BounceFactor 0.99;
		BounceCount 3;
		BounceType "Hexen";
	}
	
	override void PostBeginPlay() {
		particleCount = 30;
		super.postbeginplay();
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