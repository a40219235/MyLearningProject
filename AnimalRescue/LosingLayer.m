//
//  LosingLayer.m
//  AnimalRescue
//
//  Created by iMac on 3/22/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LosingLayer.h"
#import "GameScene.h"
#import "SceneManager.h"
#import "InGameLayer.h"


@implementation LosingLayer

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        int largeFont = screenSize.height/ 10;
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:largeFont];
        
        CCMenuItem *youWon2 =[CCMenuItemFont itemWithString:@"you lose"];
        youWon2.position = ccp(screenSize.width/2, screenSize.height/2 + 128 - 32);

        
        CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Restart Level" target:self selector:@selector(onNextLevel:)];
        CCMenuItemFont *upgrade = [CCMenuItemFont itemWithString:@"Upgrade" target:self selector:@selector(onUpgrade:)];
        item1.position = ccp(screenSize.width/2, screenSize.height/2 + 16);
        upgrade.position = ccp(screenSize.width/2, screenSize.height/2 - 32);
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        item2.position = ccp(32, 32);
        
        CCMenu *menu = [CCMenu menuWithItems:youWon2, item1, item2, upgrade, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}

-(void)onNextLevel: (id)sender
{
    GameScene *gameScene = [GameScene node];
    InGameLayer *ingameLayer = [InGameLayer node];
    [gameScene addChild:ingameLayer];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:gameScene withColor:ccWHITE]];
}

-(void)onBack:(id)sender
{
    [SceneManager goChapterSelect];
}

-(void)onUpgrade:(id)sender
{
    [SceneManager goUpgradeLayer];
}

@end