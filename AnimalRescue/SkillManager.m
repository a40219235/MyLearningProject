//
//  SkillManager.m
//  AnimalRescue
//
//  Created by iMac on 4/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SkillManager.h"
#import "TwoCloneShooter.h"
#import "TwoCloneShooter2.h"
#import "SideSpreadingSkill.h"
#import "SideSpreadingSkill2.h"
#import "DefenseWallSkill.h"
#import "FireAbility.h"
#import "FreezingAbility.h"
#import "Grenade.h"
#import "ReflectingBullet.h"
#import "Boomerang.h"
#import "Boomerang2.h"
#import "BoomerangUltimate.h"



@implementation SkillManager
{
    SkillManager *_skillManager;
}

-(void)managingSkills:(ActionSprite *)actionSprite
{
    switch ([AppController sharedAppController].skillType)
    {
        case kSkillTwoCloneShooter1:
            _skillManager = [[TwoCloneShooter alloc] init];
            break;
            
        case kSkillTwoCloneShooter2:
            _skillManager = [[TwoCloneShooter2 alloc] init];
            break;
            
        case kSkillSideSpreading1:
            _skillManager = [[SideSpreadingSkill alloc] init];
            break;
            
        case kSkillSideSpreading2:
            _skillManager = [[SideSpreadingSkill2 alloc] init];
            break;
            
        case kSkillDefenseWall1:
            _skillManager = [[DefenseWallSkill1 alloc] init];
            break;
            
        case kSkillDefenseWall2:
            _skillManager = [[DefenseWallSkill2 alloc] init];
            break;
            
        case kSkillFireAbility:
            _skillManager = [[FireAbility alloc] init];
            break;
        
        case kSkillFreezingAbility:
            _skillManager = [[FreezingAbility alloc] init];
            break;
            
        case kSkillGrenade:
            _skillManager = [[Grenade alloc] init];
            break;
        case kSkillReflectingBullet:
            _skillManager = [[ReflectingBullet alloc] init];
            break;
            
        case kSkillBoomerang:
            _skillManager = [[Boomerang alloc] init];
            break;
        
        case kSkillBoomerang2:
            _skillManager = [[Boomerang2 alloc] init];
            break;
            
        case KSkillBoomerangUltimate:
            _skillManager = [[BoomerangUltimate alloc] init];
            break;
            
        default: return;
            break;
    }
    
    [_skillManager executeSkill:actionSprite];
}

-(void)updatePosition:(ActionSprite *)actionSprite
{
    
}

-(void)executeSkill:(ActionSprite *)actionSprite
{
    
}


@end
