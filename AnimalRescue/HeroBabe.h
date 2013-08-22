//
//  HeroBabe.h
//  AnimalRescue
//
//  Created by iMac on 4/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"

@interface HeroBabe : ActionSprite {
    
}

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer*)layer;

@end
