//
//  ProductSender.h
//  AnimalRescue
//
//  Created by iMac on 5/5/13.
//
//

#import <Foundation/Foundation.h>

@interface ProductSender : NSObject

+(ProductSender *)sharedProductSenderInstance;

-(void)provideContentForProductIdentifier:(NSString *)productIdentifier;


@end
