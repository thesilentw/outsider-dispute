/// magnum.zsc
/// ka-click BOOM
///
Class ODMagnum : ODWeapon replaces Pistol {
	float randOffset;
	bool scoped;

	default {
		inventory.pickupMessage "Oooh. Oh ho. Oh, yes. Yes. Yes!";
		weapon.slotNumber 2;
		weapon.SelectionOrder 9000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "Clip"; //temporary - I think this will need a new ammotype
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 0.3;
		Weapon.BobRangeY 0.3;
		+WEAPON.NODEATHINPUT;
		Decal "BulletChip";
	}	
	
	states {
		Spawn:
			TNT1 A -1;
			Loop;
		Ready:
			TNT1 A 15 {
				if (invoker.scoped) {
					return ResolveState("ScopedReady");
				}
				else {
					return ResolveState("StdReady");
				}
			}
		StdReady:
			MAGN A 1 A_WeaponReady(WRF_ALL);
			Loop;
		ScopedReady:
			ZOOM A 1 A_WeaponReady(WRF_ALL);
			Loop;		
		Select:
			MAGN A 1 A_Raise();
			Loop;
		Deselect:
			MAGN A 1 { 
				if (invoker.scoped) {
					invoker.scoped = false;
					A_ZoomFactor(1.0);
					A_PlaySound("weapons/magnumzoomout");
				}
				return ResolveState(Null);
			}
			Goto PostDeselect;
		PostDeselect:
			MAGN A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 0 {
				if (invoker.scoped) {
					return ResolveState("ScopedFire");
				}
				else {
					return ResolveState("StdFire");
				}
			}
		StdFire:
			MAGF A 3 {
				A_FireProjectile("MagnumShot", angle: frandom(-0.7, 0.7), useammo: true, flags: 0, pitch: frandom(-0.7, 0.7));
				A_PlaySound("weapons/magnumprimaryv2");
			}
			MAGN C 3;
			MAGN B 5;
			MAGN A 8;
			Goto Ready;
		ScopedFire:
			ZOOM A 25 {
				A_FireProjectile("MagnumShot", angle: 0, useammo: true, flags: FPF_NOAUTOAIM, pitch: 0);
				A_PlaySound("weapons/magnumprimaryv2");
			}
			Goto Ready;
		AltFire:
			TNT1 A 0 A_WeaponReady(WRF_NONE);
			TNT1 A 0 {
				if (invoker.scoped) {
					A_ZoomFactor(1.0);
					invoker.scoped = false;
					return ResolveState("ScopeDown");
				}
				else {
					A_ZoomFactor(2.0);
					invoker.scoped = true;
					return ResolveState("ScopeUp");
				}
			}
			Goto Ready;
		ScopeUp:
			ZOOM A 15 {
				A_PlaySound("weapons/magnumzoomin");
				A_ZoomFactor(2.0);
				invoker.scoped = true;
			}
			Goto Ready;
		ScopeDown:
			TNT1 A 0 {
				A_PlaySound("weapons/magnumzoomout");
				invoker.scoped = false;
				A_ZoomFactor(1.0);
			}
			MAGN A 5;
			Goto Ready;
		
	}
}

Class MagnumShot : FastProjectile {
	int particleCount;
	
	Default {
		Radius 2;
		Height 4;
		Scale 0.2;
		Speed 2000;
		DamageFunction (100);
		MissileType "BulletTrail";
		MissileHeight 8;
		Projectile;
		+RANDOMIZE
		+BLOODSPLATTER
		RenderStyle "Add";
		//DeathSound "weapons/laserhit";
		Alpha 1;
		Decal "BulletChip";
		//Translation "YellowLightning";
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
					A_SpawnParticle("White",
						flags: SPF_RELATIVE|SPF_FULLBRIGHT,
						lifetime: 20,
						size: 2,
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
						lifetime: 4,
						size: 4,
						velx: FRandom(-10,10),
						vely: FRandom(-10,10),
						velz: FRandom(-10,10),
						accelz: -1);
					A_SpawnParticle("Grey",
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