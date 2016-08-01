//
//  KeychainWrapper.h
//  RTApiProxy
//
//  Created by liu lh on 13-6-24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LDUDIDGenerator : NSObject

+ (id)sharedInstance;

- (NSString *)UDID;
- (void)saveUDID:(NSString *)udid;

@end
