//
//  YFAVUtil.m
//Created by apple on 17/07/21.
//

#import "YFAVUtil.h"
#import <AVFoundation/AVFoundation.h>

static NSMutableDictionary *_sounddict;

@implementation YFAVUtil


+(void)initialize{
    _sounddict = [[NSMutableDictionary alloc] init];
}


+(void)playAlertAudio:(NSURL  *)url{
    SystemSoundID soundid = [_sounddict[url.absoluteString] intValue];
//    [self pauseBackgroundSoundWithError:nil];
    
    if(!soundid){
        // unsupport audio longer than 30 secs
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundid);
        _sounddict[url.absoluteString]=@(soundid);
    }
    
    // with shake effect
    AudioServicesPlayAlertSoundWithCompletion(soundid, ^{
//        [self resumeBackgroundSoundWithError:nil];
    });
    
}
+(void)playSystemAudio:(NSURL  *)url{
    SystemSoundID soundid = [_sounddict[url.absoluteString] intValue];
//    [self pauseBackgroundSoundWithError:nil];
    
    if(!soundid){
        // unsupport audio longer than 30 secs
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundid);
        _sounddict[url.absoluteString]=@(soundid);
    }
    AudioServicesPlaySystemSoundWithCompletion(soundid, ^{
//        [self resumeBackgroundSoundWithError:nil];
    });
}
+(void)playAlertAudioOnce:(NSURL  *)url{
    SystemSoundID soundid = 0;
//    [self pauseBackgroundSoundWithError:nil];
    
    // unsupport audio longer than 30 secs
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundid);
    
    // with shake effect
    AudioServicesPlayAlertSoundWithCompletion(soundid, ^{
        AudioServicesDisposeSystemSoundID(soundid);
//        [self resumeBackgroundSoundWithError:nil];
        
    });
    
}
+(void)playSystemAudioOnce:(NSURL  *)url{
//    [self pauseBackgroundSoundWithError:nil];
    
    SystemSoundID soundid = 0;
    // unsupport audio longer than 30 secs
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundid);
    
    AudioServicesPlaySystemSoundWithCompletion(soundid,^{
        AudioServicesDisposeSystemSoundID(soundid);
//        [self resumeBackgroundSoundWithError:nil];
        
    });
    
}

/*
 * Resume the sound from background and deactivate current app audio session
 * @param error Failure message
 **/
+ (void)resumeBackgroundSoundWithError:(NSError **)error {
    //Deactivate audio session in current app
    //Activate audio session in others' app
    //See here https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioGuidelinesByAppType/AudioGuidelinesByAppType.html#//apple_ref/doc/uid/TP40007875-CH11-SW1
    
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:error];
}

/*
 * Pause the sound from the background and activate current app audio session
 * @param error Failure message
 **/
+ (void)pauseBackgroundSoundWithError:(NSError **)error {
    
    //See here https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/ConfiguringanAudioSession/ConfiguringanAudioSession.html#//apple_ref/doc/uid/TP40007875-CH2-SW1
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //Set AVAudioSessionCategoryPlayback category mode for current app
    [session setCategory:AVAudioSessionCategoryPlayback error:error];
    //Activate audio session in current app
    //Deactivate audio session in others' app
    [session setActive:YES error:error];
}

+ (void)pauseBackgroundSoundWithCategoryRecord {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    [session setActive:YES error:nil];
}








+(void)disposeAudios{
    for ( id sounid in [_sounddict allValues]){
        AudioServicesDisposeSystemSoundID([sounid intValue]);
    }
    
    [_sounddict removeAllObjects];
}

+ (void)Virbra {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}



@end
