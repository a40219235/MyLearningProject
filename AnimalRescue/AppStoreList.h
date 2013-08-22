//
//  AppStoreList.h
//  AnimalRescue
//
//  Created by iMac on 5/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface AppStoreList : CCLayer {
    
}
@property (nonatomic, assign) CGSize winSize;

+(AppStoreList *)sharedAppStoreListLayer;

-(void)refreshingCell;

@property (nonatomic, strong) NSArray *productsArray;
@property (nonatomic, strong) NSMutableDictionary *productsMuDic;

@end
