//
//  IAPProduct.m
//  AnimalRescue
//
//  Created by iMac on 5/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "IAPProduct.h"


@implementation IAPProduct

-(id)initWithProductIdentifier:(NSString *)productIdentifier
{
    if ((self = [super init]))
    {
        self.availableForPurchase = NO;
        self.productIdentifier = productIdentifier;
        self.skProduct = nil;
    }
    return self;
}

-(BOOL)allowdToPurchase
{
    if (!self.availableForPurchase)
    {
        return NO;
    }
    if (self.purchaseInProgress)
    {
        return NO;
    }
    if (self.purchased && self.installed)
    {
        return NO;
    }
    return YES;
}


@end
