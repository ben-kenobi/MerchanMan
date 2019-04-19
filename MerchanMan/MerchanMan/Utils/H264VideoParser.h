
#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

@interface VideoPacket : NSObject

@property uint8_t* buffer;
@property NSInteger size;
-(instancetype)initWithSize:(NSInteger)size;
@end

@interface H264VideoParser : NSObject
@property(nonatomic,assign)BOOL stop;
@property(nonatomic,assign)BOOL pause;

+(instancetype)parseFile:(NSString *)path cb:(void(^)(CVPixelBufferRef))decodeCB;
+(CVPixelBufferRef)parseData:(NSData *)data ;
+(CVPixelBufferRef)parseFile:(NSString *)path ;

@end
