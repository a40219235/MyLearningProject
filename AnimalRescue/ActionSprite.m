//
//  ActionSprite.m
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ActionSprite.h"
#import "InGameLayer.h"
#import "ccDeprecated.h"
#import "ElementAbility.h"
#import "FireElement.h"
#import "FreezingElement.h"
#import "StreakAbility.h"
#import "MachineGunAction.h"
#import "ShotGunAction.h"
#import "ShotGunSpreadAction.h"
#import "SideSpreadAction.h"
#import "GrenadeAction.h"
#import "BoomerangUltimateAction.h"
#import "BoomerangAction.h"
#import "ReflectingBulletAction.h"


@implementation ActionSprite
{
    ActionSprite *actionSprite;
    BOOL _aoeDamageCused;
    BOOL _hasTarget;
    CGRect _winSize;
    int _machineBullets;
    
    ElementAbility *_elementAbility;
    BulletActionManager *_bulletActionManager;
}

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName layer:(InGameLayer *)layer
{
    if ((self = [super initWithSpriteFrameName:spriteFrameName]))
    {
        self.layer = layer;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _winSize = CGRectMake(0, 0, winSize.width, winSize.height);
        [self scheduleUpdateWithPriority:1];
    }
    return self;
}

-(void)walk
{
    if (_actionState == kActionStateWalk) return;
    [self stopAction:self.walkAction];
    [self stopAction:self.attackAction];
    [self stopAction:self.idleAction];
    [self stopAction:self.hurtAction];
    [self runAction:_walkAction];
    _actionState = kActionStateWalk;
}

-(void)attack
{
    if (_actionState == kActionStateAttack) return;
    [self stopAction:self.walkAction];
    [self stopAction:self.attackAction];
    [self stopAction:self.idleAction];
    [self stopAction:self.hurtAction];
    [self runAction:_attackAction];
    _actionState = kActionStateAttack;
}

-(void)idle
{
    if (_actionState == kActionStateIdle) return;
    [self stopAction:self.walkAction];
    [self stopAction:self.attackAction];
    [self stopAction:self.idleAction];
    [self stopAction:self.hurtAction];
    [self runAction:_idleAction];
    _actionState = kActionStateIdle;
}

-(void)hurt
{
    if (_actionState == kActionStateHurt) return;
    [self stopAction:self.walkAction];
    [self stopAction:self.attackAction];
    [self stopAction:self.idleAction];
    [self stopAction:self.hurtAction];
    [self runAction:_hurtAction];
    if (!self.isDefenseWall)  _actionState = kActionStateHurt;
}

-(void)knockedOut
{
    if (_actionState == kActionStateKnockedOut) return;
    self.alive = false;
    [self stopAllActions];
    //check gameOver
    if (self.isMainHero) [self.layer endGameLose];
    
    self.particleFlower = [CCParticleFlower node];
    [self.layer addChild:self.particleFlower];
    self.particleFlower.positionType = kCCPositionTypeGrouped;
    self.particleFlower.endSize = kCCParticleStartSizeEqualToEndSize;
    self.particleFlower.life = 1.0f;
    self.particleFlower.totalParticles = 10;
    self.particleFlower.speed = 100;
    self.particleFlower.speedVar= 0.0;
    self.particleFlower.position = self.position;
    self.particleFlower.startSpin = YES;
    
    [self runAction:[CCSequence actionOne:_knockedOutAction two:[CCCallBlock actionWithBlock:^{[self.layer removeGameObject:self Team:self.isAlly];}]]];
}

-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size
{
    BoundingBox boundingBox;
    boundingBox.original.origin = origin;
    boundingBox.original.size = size;
    boundingBox.actual.origin = ccpAdd(position_, ccp(boundingBox.original.origin.x, boundingBox.original.origin.y));
    boundingBox.actual.size = size;
    return boundingBox;
}

-(void)transformBoxes
{
    _hitBox.actual.origin = ccpAdd(position_, ccp(_hitBox.original.origin.x * scaleX_, _hitBox.original.origin.y * scaleY_));
    _hitBox.actual.size = CGSizeMake(_hitBox.original.size.width * scaleX_, _hitBox.original.size.height * scaleY_);
    _attackBox.actual.origin = ccpAdd(position_, ccp(_attackBox.original.origin.x * scaleX_, _attackBox.original.origin.y * scaleY_));
    _attackBox.actual.size = CGSizeMake(_attackBox.original.size.width * scaleX_, _attackBox.original.size.height * scaleY_);
}

-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    [self transformBoxes];
}

-(void)releaseFreezingEffect:(ActionSprite*)sprite
{
    //cancel fire and freezing effect 
    if (sprite.actionOnFire)
    {
        sprite.color = ccWHITE;
        [sprite.actionManager resumeTarget:sprite];
        sprite.actionOnFreeze = NO;
        sprite.actionOnFire = NO;
        return;
    }
    
    if (!sprite.releaseFreezingEffect)
    {
        CCDelayTime *effectDuration = [CCDelayTime actionWithDuration:3];
        CCCallBlock *releaseEffect = [CCCallBlock actionWithBlock:^{
            sprite.color = ccWHITE;
            [sprite.actionManager resumeTarget:sprite];
            sprite.actionOnFreeze = NO;
        }];
        sprite.releaseFreezingEffect = [CCSequence actions:effectDuration, releaseEffect, nil];
    }
    
    [self.layer stopAction:sprite.releaseFreezingEffect];
    [self.layer runAction:sprite.releaseFreezingEffect];
}

-(void)releaseFiringEffect:(ActionSprite *)sprite
{
    //cancel fire and freezing effect 
    if (sprite.actionOnFreeze)
    {
        sprite.color = ccWHITE;
        [sprite.actionManager resumeTarget:sprite];
        sprite.actionOnFreeze = NO;
        sprite.actionOnFire = NO;
        return;
    }
    
    if (!sprite.releaseFiringEffect)
    {
        CCDelayTime *effectDuration = [CCDelayTime actionWithDuration:3];
        CCCallBlock *releaseEffect = [CCCallBlock actionWithBlock:^{
            sprite.color = ccWHITE;
            sprite.actionOnFire = NO;
        }];
        sprite.releaseFiringEffect = [CCSequence actions:effectDuration, releaseEffect, nil];
    }
    
    [self.layer stopAction:sprite.releaseFiringEffect];
    [self.layer runAction:sprite.releaseFiringEffect];
}

-(void)checkCollision:(ActionSprite *)enemy
{
    if (CGRectIntersectsRect(self.attackBox.actual, enemy.hitBox.actual))
    {
        _hasTarget = YES;
        if (self.isBullet)
        {
            if (self.attackOnCoolDown) return;
            if (self.freezingAbilityEnable)
            {
                enemy.color = ccBLUE;
                [enemy.actionManager pauseTarget:enemy];
                enemy.actionOnFreeze = YES;
                [self releaseFreezingEffect:enemy];
            }
            
            if (self.fireAbilityEnable)
            {
                enemy.color = ccRED;
                enemy.health -= 5;
                enemy.actionOnFire = YES;
                [self releaseFiringEffect:enemy];
            }

            if (self.bulletActionType == kbulletActionBoomerang)
            {
                [self attackGoesIntoCoolDownState:self];
                CCJumpTo *jumpBack = [CCJumpTo actionWithDuration:2 position:self.boomerangBulletInitPosition height:80 jumps:1];
                CCRotateBy *rotateBack = [CCRotateBy actionWithDuration:2 angle:-2600];
                CCSpawn *spwanBack = [CCSpawn actions:jumpBack, rotateBack, nil];
                self.isMelee = NO;
                [self stopAllActions];
                [self runAction:[CCSequence actions:spwanBack, [CCCallBlock actionWithBlock:^{[self.layer removeGameObject:self Team:self.isAlly];}], nil]];
            }
            
            if (!self.laserPenetrationAbility)
            {
                [self attackGoesIntoCoolDownState:self];
                if (!enemy.actionOnFreeze) [enemy hurt];
                enemy.health -= self.attackDamage;
                if (self.isMelee) [self.layer removeGameObject:self Team:self.isAlly];
            }
            
            if (self.laserPenetrationAbility)
            {
                if (self.laserPenetrationCheck > enemy.laserPenetrationCheck)
                {
                    if (!enemy.actionOnFreeze)[enemy hurt];
                    enemy.health -= self.attackDamage;
                    enemy.laserPenetrationCheck = self.laserPenetrationCheck;
                }
            }
            
            if (enemy.health <=0) [enemy knockedOut];
            return;
        }
        
        if (self.actionState == kActionStateWalk) [self idle];
        if (self.attackOnCoolDown) return;
        {
            if (self.blackVoidAbilityEnable)
            {
                _aoeDamageCused = YES;
            }
            else [self attackGoesIntoCoolDownState:self];
            
            if (self.actionState != kActionStateAttack && self.actionState != kActionStateHurt && !self.isDefenseWall)
            {
                [self attack];
            }
            if (enemy.actionState != kActionStateKnockedOut && self.actionState == kActionStateAttack)
            {
                [enemy hurt];
                enemy.health -= self.attackDamage;
            }
            if (enemy.health <=0) [enemy knockedOut];
        }
    }
}

-(void)updateMelee:(ccTime)dt
{
    if (!self.isMelee) return;
    if (self.actionOnFreeze) return;
    CCArray *enemies = [self.layer enemiesOfTeam:self.isAlly];
    _aoeDamageCused = false;
    _hasTarget = NO;
    if(self.laserPenetrationAbility && self.laserPenetrationCheck == 0)
    {
         self.layer.laserAttribute ++;
         self.laserPenetrationCheck = self.layer.laserAttribute;
    }
    CCARRAY_FOREACH(enemies, actionSprite)
    {
        if (!actionSprite.alive) continue;
        else if (!CGRectContainsRect(_winSize, actionSprite.attackBox.actual)) continue;
        if (actionSprite.isBullet) continue;
//        if (self.freezingAbilityEnable && actionSprite.actionOnFreeze) continue;
        [self checkCollision:actionSprite];
    }
    
    if (_hasTarget == NO && self.actionState != kActionStateHurt && self.actionState != kActionStateWalk && !self.isBullet &&!self.isDefenseWall) [self walk];
    if (enemies.count == 0 && self.actionState != kActionStateHurt && self.actionState != kActionStateWalk && self.isBullet == NO && !self.isDefenseWall) [self walk];
    if (_aoeDamageCused) [self attackGoesIntoCoolDownState:self];
}

-(void)updateRanged:(ccTime)dt
{
    if (!self.isRanged) return;
    if (self.isMonster) [self spawnMediumMonster];
    [self runBullet];
}

-(void)runBullet
{
    if (self.attackOnCoolDown) return;
    CCArray *enemies = [self.layer enemiesOfTeam:self.isAlly];
    _aoeDamageCused = false;
    _hasTarget = NO;
    CGPoint direction = CGPointZero;

    CCARRAY_FOREACH(enemies, actionSprite)
    {
        if (!actionSprite.alive) continue;

        if (self.isMainHero)
        {
            if (actionSprite.rowPosition != self.rowPosition -1 && actionSprite.rowPosition != self.rowPosition && actionSprite.rowPosition != self.rowPosition +1)
            {                    
                continue;
            }
        }

        if (actionSprite.position.x < _winSize.size.width +25)
        {
            _hasTarget = YES;
            direction = ccpNormalize(ccpSub(actionSprite.position, self.position));
            break;
        }
    }
    if (_hasTarget)
    {
        [self attackGoesIntoCoolDownState:self];
        [self idle];
        [self attack];
        
        switch (self.bulletActionType)
        {
            case kbulletActionMachineGun:
                if (self.isTracingBullet) direction = ccp(-1, 0);
                _bulletActionManager= [[MachineGunAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:self.layer.shotGunSpreadBulletsNum];
                break;
            case kbulletActionShotGun:
                _bulletActionManager = [[ShotGunAction alloc]init];
                [_bulletActionManager execute:self direction:direction bulletNum:1];
                break;
            case kbulletActionShotGunSpread:
                _bulletActionManager = [[ShotGunSpreadAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:self.layer.shotGunSpreadBulletsNum];
                break;
            case kbulletActionSideSpread:
                _bulletActionManager = [[SideSpreadAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:5];
                break;
            case kbulletActionGrenade:
                _bulletActionManager = [[GrenadeAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:1];
                break;
            case kbulletActionBoomerangUltimate:
                _bulletActionManager = [[BoomerangUltimateAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:0];
                break;
            case kbulletActionBoomerang:
                _bulletActionManager = [[BoomerangAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:0];
                break;
            case kbulletActionReflectingBullet:
                _bulletActionManager = [[ReflectingBulletAction alloc] init];
                [_bulletActionManager execute:self direction:direction bulletNum:0];
                break;
                
            default: return;
                break;
        }
    }
}

-(void)attackGoesIntoCoolDownState:(ActionSprite *)sprite
{
    sprite.attackOnCoolDown = YES;
    CCDelayTime *attackInterval = [CCDelayTime actionWithDuration:sprite.attackRate];
    CCCallBlock *finishCoolDown = [CCCallBlock actionWithBlock:^{
        sprite.attackOnCoolDown = NO;
    }];
    CCSequence *reactiveAttack = [CCSequence actions:attackInterval, finishCoolDown, nil];
    [sprite runAction:reactiveAttack];
}

-(void)spawnMediumMonster
{
    if (self.attackOnCoolDown) return;
    
    [self attackGoesIntoCoolDownState:self];
    [self idle];
    [self attack];
    if (self.actionState == kActionStateAttack)
    {
        for (int i =0; i < 6; i++)
        {
            ActionSprite * bullet = [self.layer createBulletClass:[MidiumMonster class] ForTeam:self.isAlly withActor:NO actionSprite:self];
            float randomX, randomY;
            randomX = CCRANDOM_0_1() * 1;
            randomY = CCRANDOM_0_1() * 1;
            bullet.position =ccp(self.position.x + randomX, self.position.y + randomY);
            bullet.attackDamage = self.attackDamage;
            bullet.rowPosition = self.rowPosition;
            bullet.laserPenetrationAbility = self.laserPenetrationAbility;
            bullet.TracingTarget = self.position;
        }
    }
    
    return;
}

-(void)update:(ccTime)dt
{
    if (self.isReflectingBullet) {
        _bulletActionManager = [[ReflectingBulletAction alloc] init];
        [_bulletActionManager updateBouncing:self];
    }
    if (!self.alive) return;
    [self updateMelee:dt];
    [self updateRanged:dt];
    [self stopAndAttack];
    
    //create sun Particles
    if (self.fireAbilityEnable && !self.particleSun && self.isBullet) {
        _elementAbility = [[FireElement alloc] init];
        [_elementAbility execute:self];
    }
    
    if (self.freezingAbilityEnable && !self.particleMeteor &&self.isBullet) {
        _elementAbility = [[FreezingElement alloc] init];
        [_elementAbility execute:self];
    }
    
    //sun particle follow the bullet
    if (self.particleSun)
        self.particleSun.position = self.position;
    if (self.particleMeteor) {
        self.particleMeteor.position = self.position;
    }
    
    //create streak
    if (self.streakEffectEnable && !self.bulletStreak && self.isBullet)
    {
        _elementAbility = [[StreakAbility alloc] init];
        [_elementAbility execute:self];
    }
    
    //streak follow bullet
    if (self.bulletStreak) self.bulletStreak.position = self.position;
    
    if (self.isTracingBullet)
    {
        [self updateMove:dt position:self.TracingTarget];
    }
    
    //removeSprite if outof the screen x
    if (!self.isBullet && self.position.x < -30 ) {
        [self.layer removeGameObject:self Team:self.isAlly];
        CCLOG(@"%@ removed", [[self class] description]);
    }
}

-(void)stopAndAttack
{
    if (self.isMonster && self.position.x < 400 && !self.stop)
    {
        [self stopAllActions];
        self.walkAction = self.idleAction;
        [self walk];
        self.attackDamage = 0;
        self.isRanged = YES;
        self.isMelee = NO;
        self.stop = YES;
    }
}

-(CGPoint)arriveWithTarget:(CGPoint)target
{
    CGPoint vector = ccpSub(target, self.position);
    float distance = ccpLength(vector);
    
    float targetRadius = 0;
    float slowRadius = 10;
    static float timeToTarget = 0.1;
    
    if (distance < targetRadius)
    {
        self.velocity = CGPointZero;
        self.acceleration = CGPointZero;
        return CGPointZero;
    }
    
    float targetSpeed;
    if (distance > slowRadius) {
        targetSpeed = self.maxVelocity;
    }else targetSpeed = self.maxVelocity * distance/slowRadius;
    
    CGPoint targetVelocity = ccpMult(ccpNormalize(vector), targetSpeed);
    
    CGPoint acceleration = ccpMult(ccpSub(targetVelocity, self.velocity), 1/timeToTarget);
    if (ccpLength(acceleration) > self.maxAcceleration)
    {
        acceleration = ccpMult(ccpNormalize(acceleration), self.maxAcceleration);
    }
    return acceleration;
}

-(CGPoint)seperate
{
    CGPoint steering = CGPointZero;
    CCArray *allies = [self.layer alliesOfTeam:self.isAlly];
    CCARRAY_FOREACH(allies, actionSprite)
    {
        if (actionSprite == self) continue;
        CGPoint direction = ccpSub(self.position, actionSprite.position);
        float distance = ccpLength(direction);
        static float SEPERATE_THRESHHOLD = 15;
        if (distance < SEPERATE_THRESHHOLD) {
            if (direction.x != 0 && direction.y != 0) direction = ccpNormalize(direction);
            steering = ccpAdd(steering, ccpMult(direction, self.maxAcceleration));
        }

    }
    return  steering;
}

-(void)updateMove:(ccTime)dt position:(CGPoint)position
{
    if (self.maxAcceleration <= 0 || self.maxVelocity <= 0) return;

    CGPoint moveTarget = position;
    
    CGPoint arriveComponent = [self arriveWithTarget:moveTarget];
    CGPoint separateComponent = [self seperate];
    CGPoint newAcceleration = ccpAdd(arriveComponent, separateComponent);
    
    self.acceleration = ccpAdd(self.acceleration, newAcceleration);
    if (ccpLength(self.acceleration) > self.maxAcceleration) {
        self.acceleration = ccpMult(ccpNormalize(self.acceleration), self.maxAcceleration);
    }
    
    self.velocity = ccpAdd(self.velocity, ccpMult(self.acceleration, dt));
    if (ccpLength(self.velocity) > self.maxVelocity)
    {
        self.velocity = ccpMult(ccpNormalize(self.velocity), self.maxVelocity);
    }
    
    CGPoint newPosition = ccpAdd(self.position, ccpMult(self.velocity, dt));
    self.position = newPosition;
}

-(id)walkDelay:(float)delay velocity:(float)velocity vector:(CGPoint)vector
{
    CCLOG(@"this func is call on ActionSprite Class");
    return 0;
}
@end