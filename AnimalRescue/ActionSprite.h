//
//  ActionSprite.h
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class InGameLayer;

typedef enum _ActionState
{
    kActionStateNone = 0,
    kActionStateIdle,
    kActionStateAttack,
    kActionStateWalk,
    kActionStateHurt,
    kActionStateKnockedOut
} ActionState;

typedef enum _BulletActionType
{
    kbulletActionNone = 0,
    kbulletActionMachineGun = 1,
    kbulletActionShotGun = 2,
    kbulletActionShotGunSpread = 3,
    kbulletActionSideSpread =4,
    kbulletActionGrenade =5,
    kbulletActionBoomerangUltimate =6,
    kbulletActionBoomerang = 7,
    kbulletActionReflectingBullet
} BulletActionType;

typedef struct _BoundingBox
{
    CGRect actual;
    CGRect original;
} BoundingBox;

@interface ActionSprite : CCSprite

//inGameLayer
@property (nonatomic, strong) InGameLayer *layer;
-(id)initWithSpriteFrameName:(NSString *)spriteFrameName layer:(InGameLayer *)layer;

//states
@property (nonatomic, assign)ActionState actionState;

//bullet Action Type
@property (nonatomic, assign)BulletActionType bulletActionType;


//attribute
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float attackRate;
@property (nonatomic, assign) BOOL attackOnCoolDown;
@property (nonatomic, assign) float attackDamage;
@property (nonatomic, assign) BOOL alive;
//Melee or Ranged
@property (nonatomic, assign) BOOL isMelee;
@property (nonatomic, assign) BOOL isRanged;

//bullet or Actor
@property (nonatomic, assign) BOOL isBullet;
@property (nonatomic, assign) BOOL meleeDestroySelf;

//element ability representation
@property (nonatomic, assign) CCParticleSun *particleSun;
@property (nonatomic, assign) CCMotionStreak *bulletStreak;
@property (nonatomic, assign) CCParticleMeteor *particleMeteor;

//element ability effect representation and duration
@property (nonatomic, assign) BOOL actionOnFreeze;
@property (nonatomic, assign) BOOL actionOnFire;

//specify self class type
@property (nonatomic, assign) BOOL boomerangBullet;
@property (nonatomic, assign) BOOL isDefenseWall;
@property (nonatomic, assign) BOOL isTracingBullet;
@property (nonatomic, assign) CGPoint TracingTarget;
@property (nonatomic, assign) BOOL isMonster;
@property (nonatomic, assign) BOOL normalBullet;
@property (nonatomic, assign) CGPoint boomerangBulletInitPosition;
//main Character visual
@property (nonatomic, assign) CCSprite *glowSprite;

//Medium Monster Class Attribute
@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) CGPoint acceleration;
@property (nonatomic, assign) float maxVelocity;
@property (nonatomic, assign) float maxAcceleration;
@property (nonatomic, assign) BOOL stop;
//enabling element ability
@property (nonatomic, assign) BOOL fireAbilityEnable;
@property (nonatomic, assign) BOOL freezingAbilityEnable;
@property (nonatomic, assign) BOOL laserPenetrationAbility;
@property (nonatomic, assign) BOOL blackVoidAbilityEnable;
@property (nonatomic, assign) BOOL streakEffectEnable;
@property (nonatomic, assign) BOOL sideSpreadEnable;
@property (nonatomic, assign) int laserPenetrationCheck;

//death Particle flower
@property (nonatomic, assign) CCParticleFlower *particleFlower;

//mainHero
@property (nonatomic, assign) BOOL isMainHero;

//bullet Class
@property (nonatomic, assign) id bulletClass;

//collision boxes
@property (nonatomic,assign)BoundingBox hitBox;
@property (nonatomic,assign)BoundingBox attackBox;

//teams
@property (nonatomic, assign) BOOL isAlly;
@property (nonatomic, assign) int rowPosition;

//actions
@property(nonatomic, strong)id walkAction;
@property(nonatomic, strong)id attackAction;
@property(nonatomic, strong)id idleAction;
@property(nonatomic, strong)id hurtAction;
@property(nonatomic, strong)id knockedOutAction;
@property(nonatomic, strong)id releaseFreezingEffect;
@property(nonatomic, strong)id releaseFiringEffect;

//reflection bullets
@property (nonatomic, assign) float bulletAngle;
@property (nonatomic, assign) BOOL isReflectingBullet;
@property (nonatomic, assign) int reflectingCount;
@property (nonatomic, assign) BOOL forward, backward, up, down;

//action Method
-(void) walk;
-(void) attack;
-(void) idle;
-(void) hurt;
-(void) knockedOut;

//collision box factory method
-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size;

-(id)walkDelay:(float)delay velocity:(float)velocity vector:(CGPoint)vector;

@end
