//
//  InGameLayer.m
//  AnimalRescue
//
//  Created by iMac on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "InGameLayer.h"
#import "Hero.h"
#import "Robot.h"
#import "ActionSprite.h"
#import "SceneManager.h"
#import "AppDelegate.h"

#import "MocManager.h"
#import "GameObjectInfo.h"
#import "GameObjectDetails.h"

#import "GameLevelManager.h"
#import "SkillManager.h"
//use for updating position
#import "TwoCloneShooter.h"
#import "TwoCloneShooter2.h"
#import "DefenseWallSkill.h"
#import "SideSpreadingSkill.h"
#import "SideSpreadingSkill2.h"
#import "Boomerang.h"
#import "Boomerang2.h"

#import "MainHeroInitManager.h"
#import "InitMenuManager.h"

@implementation InGameLayer
{
    Hero *_hero;
    Robot *_robot;
    ActionSprite *hero1, *hero2, *hero3, *hero4, *hero5, *hero6, *_wall1, *_wall2;
    
    CGPoint _allyVector;
    CGPoint _enemyVector;
    
    ActionSprite *_actionSprite;
    
    BOOL onPause;
    BOOL _gameFinished;
    int _gameLevel;
    
    CCSprite *_lighteningBolt;
    CCSprite *_lighteningGlow;
    int _lighteningTime;
    
    //Progress Timer
    CCProgressTimer *_timer1, *_timer2, *_timer3, *_timer4, *_timer5, *_timer6 ,*_timer7 ,*_timer8, *_timer9, *_timer10, *_timer11, *_timer12;
    CCMenuItemSprite *_playerButton, *_playerButton2, *_playerButton3, *_playerButton4, *_playerButton5, *_playerButton6, *_playerButton7, *_playerButton8, *_playerButton9, *_playerButton10, *_playerButton11, *_playerButton12;
    
    //CoreData
    MocManager *_mocManager;
    
    //gameLevel
    GameLevelManager *_gameLevelManager;
    SkillManager *_skillManager;
    MainHeroInitManager *_mainHeroInitManager;
    InitMenuManager *_initMenuManager;
    
    int _swappingMove1, _swappingMove2;
}

-(void)onBack:(id)sender
{
    if (!onPause) [[CCDirector sharedDirector] resume];
    [SceneManager goMainMenu];
}

-(void)onPause:(id)sender
{
    if (onPause)
    {
        onPause = !onPause;
        [[CCDirector sharedDirector] pause];
    }
    else
    {
        onPause =!onPause;
        [[CCDirector sharedDirector] resume];
    }
}

static InGameLayer * sharedIngameLayer;
+(InGameLayer *)sharedIngameLayer
{
    return sharedIngameLayer;
}



-(id)init
{
    if ((self = [super init]))
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pd_sprites.plist"];
        _actors = [CCSpriteBatchNode batchNodeWithFile:@"pd_sprites.pvr.ccz"];
        [_actors.texture setAliasTexParameters];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sprites.plist"];
        _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"Sprites.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game-art.plist"];
        _airplaneBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"game-art.pvr.ccz"];
        
        [self addChild:_batchNode z:-6];
        [self addChild:_actors z:-5];
        [self addChild:_airplaneBatchNode z:-4];
        [self initCoreData];
        [self initTileMap];
        [self initVariable];
        [self initHero];
        [self initMenue];
        [self initEnemies];
        [self addLightening];
        [self scheduleUpdate];
    }
    return self;
}

-(void)addLightening{
    _lighteningBolt = [CCSprite spriteWithFile:@"lightning_bolt.png"];
    [self addChild:_lighteningBolt];
    _lighteningBolt.opacity = 70;
    _lighteningBolt.visible= NO;
    
    _lighteningGlow = [CCSprite spriteWithFile:@"lightning_glow.png"];
    _lighteningGlow.color = ccc3(225, 225, 225);
    _lighteningGlow.position = _lighteningBolt.position;
    _lighteningGlow.blendFunc = (ccBlendFunc) {GL_ONE, GL_ONE};
    _lighteningGlow.opacity = 100;
    _lighteningGlow.visible = NO;
    [self addChild:_lighteningGlow];
    
    _lighteningTime=0;
}

-(void)initCoreData{
    _mocManager = [[MocManager alloc] init];
    
    NSArray *fetChedObjectInfo = [_mocManager fetchGameObjectsInfo];
    
    for (GameObjectInfo *info in fetChedObjectInfo)
    {
        switch ([info.skill intValue]) {
            case kbutton1:
                _button1Skill = [info.details.points intValue];
                break;
            case kbutton2:
                _button2Skill = [info.details.points intValue];
                break;
            case kbutton3:
                _button3Skill = [info.details.points intValue];
                break;
            case kbutton4:
                _button4Skill = [info.details.points intValue];
                break;
            case kbutton5:
                _button5Skill = [info.details.points intValue];
                break;
            case kbutton7:
                _button7Skill = [info.details.points intValue];
                break;
            case kbutton8:
                _button7Skill = [info.details.points intValue];
                break;
            case kbutton9:
                _button9Skill = [info.details.points intValue];
                break;
            case kbutton10:
                _button10Skill = [info.details.points intValue];
                break;
            case kbutton11:
                _button11Skill = [info.details.points intValue];
                break;
            case kMachineGunBullets:
                _shotGunSpreadBulletsNum = [info.details.points intValue];
                break;
                
            default:
                break;
                
                if (info.chapter)
                {
                    //Why this method gives a value of 0?
//                    _gameLevel = [info.details.points intValue];
                    CCLOG(@"gamelevel = %d", [info.details.points intValue]);
                }
        }
        
        for (GameObjectInfo *info in fetChedObjectInfo)
        {
            if (info.chapter)
            {
                _gameLevel = [info.details.points intValue];
                CCLOG(@"chapter %d", [info.details.points intValue]);
            }
        }
    }
}

-(void)initTileMap {
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"isometric.tmx"];
    for (CCTMXLayer *child in [_tileMap children]) {
        [[child texture] setAliasTexParameters];
    }
    
//    _tileMap.position = CGPointMake(20, 30);
    _tileMap.visible = NO;
    //initialize TMXLayer layer1
    _layer1 = [_tileMap layerNamed:@"background"];
    
    [self addChild:_tileMap z:-6];
}

-(void)initHero {
    if (_gameLevel <2)
    {
        hero2 = [_mainHeroInitManager MainHeroChooser:0 IngameLayer:self];
        hero2.bulletActionType = kbulletActionMachineGun;
    }
    if (_gameLevel == 2)
    {
        hero2 = [_mainHeroInitManager MainHeroChooser:0 IngameLayer:self];
        hero2.position = ccp(hero2.position.x + 49, hero2.position.y);
    }
    if (_gameLevel == 3)
    {
        hero2 = [_mainHeroInitManager MainHeroChooser:0 IngameLayer:self];
        hero5 = [_mainHeroInitManager MainHeroChooser:2 IngameLayer:self];
        hero2.position = ccp(hero2.position.x + 49 * 2, hero2.position.y);
        hero5.position = hero2.position;
    }
}

-(void)initMenue {
    if (_gameLevel == 0)
    {
        _timer1 = [_initMenuManager TimerSelector:0];
        _playerButton = [_initMenuManager MenuSelector:1 ActionSprite:hero2];
        
        _timer2 = [_initMenuManager TimerSelector:0];
        _playerButton2 = [_initMenuManager MenuSelector:2 ActionSprite:hero2];
        
        _timer3 = [_initMenuManager TimerSelector:0];
        _playerButton3 = [_initMenuManager MenuSelector:3 ActionSprite:hero2];
    }
    
    if (_gameLevel == 1) {
        _timer1 = [_initMenuManager TimerSelector:0];
        _playerButton = [_initMenuManager MenuSelector:1 ActionSprite:hero2];
        
        _timer2 = [_initMenuManager TimerSelector:0];
        _playerButton2 = [_initMenuManager MenuSelector:2 ActionSprite:hero2];
        
        _timer3 = [_initMenuManager TimerSelector:0];
        _playerButton3 = [_initMenuManager MenuSelector:3 ActionSprite:hero2];
        
        _timer4 = [_initMenuManager TimerSelector:0];
        _playerButton4 = [_initMenuManager MenuSelector:4 ActionSprite:hero2];
        
        _timer5 = [_initMenuManager TimerSelector:0];
        _playerButton5 = [_initMenuManager MenuSelector:5 ActionSprite:hero2];
        
        hero2.walkAction = [hero2 walkDelay:1.0/12.0 velocity:0 vector:CGPointZero];
        CCCallBlock *finishWalk = [CCCallBlock actionWithBlock:^{
            [hero2 idle];
        }];
        [hero2 walk];
        [hero2 runAction:[CCSequence actions:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)], finishWalk, nil]];
        
        [_playerButton runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton2 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton3 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton4 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton5 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        
    }
    
    if (_gameLevel == 2) {
        _timer1 = [_initMenuManager TimerSelector:0];
        _playerButton = [_initMenuManager MenuSelector:1 ActionSprite:hero2];
        
        _timer2 = [_initMenuManager TimerSelector:0];
        _playerButton2 = [_initMenuManager MenuSelector:2 ActionSprite:hero2];
        
        _timer3 = [_initMenuManager TimerSelector:0];
        _playerButton3 = [_initMenuManager MenuSelector:3 ActionSprite:hero2];
        
        _timer4 = [_initMenuManager TimerSelector:0];
        _playerButton4 = [_initMenuManager MenuSelector:4 ActionSprite:hero2];
        
        _timer5 = [_initMenuManager TimerSelector:0];
        _playerButton5 = [_initMenuManager MenuSelector:5 ActionSprite:hero2];
        
        _timer6 = [_initMenuManager TimerSelector:0];
        _playerButton6 = [_initMenuManager MenuSelector:6 ActionSprite:hero2];
        
        hero2.walkAction = [hero2 walkDelay:1.0/12.0 velocity:0 vector:CGPointZero];
        CCCallBlock *finishWalk = [CCCallBlock actionWithBlock:^{
            [hero2 idle];
        }];
        [hero2 walk];
        [hero2 runAction:[CCSequence actions:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)], [CCMoveBy actionWithDuration:1 position:ccp(0, 25)], finishWalk, nil]];
        
        [_playerButton runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton2 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton3 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton4 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton5 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
        [_playerButton6 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(49, 0)]];
    }
    
    if (_gameLevel == 3)
    {
    _timer1 = [_initMenuManager TimerSelector:0];
    _playerButton = [_initMenuManager MenuSelector:1 ActionSprite:hero2];
    
    _timer2 = [_initMenuManager TimerSelector:0];
    _playerButton2 = [_initMenuManager MenuSelector:2 ActionSprite:hero2];
    
    _timer3 = [_initMenuManager TimerSelector:0];
    _playerButton3 = [_initMenuManager MenuSelector:3 ActionSprite:hero2];
    
    _timer4 = [_initMenuManager TimerSelector:0];
    _playerButton4 = [_initMenuManager MenuSelector:4 ActionSprite:hero2];
    
    _timer5 = [_initMenuManager TimerSelector:0];
    _playerButton5 = [_initMenuManager MenuSelector:5 ActionSprite:hero2];
    
    _timer6 = [_initMenuManager TimerSelector:0];
    _playerButton6 = [_initMenuManager MenuSelector:6 ActionSprite:hero2];
    
    _timer7 = [_initMenuManager TimerSelector:0];
    _playerButton7 = [_initMenuManager MenuSelector:7 ActionSprite:hero5];
    
    _timer8 = [_initMenuManager TimerSelector:0];
    _playerButton8 = [_initMenuManager MenuSelector:8 ActionSprite:hero5];
    
    _timer9 = [_initMenuManager TimerSelector:0];
    _playerButton9 = [_initMenuManager MenuSelector:9 ActionSprite:hero5];
    
    _timer10 = [_initMenuManager TimerSelector:0];
    _playerButton10 = [_initMenuManager MenuSelector:10 ActionSprite:hero5];
    
    _timer11 = [_initMenuManager TimerSelector:0];
    _playerButton11 = [_initMenuManager MenuSelector:11 ActionSprite:hero5];
    
    _timer12 = [_initMenuManager TimerSelector:0];
    _playerButton12 = [_initMenuManager MenuSelector:12 ActionSprite:hero5];
        
        hero2.walkAction = [hero2 walkDelay:1.0/12.0 velocity:0 vector:CGPointZero];
        CCCallBlock *finishWalk2 = [CCCallBlock actionWithBlock:^{
            [hero2 idle];
        }];
        [hero2 walk];
        [hero2 runAction:[CCSequence actions:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)], finishWalk2, nil]];
        
        [_playerButton runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        [_playerButton2 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        [_playerButton3 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        [_playerButton4 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        [_playerButton5 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        [_playerButton6 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, 66)]];
        
        hero5.walkAction = [hero5 walkDelay:1.0/12.0 velocity:0 vector:CGPointZero];
        CCCallBlock *finishWalk5 = [CCCallBlock actionWithBlock:^{
            [hero5 idle];
        }];
        [hero5 walk];
        [hero5 runAction:[CCSequence actions:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)], finishWalk5, nil]];
        
        [_playerButton7 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
        [_playerButton8 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
        [_playerButton9 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
        [_playerButton10 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
        [_playerButton11 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
        [_playerButton12 runAction:[CCMoveBy actionWithDuration:2.5 position:ccp(0, -81)]];
    }
    
    //player button scale
    _playerButton.scale = 0.5;
    _playerButton2.scale = 0.5;
    _playerButton3.scale = 0.5;
    _playerButton4.scale = 0.5;
    _playerButton5.scale = 0.5;
    _playerButton6.scale = 0.5;
    _playerButton7.scale = 0.5;
    _playerButton8.scale = 0.5;
    _playerButton9.scale = 0.5;
    _playerButton10.scale = 0.5;
    _playerButton11.scale = 0.5;
    _playerButton12.scale = 0.5;
    
    
    CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Pause" target:self selector:@selector(onPause:)];
    item1.position = ccp(self.winSize.width - 50, self.winSize.height - 40);
    
    CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
    item2.position = ccp(self.winSize.width - 50, self.winSize.height - 300);
    
    CCMenu * menu = [CCMenu menuWithItems: item1, item2, _playerButton, _playerButton2, _playerButton3, _playerButton4, _playerButton5, _playerButton6, _playerButton7, _playerButton8, _playerButton9,_playerButton10, _playerButton11, _playerButton12, nil];
    menu.position = CGPointZero;
    
    [self addChild:menu];
}

-(void)initVariable {
    onPause = YES;
    sharedIngameLayer = self;
    //init Skill Manager
    _skillManager = [[SkillManager alloc] init];
    _mainHeroInitManager = [[MainHeroInitManager alloc] init];
    _initMenuManager = [[InitMenuManager alloc] init];
    
    //init Array
    _enemyArray = [[CCArray alloc] init];
    _heroArray = [[CCArray alloc] init];
    
    //attributes use for Directions
    CGPoint holdTempPosition = [_layer1 positionAt:ccp(0, 0)];
    CGPoint holdDesirePosition = [_layer1 positionAt:ccp(1, 0)];
    
    //init Direction Vectors
    _allyVector = ccpNormalize(ccpSub(holdDesirePosition, holdTempPosition));
    _enemyVector = ccpMult(_allyVector, -1);
    
    //init winSize
    _winSize = [[CCDirector sharedDirector] winSize];
    
    //define positions
    //strait
    CGPoint position1 = [_layer1 positionAt:ccp(7, 2)];
    //two point up and down
    CGPoint position2 = [_layer1 positionAt:ccp(7, 1)];
    CGPoint position3 = [_layer1 positionAt:ccp(7, 3)];
    //side bullet
    CGPoint position4 = [_layer1 positionAt:ccp(1, 0)];
    CGPoint position5 = [_layer1 positionAt:ccp(1, 4)];
    CGPoint position6 = [_layer1 positionAt:ccp(2, 0)];
    CGPoint position7 = [_layer1 positionAt:ccp(2, 4)];
    
    CGPoint origin = [_layer1 positionAt:ccp(0, 2)];
    
    _direction1 = ccpNormalize(ccpSub(position1, origin));
    _direction2 = ccpNormalize(ccpSub(position2, origin));
    _direction3 = ccpNormalize(ccpSub(position3, origin));
    _direction4 = ccpNormalize(ccpSub(position4, origin));
    _direction5 = ccpNormalize(ccpSub(position5, origin));
    _direction6 = ccpNormalize(ccpSub(position6, origin));
    _direction7 = ccpNormalize(ccpSub(position7, origin));
}

-(void)initEnemies
{
    _gameLevelManager = [[GameLevelManager alloc] initWithLevel:_gameLevel IngameLayer:self];
    CCLOG(@"gamelevel%d", _gameLevel);
    [self addChild:_gameLevelManager];
}

- (void)PlayerButton1Tapped:(id)sender
{
    
    [AppController sharedAppController].skillType = _button1Skill;
    [_skillManager managingSkills:hero2];
    
    _timer1.percentage = 0;
}

- (void)PlayerButton2Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button2Skill;
   [_skillManager managingSkills:hero2];
    _timer2.percentage = 0;

}

- (void)PlayerButton3Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button3Skill;
    [_skillManager managingSkills:hero2];
    _timer3.percentage = 0;
}

- (void)PlayerButton4Tapped:(id)sender
{    
    [AppController sharedAppController].skillType = _button4Skill;
    [_skillManager managingSkills:hero2];
    _timer4.percentage = 0;
}

- (void)PlayerButton5Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button5Skill;
    [_skillManager managingSkills:hero2];
    
    _timer5.percentage = 0;
}

- (void)PlayerButton6Tapped:(id)sender
{
    switch (_swappingMove1)
    {
        case 0:
            _swappingMove1++;
            if (_gameLevel == 2) {
                hero2.position = ccp(hero2.position.x, hero2.position.y - 50);
            }
            else hero2.position = ccp(hero2.position.x, hero2.position.y - 25);
            break;
        case 1:
            _swappingMove1--;
            if (_gameLevel ==2)
            {
                hero2.position = ccp(hero2.position.x, hero2.position.y + 50);
            }
            else hero2.position = ccp(hero2.position.x, hero2.position.y + 25);
            break;
    }
    //update the two clone's position
    [[TwoCloneShooter sharedTwoCloneShooterLayer] updatePosition:hero2];
    [[DefenseWallSkill1 sharedDefenseWallSkill1Layer] updatePosition:hero2];
    [[SideSpreadingSkill sharedSideSpreadingSkillLayer] updatePosition:hero2];
    
}

- (void)PlayerButton7Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button7Skill;
    [_skillManager managingSkills:hero5];
    _timer7.percentage = 0;
}

- (void)PlayerButton8Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button8Skill;
    [_skillManager managingSkills:hero5];
    _timer8.percentage = 0;
}

- (void)PlayerButton9Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button9Skill;
    [_skillManager managingSkills:hero5];
    _timer9.percentage = 0;
}

- (void)PlayerButton10Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button10Skill;
    [_skillManager managingSkills:hero5];
    _timer10.percentage = 0;
}

- (void)PlayerButton11Tapped:(id)sender
{
    [AppController sharedAppController].skillType = _button11Skill;
    [_skillManager managingSkills:hero5];
    _timer11.percentage = 0;
}

- (void)PlayerButton12Tapped:(id)sender
{
    switch (_swappingMove2)
    {
        case 0:
            _swappingMove2++;
            hero5.position = ccp(hero5.position.x, hero5.position.y + 25);
            break;
        case 1:
            _swappingMove2--;
            hero5.position = ccp(hero5.position.x, hero5.position.y - 25);
            break;
    }
    
    [[TwoCloneShooter2 sharedTwoCloneShooterLayer] updatePosition:hero5];
    [[DefenseWallSkill2 sharedDefenseWallSkill2Layer] updatePosition:hero5];
    [[SideSpreadingSkill2 sharedSideSpreadingSkill2Layer] updatePosition:hero5];
}

-(void)update:(ccTime)dt
{
    [self lightning];
    [self updateCooldown:dt];
}

-(void)endGameLose
{
    _gameFinished = YES;
    [SceneManager goLosingLayer];
}

-(void)endGameWin
{
        [SceneManager goWinningLayer];
        NSArray *fetChedObjectInfo = [_mocManager fetchGameObjectsInfo];
        for (GameObjectInfo *info in fetChedObjectInfo)
        {
            if (info.chapter)
            {
                [_mocManager deleteGameObjects:info];
            }
        }
        _gameLevel ++;
        [_mocManager insertChapter:_gameLevel toChapter:_gameLevel];
    for (GameObjectInfo *info in fetChedObjectInfo)
    {
        if (info.chapter)
        {
            CCLOG(@"chapter %d", [info.details.points intValue]);
        }
    }
}

-(void)lightning
{
    int randomNumber = CCRANDOM_0_1() *70;
    if (randomNumber == 7)
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        if (_lighteningTime < 0)
        {
            _lighteningTime = CCRANDOM_0_1() *5 +5;
            if (_lighteningTime <6)
                _lighteningBolt.position = ccp(screenSize.width/2 - 60, screenSize.height/2);
            else if (_lighteningTime < 7) _lighteningBolt.position = ccp(screenSize.width/2, screenSize.height/2);
            else _lighteningBolt.position = ccp(screenSize.width/2 + 60, screenSize.height/2);
            _lighteningGlow.position = _lighteningBolt.position;
            _lighteningBolt.visible = YES;
            _lighteningGlow.visible = YES;
        }
    }
    
    _lighteningTime --;
    if (_lighteningTime == 0)
    {
        _lighteningBolt.visible = NO;
        _lighteningGlow.visible = NO;
    }
}

-(void)updateCooldown:(ccTime)dt
{
    if (_timer1.percentage < 100)
    {
        _timer1.percentage += dt * _timer1.chargingRate;
        _timer1.opacity = 50;
        _playerButton.isEnabled = NO;
        
    } else if (_timer1.opacity == 50) {_timer1.opacity = 255; _playerButton.isEnabled = YES;}
    
    if (_timer2.percentage < 100)
    {
        _timer2.percentage += dt *_timer2.chargingRate;
        _timer2.opacity = 50;
        _playerButton2.isEnabled = NO;
    } else if (_timer2.opacity == 50) {_timer2.opacity = 255; _playerButton2.isEnabled = YES;}
    
    if (_timer3.percentage < 100)
    {
        _timer3.percentage += dt *_timer3.chargingRate;
        _timer3.opacity = 50;
        _playerButton3.isEnabled = NO;
    } else if (_timer3.opacity == 50) {_timer3.opacity = 255; _playerButton3.isEnabled = YES;}
    
    if (_timer4.percentage < 100)
    {
        _timer4.percentage += dt *_timer4.chargingRate;
        _timer4.opacity = 50;
        _playerButton4.isEnabled = NO;
    } else if (_timer4.opacity == 50) {_timer4.opacity = 255; _playerButton4.isEnabled = YES;}
    
    if (_timer5.percentage < 100)
    {
        _timer5.percentage += dt * _timer5.chargingRate;
        _timer5.opacity = 50;
        _playerButton5.isEnabled = NO;
    } else if (_timer5.opacity == 50) {_timer5.opacity = 255; _playerButton5.isEnabled = YES;}
    
    if (_timer6.percentage < 100)
    {
        _timer6.percentage += dt *_timer6.chargingRate;
        _timer6.opacity = 50;
        _playerButton6.isEnabled = NO;
    } else if (_timer6.opacity == 50) {_timer6.opacity = 255; _playerButton6.isEnabled = YES;}
    
    if (_timer7.percentage < 100)
    {
        _timer7.percentage += dt *_timer7.chargingRate;
        _timer7.opacity = 50;
        _playerButton7.isEnabled = NO;
    } else if (_timer7.opacity == 50) {_timer7.opacity = 255; _playerButton7.isEnabled = YES;}
    
    if (_timer8.percentage < 100)
    {
        _timer8.percentage += dt *_timer8.chargingRate;
        _timer8.opacity = 50;
        _playerButton8.isEnabled = NO;
    } else if (_timer8.opacity == 50) {_timer8.opacity = 255; _playerButton8.isEnabled = YES;}
    
    if (_timer9.percentage < 100)
    {
        _timer9.percentage += dt *_timer9.chargingRate;
        _timer9.opacity = 50;
        _playerButton9.isEnabled = NO;
    } else if (_timer9.opacity == 50){ _timer9.opacity = 255; _playerButton9.isEnabled = YES;}
    
    if (_timer10.percentage < 100)
    {
        _timer10.percentage += dt *_timer10.chargingRate;
        _timer10.opacity = 50;
        _playerButton10.isEnabled = NO;
    } else if (_timer10.opacity == 50) {_timer10.opacity = 255; _playerButton10.isEnabled = YES;}
    
    if (_timer11.percentage < 100)
    {
        _timer11.percentage += dt * _timer11.chargingRate;
        _timer11.opacity = 50;
        _playerButton11.isEnabled = NO;
    } else if (_timer11.opacity == 50) {_timer11.opacity = 255; _playerButton11.isEnabled = YES;}
    
    if (_timer12.percentage < 100)
    {
        _timer12.percentage += dt *_timer12.chargingRate;
        _timer12.opacity = 50;
        _playerButton12.isEnabled = NO;
    } else if (_timer12.opacity == 50) {_timer12.opacity = 255; _playerButton12.isEnabled = YES;}
    
}

-(void)removeTemporaryObject:(ActionSprite*)actionSprite
{
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1];
    
    [actionSprite runAction:[CCSequence actions:fadeOut, [CCCallBlock actionWithBlock:^{[self removeGameObject:actionSprite Team:actionSprite.isAlly];}], nil]];
}

-(void)spwanwithclass:(id)class isAlly:(BOOL)isAlly columnPosition:(int)columnPosition rowPosition:(int)rowPosition additionX:(float)additionX walkActionDelay:(float)delay velocity:(float)velecity
{
    ActionSprite *sprite = [[class alloc] initWithTeam:NO layer:self];
    if (sprite.isMonster) [_batchNode addChild:sprite];
    else [_actors addChild:sprite];
    [_enemyArray addObject:sprite];
    sprite.alive = YES;
    //init Position
    sprite.rowPosition = rowPosition;
    sprite.position = [_layer1 positionAt:ccp(0, rowPosition)];
    sprite.position = ccpAdd(sprite.position, _tileMap.position);
    sprite.position = ccp(_winSize.width + 50 + additionX, sprite.position.y);
    //walkAction
    if (sprite.isMonster) {
        [sprite walk];
        return;
    }
    sprite.walkAction = [sprite walkDelay:delay velocity:velecity vector:_enemyVector];
    sprite.scaleX = -1;
    [sprite walk];
}


# pragma mark Helper methods
-(BOOL)oppositeTeam:(BOOL)team
{
    if (team) return NO;
    else return YES;
}

-(ActionSprite *)playerForTeam:(BOOL)team
{
    if (team) return hero2;
    else return _robot;
}

-(CCArray *)alliesOfTeam:(BOOL)team
{
    if (team) return _heroArray;
    else return _enemyArray;
}

-(CCArray *)enemiesOfTeam:(BOOL)team
{
    if (team) return _enemyArray;
    else return _heroArray;
}

-(void)removeGameObject:(ActionSprite *)gameObject Team:(BOOL)team
{
    if (gameObject.particleSun)
    {
        [gameObject.particleSun stopSystem];
        gameObject.particleSun.autoRemoveOnFinish = YES;
    }
    if (gameObject.particleMeteor)
    {
        [gameObject.particleMeteor stopSystem];
        gameObject.particleMeteor.autoRemoveOnFinish = YES;
    }
    if (gameObject.particleFlower)
    {
        [gameObject.particleFlower stopSystem];
        gameObject.particleFlower.autoRemoveOnFinish = YES;
    }
    if (team) [_heroArray removeObject:gameObject];
    else [_enemyArray removeObject:gameObject];
    [gameObject removeFromParentAndCleanup:YES];
    [gameObject.glowSprite removeFromParentAndCleanup:YES];
}

-(ActionSprite *)createBulletClass:(id)class ForTeam:(BOOL)isAlly withActor:(BOOL)actors actionSprite:(ActionSprite *)actionSprite
{
    ActionSprite * bullet = [[class alloc]initWithTeam:isAlly layer:self actionSprite:actionSprite];
    if (isAlly) [_heroArray addObject:bullet];
    else [_enemyArray addObject:bullet];
    if (actors) [_actors addChild:bullet];
    else [_batchNode addChild:bullet];
    return bullet;
}

-(void)glowAt:(CGPoint)position withScale:(CGSize)size withColor:(ccColor3B)color withRotation:(float)rotation withSprite:(ActionSprite *)sprite
{
    sprite.glowSprite = [CCSprite spriteWithFile:@"fire.png"];
    sprite.glowSprite.color = color;
    sprite.glowSprite.position = position;
    sprite.glowSprite.rotation = rotation;
    sprite.glowSprite.blendFunc = (ccBlendFunc){GL_ONE, GL_ONE};
    [sprite.glowSprite runAction:[CCRepeatForever actionWithAction:[CCSequence actionOne:[CCScaleTo actionWithDuration:0.9 scaleX:size.width scaleY:size.height] two:[CCScaleTo actionWithDuration:0.9 scaleX:size.width*0.1 scaleY:size.height *0.1]]]];
    [sprite.glowSprite runAction:[CCRepeatForever actionWithAction:[CCSequence actionOne:[CCFadeTo actionWithDuration:0.9 opacity:100] two:[CCFadeTo actionWithDuration:0.9 opacity:200]]]];
    [self addChild:sprite.glowSprite];
}

#ifdef DEBUG
// Draw the object rectangles for debugging and illustration purposes.

/* -(void) draw
 {
 glLineWidth(2.0f);
 ccDrawColor4F(1, 1, 1, 1);
 
 int width = _layer1.layerSize.width;
 int height = _layer1.layerSize.height;
 
 float tileWidth= _tileMap.tileSize.width;
 float tileHeight = _tileMap.tileSize.height;
 for (int x = 0; x < width; x++)
 {
 for (int y = 0; y < height; y++)
 {
 CGPoint tileCoord = CGPointMake(x, y);
 CGPoint tilePos = [_layer1 positionAt:tileCoord];
 
 CGPoint center = ccpAdd(tilePos, _tileMap.position);
 
 float lineLength = 4;
 CGPoint point1, point2;
 point1 = CGPointMake(center.x - lineLength, center.y);
 point2 = CGPointMake(center.x + lineLength, center.y);
 ccDrawLine(point1, point2);
 point1 = CGPointMake(center.x, center.y - lineLength);
 point2 = CGPointMake(center.x, center.y + lineLength);
 ccDrawLine(point1, point2);
 
 CGPoint point11, point21, point31, point41;
 point11 = CGPointMake(center.x - tileWidth/2, center.y);
 point21 = CGPointMake(center.x, center.y - tileHeight/2);
 point31 = CGPointMake(center.x + tileWidth/2, center.y);
 point41 = CGPointMake(center.x, center.y + tileHeight/2);
 ccDrawLine(point11, point21);
 ccDrawLine(point21, point31);
 ccDrawLine(point31, point41);
 ccDrawLine(point41, point11);
 }
 }
 
 ActionSprite *actionSprite;
 CCARRAY_FOREACH(_enemyArray, actionSprite)
 {
 CGRect rect1 = actionSprite.hitBox.actual;
 CGPoint vertices1[4]={
 ccp(rect1.origin.x,rect1.origin.y),
 ccp(rect1.origin.x+rect1.size.width,rect1.origin.y),
 ccp(rect1.origin.x+rect1.size.width,rect1.origin.y+rect1.size.height),
 ccp(rect1.origin.x,rect1.origin.y+rect1.size.height),
 };
 ccDrawPoly(vertices1, 4, YES);
 
 CGRect rect11 = actionSprite.attackBox.actual;
 CGPoint vertices11[4]={
 ccp(rect11.origin.x,rect11.origin.y),
 ccp(rect11.origin.x+rect11.size.width,rect11.origin.y),
 ccp(rect11.origin.x+rect11.size.width,rect11.origin.y+rect11.size.height),
 ccp(rect11.origin.x,rect11.origin.y+rect11.size.height),
 };
 ccDrawPoly(vertices11, 4, YES);
 }
 CCARRAY_FOREACH(_heroArray, actionSprite)
 {
 CGRect rect1 = actionSprite.hitBox.actual;
 CGPoint vertices1[4]={
 ccp(rect1.origin.x,rect1.origin.y),
 ccp(rect1.origin.x+rect1.size.width,rect1.origin.y),
 ccp(rect1.origin.x+rect1.size.width,rect1.origin.y+rect1.size.height),
 ccp(rect1.origin.x,rect1.origin.y+rect1.size.height),
 };
 ccDrawPoly(vertices1, 4, YES);
 
 CGRect rect11 = actionSprite.attackBox.actual;
 CGPoint vertices11[4]={
 ccp(rect11.origin.x,rect11.origin.y),
 ccp(rect11.origin.x+rect11.size.width,rect11.origin.y),
 ccp(rect11.origin.x+rect11.size.width,rect11.origin.y+rect11.size.height),
 ccp(rect11.origin.x,rect11.origin.y+rect11.size.height),
 };
 ccDrawPoly(vertices11, 4, YES);
 }
 
 glLineWidth(1.0f);
 ccDrawColor4F(1, 1, 1, 1);
 
 
 ccDrawColor4F(1, 1, 1, 1);
 
 
 }*/
#endif

@end
