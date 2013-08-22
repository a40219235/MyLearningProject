//
//  MainHeroInitManager.m
//  AnimalRescue
//
//  Created by iMac on 4/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainHeroInitManager.h"
#import "Hero.h"


@implementation MainHeroInitManager

-(ActionSprite *)MainHeroChooser:(int)HeroChooser IngameLayer:(InGameLayer *)ingameLayer
{
    ActionSprite *sprite;
    switch (HeroChooser)
    {
        case 0:
            sprite = [self executeHero0Init:ingameLayer];
            break;
            
        case 1:
            sprite = [self executeHero1Init:ingameLayer];
            break;
            
        case 2:
            sprite = [self executeHero2Init:ingameLayer];
            
        default: CCLOG(@"Main Hero Chooser");
            break;
    }
    return sprite;
}
//init first
-(ActionSprite *)executeHero0Init:(InGameLayer *)ingameLayer
{
    ActionSprite *sprite = [[Hero alloc] initWithTeam:YES layer:ingameLayer];
    [ingameLayer.actors addChild:sprite];
    [ingameLayer.heroArray addObject:sprite];
    sprite.rowPosition = 1;
    sprite.position = ccp(65, ingameLayer.winSize.height/2);
    sprite.position = ccpAdd(sprite.position, ingameLayer.tileMap.position);
    sprite.isRanged = YES;
    sprite.attackRate = 1;
    //assign Bullet Class and Bullet Action Type
    sprite.bulletClass = [QuirkBullet class];
    sprite.bulletActionType = kbulletActionShotGunSpread;
    sprite.isMainHero = YES;
    [sprite idle];
    return sprite;
}

-(ActionSprite *)executeHero1Init:(InGameLayer *)ingameLayer
{
    ActionSprite *sprite1 = [[Hero alloc] initWithTeam:YES layer:ingameLayer];
    [ingameLayer.actors addChild:sprite1];
    [ingameLayer.heroArray addObject:sprite1];
    sprite1.rowPosition = 1;
    sprite1.position = [ingameLayer.layer1 positionAt:ccp(3, sprite1.rowPosition)];
    sprite1.position = ccpAdd(sprite1.position, ingameLayer.tileMap.position);
    sprite1.isRanged = YES;
    sprite1.attackRate = 1;
    sprite1.bulletClass = [QuirkBullet class];
    sprite1.bulletActionType = kbulletActionShotGunSpread;
    sprite1.isMainHero = YES;
    [sprite1 idle];
    
    return sprite1;
}

-(ActionSprite *)executeHero2Init:(InGameLayer *)ingameLayer
{
    ActionSprite *sprite2 = [[Hero alloc] initWithTeam:YES layer:ingameLayer];
    [ingameLayer.actors addChild:sprite2];
    [ingameLayer.heroArray addObject:sprite2];
    sprite2.rowPosition = 4;
    sprite2.position = [ingameLayer.layer1 positionAt:ccp(3, sprite2.rowPosition)];
    sprite2.position = ccpAdd(sprite2.position, ingameLayer.tileMap.position);
    sprite2.isRanged = YES;
    sprite2.attackRate = 1;
    //assign Bullet Class and Bullet Action Type
    sprite2.bulletClass = [QuirkBullet class];
    sprite2.bulletActionType = kbulletActionShotGunSpread;
    sprite2.isMainHero = YES;
    [sprite2 idle];
    
    return sprite2;
}

@end
