//
//  InitMenuManager.h
//  AnimalRescue
//
//  Created by iMac on 4/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "InGameLayer.h"
#import "ActionSprite.h"

@interface InitMenuManager : CCNode
{
    
}

-(CCProgressTimer *)TimerSelector:(int)timerSelector;

-(CCMenuItemSprite *)MenuSelector:(int)menuSelector ActionSprite:(ActionSprite *)actionSprite;

@end
