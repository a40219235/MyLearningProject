//
//  PaymentHandler.h
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import <Foundation/Foundation.h>
#import "IAPProduct.h"

@interface PaymentHandler : NSObject

+(PaymentHandler *)sharedPaymentHandlerInstance;

-(void)buyProduct:(IAPProduct *)iapProduct;

-(void)restoreCompletedTransactions;

@end
