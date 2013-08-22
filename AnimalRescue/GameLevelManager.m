//
//  GameLevelManager.m
//  AnimalRescue
//
//  Created by iMac on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLevelManager.h"
#import "Level0.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"


@implementation GameLevelManager
{
    GameLevelManager *_currentGameLevel;
}

-(id)initWithLevel:(int)level IngameLayer:(InGameLayer*)ingameLayer
{
    if (self = [super init])
    {
        [self enterLevel:level IngameLayer:ingameLayer];
        [self scheduleUpdate];
    }
    return self;
}

-(void)enterLevel:(int)level IngameLayer:(InGameLayer *)ingameLayer
{
    switch (level)
    {
        case 0:
            _currentGameLevel = [[Level0 alloc] init];
            break;
            
        case 1:
             _currentGameLevel = [[Level1 alloc] init];
            break;
        case 2:
            _currentGameLevel = [[Level2 alloc] init];
            break;
        case 3:
            _currentGameLevel = [[Level3 alloc] init];
            break;
        default: _currentGameLevel = [[Level0 alloc] init];
            break;
    }

    [_currentGameLevel executeLevel:ingameLayer];
    
}

-(void)executeLevel:(InGameLayer *)ingameLayer
{
    
}

-(void)exitLevel:(InGameLayer *)ingameLayer
{
    
}


-(void)update:(ccTime)dt
{
    [_currentGameLevel update:dt];
}

@end
