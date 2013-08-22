//
//  OptionMenu.m
//  AnimalRescue
//
//  Created by iMac on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "OptionMenu.h"
#import "SceneManager.h"


@implementation OptionMenu

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        int largeFont = screenSize.height/ 9;
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:largeFont];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Options Menu"
                                               fontName:@"Marker Felt"
                                               fontSize:largeFont];
		// Center label
		label.position = ccp( screenSize.width/2, screenSize.height/2);
        
        // Add label to this scene
		[self addChild:label z:0];
        
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        item2.position = ccp(32, 32);
        
        CCMenu *menu = [CCMenu menuWithItems: item2, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}

-(void)onBack:(id)sender
{
    [SceneManager goMainMenu];
}

@end
