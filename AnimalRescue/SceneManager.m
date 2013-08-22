//
//  SceneManager.m
//  AnimalRescue
//
//  Created by iMac on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"
#import "GameScene.h"


@implementation SceneManager

+(void) goMainMenu
{
    [self go:[MainMenu node]];
}

+(void) goChapterSelect
{
    [[[CCDirector sharedDirector] scheduler] setTimeScale:1];
    [self go:[ChapterSelect node]];
}

+(void) goOptionMenu
{
    [self go:[OptionMenu node]];
}

+(void) goUpgradeLayer
{
    [self go:[UpgradeLayer node]];
}

+(void)goAppStoreList
{
    GameScene *gameScene = [GameScene node];
    AppStoreList *appStoreList = [AppStoreList node];
    [gameScene addChild:appStoreList];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0 scene:gameScene]];
}

+(void)goWinningLayer
{
    GameScene *gameScene = [GameScene node];
    WinningLayer *winningLayer = [WinningLayer node];
    [gameScene addChild:winningLayer];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:gameScene withColor:ccWHITE]];
}

+(void)goLosingLayer
{
    GameScene *gameScene = [GameScene node];
    LosingLayer *losingLayer = [LosingLayer node];
    [gameScene addChild:losingLayer];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:gameScene withColor:ccWHITE]];
}

+(void) go:(CCLayer *)layer
{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [SceneManager wrap:layer];
    if ([director runningScene]) [director replaceScene:newScene];
    else [director runWithScene:newScene];
}

+(CCScene *)wrap: (CCLayer *) layer
{
    GameScene *gameScene = [GameScene node];
    [gameScene addChild:layer];
    return gameScene;
}



@end
