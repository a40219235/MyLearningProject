//
//  UpgradeLayer.m
//  AnimalRescue
//
//  Created by iMac on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "UpgradeLayer.h"
#import "SceneManager.h"
#import "Hero1Upgrade.h"
#import "Hero2Upgrade.h"
#import "CCScrollLayer.h"


@implementation UpgradeLayer
{
}

-(id)init
{
    if ((self = [super init]))
    {
        NSMutableArray *layers = [[NSMutableArray alloc] init];
        
        CCLayer *hero1Upgrade = [[Hero1Upgrade alloc] init];
        CCLayer *hero2Upgrade = [[Hero2Upgrade alloc] init];
        
        [layers addObject:hero1Upgrade];
        [layers addObject:hero2Upgrade];
        
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:layers widthOffset:0];
        
        scroller.minimumTouchLengthToChangePage = 25;
        scroller.marginOffset = 150;
        
        [self addChild:scroller];
    }
    return self;
}

@end
