//
//  MainHeroInitManager.h
//  AnimalRescue
//
//  Created by iMac on 4/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ActionSprite.h"
#import "InGameLayer.h"

@interface MainHeroInitManager : ActionSprite {
    
}

-(ActionSprite *)MainHeroChooser:(int)HeroChooser IngameLayer:(InGameLayer*)ingameLayer;

@end
