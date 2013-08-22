//
//  SkillManager.h
//  AnimalRescue
//
//  Created by iMac on 4/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ActionSprite.h"
#import "InGameLayer.h"

@interface SkillManager : CCNode
{
    
}

-(void)managingSkills:(ActionSprite*)actionSprite;

-(void)executeSkill:(ActionSprite*)actionSprite;

-(void)updatePosition:(ActionSprite *)actionSprite;

@end
