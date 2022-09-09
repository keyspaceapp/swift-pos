#import "POS.h"
#import "verifier.hpp"

@implementation POS

+ (NSData *)validate_proof:(NSData *)proof_id k:(UInt8)k challenge:(NSData *)challenge proof:(NSData *)proof_bytes {
    const uint8_t *seed_ptr = (uint8_t *)proof_id.bytes;
    const uint8_t *challenge_ptr = (uint8_t *)challenge.bytes;
    const uint8_t *proof_ptr = (uint8_t *)proof_bytes.bytes;
    LargeBits quality = Verifier().ValidateProof(seed_ptr, k, challenge_ptr, proof_ptr, proof_bytes.length);
    
    if (quality.GetSize() == 0) {
        return [[NSData alloc] init];
    }
    
    uint8_t *quality_buf = new uint8_t[32];
    quality.ToBytes(quality_buf);
    return [NSData dataWithBytes:quality_buf length:32];
}

@end
