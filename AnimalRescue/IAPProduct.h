//
//  IAPProduct.h
//  AnimalRescue
//
//  Created by iMac on 5/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class SKProduct;
@interface IAPProduct : CCNode

-(id)initWithProductIdentifier:(NSString *)productIdentifier;
-(BOOL)allowdToPurchase;

@property (nonatomic, assign) BOOL availableForPurchase;
@property (nonatomic, strong) NSString *productIdentifier;
@property (nonatomic, strong) SKProduct *skProduct;
@property (nonatomic, assign) BOOL purchaseInProgress;
@property (nonatomic, assign) BOOL purchased;
@property (nonatomic, assign) BOOL installed;

@end
