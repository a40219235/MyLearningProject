//
//  MidiumMonster.h
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"

@interface MidiumMonster : ActionSprite {
    
}

-(id)initWithTeam:(BOOL)isAlly layer:(InGameLayer *)layer actionSprite:(ActionSprite *)actionSprite;
@end
