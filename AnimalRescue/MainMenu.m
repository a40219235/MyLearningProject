//
//  MainMenu.m
//  AnimalRescue
//
//  Created by iMac on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "InGameLayer.h"


@implementation MainMenu

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        int LargeFont = screenSize.height / 9;
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:LargeFont];
        
        CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(onPlay:)];
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Options" target:self selector:@selector(onOptions:)];
        CCMenuItemFont *appStoreList = [CCMenuItemFont itemWithString:@"AppStoreList" target:self selector:@selector(AppStoreList:)];
        
        CCMenu *menu = [CCMenu menuWithItems:item1, item2, appStoreList, nil];
        [menu alignItemsVertically];
        [self addChild:menu];
    }
    return self;
}

- (void)onPlay: (id) sender
{
    [SceneManager goChapterSelect];
}

-(void)onOptions: (id)sender
{
    [SceneManager goOptionMenu];
}

-(void)AppStoreList:(id)sender
{
    [SceneManager goAppStoreList];
}

@end
