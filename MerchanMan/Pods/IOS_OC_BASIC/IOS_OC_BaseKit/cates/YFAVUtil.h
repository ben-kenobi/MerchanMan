//
//  AVUtil.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>
@interface YFAVUtil : NSObject

+(void)playAlertAudio:(NSURL  *)url;
+(void)playSystemAudio:(NSURL  *)url;
+(void)playAlertAudioOnce:(NSURL  *)url;//播发音频，不缓存
+(void)playSystemAudioOnce:(NSURL  *)url;//播发音频，不缓存

/*
 * Resume the sound from background and deactivate current app audio session
 * @param error Failure message
 **/
+ (void)resumeBackgroundSoundWithError:(NSError **)error ;

/*
 * Pause the sound from the background and activate current app audio session
 * @param error Failure message
 **/
+ (void)pauseBackgroundSoundWithError:(NSError **)error;

+ (void)pauseBackgroundSoundWithCategoryRecord ;


+ (void)Virbra ;
@end
