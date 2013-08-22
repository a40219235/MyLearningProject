//
//  InGameLayer.h
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"
#import "ZapBullet.h"
#import "QuirkBullet.h"
#import "MunchBullet.h"
#import "LaserBullet.h"
#import "DefenseWall.h"
#import "MidiumMonster.h"
#import "MonsterEnemy.h"
#import "HeroBabe.h"

@interface InGameLayer : CCLayer

-(BOOL)oppositeTeam:(BOOL)team;
-(ActionSprite *)playerForTeam:(BOOL)team;
-(CCArray *)alliesOfTeam:(BOOL)team;
-(CCArray *)enemiesOfTeam:(BOOL)team;
-(void)removeGameObject:(ActionSprite *)gameObject Team:(BOOL)team;
-(ZapBullet *)createBulletClass:(id)class ForTeam:(BOOL)isAlly withActor:(BOOL)actors actionSprite:(ActionSprite *)actionSprite;
-(void)spwanwithclass:(id)class isAlly:(BOOL)isAlly columnPosition:(int)columnPosition rowPosition:(int)rowPosition additionX:(float)additionX walkActionDelay:(float)delay velocity:(float)velecity;
-(void)removeTemporaryObject:(ActionSprite*)actionSprite;

-(void)endGameLose;
-(void)endGameWin;

//arrays
@property (nonatomic, strong)CCArray *heroArray;
@property (nonatomic, strong)CCArray *enemyArray;

@property (nonatomic, assign) CGPoint direction1, direction2, direction3, direction4, direction5, direction6, direction7;

//game Bullet
@property (nonatomic, assign) int shotGunSpreadBulletsNum;

//use for laser penetrating aoe damage
@property (nonatomic, assign) int laserAttribute;

@property (nonatomic, assign) CGSize winSize;

//used to Set the Position
@property (nonatomic, strong) CCTMXTiledMap *tileMap;
@property (nonatomic, strong) CCTMXLayer* layer1;

@property (nonatomic, strong) CCSpriteBatchNode *actors, *batchNode, *airplaneBatchNode;

@property (nonatomic, assign) int button1Skill, button2Skill, button3Skill, button4Skill, button5Skill, button7Skill, button8Skill, button9Skill, button10Skill, button11Skill;

+(InGameLayer *)sharedIngameLayer;

@end
