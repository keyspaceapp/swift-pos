#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface POS : NSObject

+ (NSData *)validate_proof:(NSData *)proof_id
                         k:(UInt8)k
                 challenge:(NSData *)challenge
                     proof:(NSData *)proof_bytes;

@end

NS_ASSUME_NONNULL_END
