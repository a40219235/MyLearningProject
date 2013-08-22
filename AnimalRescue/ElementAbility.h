//
//  ElementAbility.h
//  AnimalRescue
//
//  Created by iMac on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"
#import "InGameLayer.h"

@interface ElementAbility : CCNode {
    
}

-(void)enter:(ActionSprite *)actionSprite;
-(void)execute:(ActionSprite *)actionSprite;
-(void)exit:(ActionSprite *)actionSprite;

@end
