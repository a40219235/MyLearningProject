//
//  Hero2Upgrade.m
//  AnimalRescue
//
//  Created by iMac on 4/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Hero2Upgrade.h"
#import "SceneManager.h"
#import "GameObjectInfo.h"
#import "GameObjectDetails.h"
#import "Hero.h"
#import "InGameLayer.h"
#import "AppDelegate.h"


@implementation Hero2Upgrade
{
    CCLabelBMFont * _hero1Point;
    
    int _hero1Upgrade;
    
    MocManager *_mocManager;
    CGSize _winSize;
    Hero *hero;
    CCArray *buttonArray_;
    CCSprite *_button1, *_button2, *_button3, *_button4, *_button5;
    
    CCMenuItemFont *_skill1, *_skill2, *_skill3, *_skill4, *_skill5, *_skill6, *_skill7, *_skill8, *_skill9, *_skill10, *_skill11;
    
    CCSprite *_buttonHolder2, *_buttonHolder3, *_buttonHolder4, *_buttonHolder5, *_buttonHolder6;
}

-(void)setupButtons
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game-art.plist"];
    _button1 = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    _button2 = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    _button3 = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    _button4 = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    _button5 = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    
    [self addChild:_button1];
    [self addChild:_button2];
    [self addChild:_button3];
    [self addChild:_button4];
    [self addChild:_button5];
    
    _button1.scale = 0.5;
    _button2.scale = 0.5;
    _button3.scale = 0.5;
    _button4.scale = 0.5;
    _button5.scale = 0.5;
    
    
    _button1.position = ccp(hero.position.x - 35, hero.position.y + 49);
    _button2.position = ccp(hero.position.x - 36, hero.position.y);
    _button3.position = ccp(hero.position.x - 35, hero.position.y - 49);
    _button4.position = ccp(hero.position.x - 84, hero.position.y +24);
    _button5.position = ccp(hero.position.x - 84, hero.position.y - 24);
    
    _button1.assignButton = kbutton7;
    _button2.assignButton = kbutton8;
    _button3.assignButton = kbutton9;
    _button4.assignButton = kbutton10;
    _button5.assignButton = kbutton11;
    
    buttonArray_ = [[CCArray alloc] initWithCapacity:5];
    [buttonArray_ addObject:_button1];
    [buttonArray_ addObject:_button2];
    [buttonArray_ addObject:_button3];
    [buttonArray_ addObject:_button4];
    [buttonArray_ addObject:_button5];
}

-(void)setupHero
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pd_sprites.plist"];
    hero = [[Hero alloc] initWithTeam:NO layer:nil];
    hero.walkAction = [hero walkDelay:1.0/12.0 velocity:0 vector:CGPointZero];
    [hero walk];
    [self addChild:hero];
    hero.position = ccp(114, _winSize.height/2);
}

//return an empty button and assign the skill to it
-(CCSprite *)choosingButtonwithSkill:(SkillType)skillType
{
    NSArray *fetchedObjectInfo = [_mocManager fetchGameObjectsInfo];
    
    CCSprite *buttonSprite;
    CCARRAY_FOREACH(buttonArray_, buttonSprite)
    {
        if (!buttonSprite.userObject)
        {
            for (GameObjectInfo *info in fetchedObjectInfo)
            {
                if ([info.skill intValue] == buttonSprite.assignButton)
                {
                    [_mocManager deleteGameObjects:info];
                }
            }
            [_mocManager insertpoints:skillType toSkill:buttonSprite.assignButton];
            [_mocManager commitChanges];
            return buttonSprite;
        }
    }
    return nil;
}

-(id)init
{
    if ((self = [super init]))
    {
        _winSize = [CCDirector sharedDirector].winSize;
        
        int largeFont = _winSize.height/ 15;
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:largeFont];
        
        CCMenuItemFont *backButton = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        backButton.position = ccp(32, 32);
        
        _skill1 = [CCMenuItemFont itemWithString:@"MachineGunBullets" target:self selector:@selector(hero1Upgrade:)];
        _skill2 = [CCMenuItemFont itemWithString:@"FireBullet" target:self selector:@selector(FireBullet:)];
        _skill3 = [CCMenuItemFont itemWithString:@"TwoCloneShooter" target:self selector:@selector(TwoCloneShooter:)];
        _skill4 = [CCMenuItemFont itemWithString:@"SideSpreading" target:self selector:@selector(SideSpreading:)];
        _skill5 = [CCMenuItemFont itemWithString:@"Defense" target:self selector:@selector(Defense:)];
        _skill6 = [CCMenuItemFont itemWithString:@"FreezingBullet" target:self selector:@selector(FreezingBullet:)];
        _skill7 = [CCMenuItemFont itemWithString:@"Reset" target:self selector:@selector(hero7Upgrade:)];
        _skill8 = [CCMenuItemFont itemWithString:@"Grenade" target:self selector:@selector(Grenade:)];
        _skill9 = [CCMenuItemFont itemWithString:@"Reflecting" target:self selector:@selector(ReflectingBullet:)];
        _skill10 = [CCMenuItemFont itemWithString:@"Boomerang" target:self selector:@selector(BoomerangBullet:)];
        _skill11 = [CCMenuItemFont itemWithString:@"BoomerangUltimate" target:self selector:@selector(BoomerangUltimate:)];
        
        _skill1.position = ccp(_winSize.width/2, _winSize.height/2 + 128);
        _skill2.position = ccp(_winSize.width/2, _winSize.height/2 + 96);
        _skill3.position = ccp(_winSize.width/2, _winSize.height/2 + 64);
        _skill4.position = ccp(_winSize.width/2, _winSize.height/2 + 32);
        _skill5.position = ccp(_winSize.width/2, _winSize.height/2);
        _skill6.position = ccp(_winSize.width/2, _winSize.height/2 - 32);
        _skill7.position = ccp(_winSize.width/2, _winSize.height/2 - 64);
        _skill8.position = ccp(_winSize.width/2, _winSize.height/2 - 96);
        _skill9.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 96);
        _skill10.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 64);
        _skill11.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 32);
        
        _skill1.menuItemFont = [CCMenuItemFont itemWithString:@"MachineGunBullets"];
        _skill2.menuItemFont = [CCMenuItemFont itemWithString:@"FireBullet"];
        _skill3.menuItemFont = [CCMenuItemFont itemWithString:@"TwoCloneShooter"];
        _skill4.menuItemFont = [CCMenuItemFont itemWithString:@"SideSpreading"];
        _skill5.menuItemFont = [CCMenuItemFont itemWithString:@"Defense"];
        _skill6.menuItemFont = [CCMenuItemFont itemWithString:@"FreezingBullet"];
        _skill7.menuItemFont = [CCMenuItemFont itemWithString:@"Reset"];
        _skill8.menuItemFont = [CCMenuItemFont itemWithString:@"Grenade"];
        _skill9.menuItemFont = [CCMenuItemFont itemWithString:@"Reflecting"];
        _skill10.menuItemFont = [CCMenuItemFont itemWithString:@"Boomerang"];
        _skill11.menuItemFont = [CCMenuItemFont itemWithString:@"BoomerangUltimate"];
        
        [self addChild:_skill1.menuItemFont];
        [self addChild:_skill2.menuItemFont];
        [self addChild:_skill3.menuItemFont];
        [self addChild:_skill4.menuItemFont];
        [self addChild:_skill5.menuItemFont];
        [self addChild:_skill6.menuItemFont];
        [self addChild:_skill7.menuItemFont];
        [self addChild:_skill8.menuItemFont];
        [self addChild:_skill9.menuItemFont];
        [self addChild:_skill10.menuItemFont];
        [self addChild:_skill11.menuItemFont];
        
        _skill1.menuItemFont.opacity = 100;
        _skill2.menuItemFont.opacity = 100;
        _skill3.menuItemFont.opacity = 100;
        _skill4.menuItemFont.opacity = 100;
        _skill5.menuItemFont.opacity = 100;
        _skill6.menuItemFont.opacity = 100;
        _skill7.menuItemFont.opacity = 100;
        _skill8.menuItemFont.opacity = 100;
        _skill9.menuItemFont.opacity = 100;
        _skill10.menuItemFont.opacity = 100;
        _skill11.menuItemFont.opacity = 100;
        
        _skill1.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 + 128);
        _skill2.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 + 96);
        _skill3.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 + 64);
        _skill4.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 + 32);
        _skill5.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2);
        _skill6.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 - 32);
        _skill7.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 - 64);
        _skill8.menuItemFont.position = ccp(_winSize.width/2, _winSize.height/2 - 96);
        _skill9.menuItemFont.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 96);
        _skill10.menuItemFont.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 64);
        _skill11.menuItemFont.position = ccp(_winSize.width/2 + 150, _winSize.height/2 + 32);
        
        CCMenu *menu = [CCMenu menuWithItems:backButton, _skill1, _skill2, _skill3, _skill4, _skill5, _skill6, _skill7, _skill8, _skill9, _skill10, _skill11, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
        _hero1Point = [CCLabelBMFont labelWithString:@"0" fntFile:@"Courier.fnt"];
        _hero1Point.position = ccp(_skill1.position.x + 128, _skill1.position.y + 5);
        [self addChild:_hero1Point];
        
        //CoreData
        _mocManager = [[MocManager alloc] init];
        
        [self initCoreData];
        [self setupHero];
        [self setupButtons];
    }
    return self;
}

-(void)initCoreData
{
    NSArray *fetchedObjectsInfo = [_mocManager fetchGameObjectsInfo];
    for (GameObjectInfo *info in fetchedObjectsInfo)
    {
        if ([info.skill intValue] == kMachineGunBullets)
        {
            _hero1Upgrade = [info.details.points intValue];
            [_mocManager deleteGameObjects:info];
        }
    }
    [_mocManager insertpoints:_hero1Upgrade toSkill:kMachineGunBullets];
    [_hero1Point setString:[NSString stringWithFormat:@"%d", _hero1Upgrade]];
}

-(void)onBack:(id)sender
{
    [SceneManager goChapterSelect];
}

-(void)hero1Upgrade:(id)sender
{
    NSArray *fetchedObjectsInfo = [_mocManager fetchGameObjectsInfo];
    for (GameObjectInfo *info in fetchedObjectsInfo)
    {
        if ([info.skill intValue] == kMachineGunBullets)
        {
            _hero1Upgrade = [info.details.points intValue] +1;
            [_mocManager deleteGameObjects:info];
        }
    }
    [_mocManager insertpoints:_hero1Upgrade toSkill:kMachineGunBullets];
    [_hero1Point setString:[NSString stringWithFormat:@"%d", _hero1Upgrade]];
    [_mocManager commitChanges];
}

//this Method used to run each button when user tapped
-(void)runMenu:(CCMenuItemFont *)sender SkillType:(SkillType)skillType
{
    if (!sender.buttonSprite)
    {
        sender.buttonSprite = [self choosingButtonwithSkill:skillType];
        [sender runAction:[CCMoveTo actionWithDuration:0.15 position:sender.buttonSprite.position]];
        sender.buttonSprite.userObject = self;
    }
    else
    {
        [sender runAction:[CCMoveTo actionWithDuration:0.15 position:sender.menuItemFont.position]];
        sender.buttonSprite.userObject = nil;
        sender.buttonSprite = nil;
    }
}

-(void)FireBullet:(CCMenuItemFont *)sender
{
    
    [self runMenu:sender SkillType:kSkillFireAbility];
}

-(void)TwoCloneShooter:(id)sender
{
    
    [self runMenu:sender SkillType:kSkillTwoCloneShooter2];
}

-(void)SideSpreading:(id)sender
{
    [self runMenu:sender SkillType:kSkillSideSpreading2];
}

-(void)Defense:(id)sender
{
    [self runMenu:sender SkillType:kSkillDefenseWall2];
}

-(void)FreezingBullet:(id)sender
{
    [self runMenu:sender SkillType:kSkillFreezingAbility];
}

-(void)ReflectingBullet:(id)sender
{
    [self runMenu:sender SkillType:kSkillReflectingBullet];
}

-(void)hero7Upgrade:(id)sender
{
    NSArray *fetchedObjectsInfo = [_mocManager fetchGameObjectsInfo];
    
    for (GameObjectInfo *info in fetchedObjectsInfo)
    {
        CCLOG(@"%@ = %@", info.skill, info.details.points);
    }
    
    CCLOG(@"clear");
    for (GameObjectInfo * info in fetchedObjectsInfo)
    {
        [_mocManager deleteGameObjects:info];
    }
    [_mocManager commitChanges];
    [_hero1Point setString:@"0"];
}

-(void)Grenade:(id)sender
{
    [self runMenu:sender SkillType:kSkillGrenade];
}

-(void)BoomerangBullet:(id)sender
{
    [self runMenu:sender SkillType:kSkillBoomerang2];
}

-(void)BoomerangUltimate:(id)sender
{
    [self runMenu:sender SkillType:KSkillBoomerangUltimate];
}


@end
