

/***
 progressed
 */

#import "H264VideoParser.h"
#import <VideoToolbox/VideoToolbox.h>
#import "YFCate.h"


const uint8_t KStartCode[4]={0,0,0,1};
const uint8_t KStartCode2[3]={0,0,1};

static void didDecompress(void *decompressionOutputRefCon,void *sourceFrameRefCon,OSStatus status,VTDecodeInfoFlags infoFlags,
                          CVImageBufferRef pixelBuffer,CMTime presentationTimeStamp,CMTime presentationDuration){
    CVPixelBufferRef *outputPixelBuffer = (CVPixelBufferRef *)sourceFrameRefCon;
    *outputPixelBuffer=CVPixelBufferRetain(pixelBuffer);
}


@implementation VideoPacket

-(instancetype)initWithSize:(NSInteger)size{
    if(self=[super init]){
        self.buffer=malloc(size);
        self.size = size;
    }
    return self;
    
}
-(void)dealloc{
    free(self.buffer);
}

@end

@interface H264VideoParser()
{
    uint8_t *_buffer;
    NSInteger _bufferSize;
    NSInteger _bufferCap;
    
    
    
    //-------DecodePart
    uint8_t *_sps;
    NSInteger _spsSize;
    uint8_t *_pps;
    NSInteger _ppsSize;
    VTDecompressionSessionRef _decoderSession;
    CMVideoFormatDescriptionRef _decodeFormatDescription;
    
}


@property (nonatomic,copy)NSString *fileName;
@property (nonatomic,strong)NSInputStream *fileStream;
@property (nonatomic,copy)void (^decodeCB)(CVPixelBufferRef);

@end


@implementation H264VideoParser

+(instancetype)parseFile:(NSString *)path cb:(void(^)(CVPixelBufferRef))decodeCB{
    H264VideoParser *parser =   [[self alloc]initWithFile:path];
    parser.decodeCB=decodeCB;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [parser startDecode];
    });
    return parser;
}

-(void)setStop:(BOOL)stop{
    _stop=stop;
    if(_stop)
        [self close];
}
-(void)setPause:(BOOL)pause{
    _pause=pause;
    if(!_pause){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self startDecode];
        });
    }
}

+(CVPixelBufferRef)parseFile:(NSString *)path {
    H264VideoParser *parser =  [[self alloc] initWithFile:path];
    CVPixelBufferRef pr = [parser decodeIDR];
    [parser close];
    return pr;
}

+(CVPixelBufferRef)parseData:(NSData *)data {
    H264VideoParser *parser =  [[self alloc] initWithData:data];
    CVPixelBufferRef pr = [parser decodeIDR];
    [parser close];
    return pr;
}

-(instancetype)init{
    if(self=[super init]){
        _bufferSize=0;
        _bufferCap=1080 * 1920;
        _buffer=malloc(_bufferCap);
    }
    return self;
}
-(instancetype)initWithFile:(NSString *)fileName{
    if(self=[self init]){
        self.fileName=fileName;
        self.fileStream=[NSInputStream inputStreamWithFileAtPath:fileName];
        
        [self.fileStream open];
    }
    return self;
}
-(instancetype)initWithData:(NSData *)data{
    if(self=[self init]){
        self.fileStream=[NSInputStream inputStreamWithData:data];
        
        [self.fileStream open];
    }
    return self;
}


-(VideoPacket*)nextPacket{
    if(_bufferSize<_bufferCap && self.fileStream.hasBytesAvailable){
        NSInteger readBytes=[self.fileStream read:_buffer+_bufferSize maxLength:_bufferCap-_bufferSize];
        _bufferSize+=readBytes;
    }
    for(int i=0;i<10;i++){
        printf("%d\n",_buffer[i]);
    }
    if(memcmp(_buffer, KStartCode, 4 )!=0){
        return nil;
    }
    if(_bufferSize>=5){
        uint8_t *bufferBegin = _buffer +4;
        uint8_t *bufferEnd = _buffer + _bufferSize;
        while(bufferBegin!=bufferEnd)
        {
//            printf("%d=",*bufferBegin);
            if(*bufferBegin==0x01){
                if((memcmp(bufferBegin-3,KStartCode,4)==0)){
                    NSInteger packetSize = bufferBegin-_buffer-3;
                    VideoPacket *vp = [[VideoPacket alloc]initWithSize:packetSize];
                    memcpy(vp.buffer, _buffer, packetSize);
                    memmove(_buffer, _buffer+packetSize, _bufferSize-packetSize);
                    _bufferSize-=packetSize;
                    return vp;
                }
            }
            ++bufferBegin;
        }
    }
    
    if(_bufferSize==0){
        return nil;
    }
    NSInteger packetSize = _bufferSize;
    VideoPacket *vp = [[VideoPacket alloc]initWithSize:packetSize];
    memcpy(vp.buffer, _buffer, packetSize);
    _bufferSize=0;
    return vp;
}





-(VideoPacket*)onePacket{
    if(self.fileStream.hasBytesAvailable){
        NSInteger readBytes=[self.fileStream read:_buffer maxLength:_bufferCap];
        _bufferSize=readBytes;
    }
//    int i;
//    for( i=0;i<50;i++){
//        printf("%x\n",_buffer[i]);
//    }
//    printf("%ld\n=========================",_bufferSize);
//    for( i=_bufferSize-1;i>_bufferSize-50;i--){
//        printf("%x\n",_buffer[i]);
//
//    }
//    
    VideoPacket  *vp = [[VideoPacket alloc] initWithSize:_bufferSize+5];
    memcpy(vp.buffer+5, _buffer, _bufferSize);
    uint8_t header[5] = {0,0,0,1,0x65};
    for(int i=0;i<5;i++){
        *(vp.buffer+i)=header[i];
    }
    
        int i;
        for( i=0;i<10;i++){
            printf("%x\n",vp.buffer[i]);
        }
    return vp;
    
//    VideoPacket  *vp = [[VideoPacket alloc] initWithSize:_bufferSize];
//    memcpy(vp.buffer, _buffer, _bufferSize);
// 
//    int i;
//    for( i=0;i<10;i++){
//        printf("%x\n",vp.buffer[i]);
//    }
//    return vp;
    
//    VideoPacket  *vp = [[VideoPacket alloc] initWithSize:_bufferSize+4];
//    memcpy(vp.buffer+4, _buffer, _bufferSize);
//    uint8_t header[4] = {0,0,0,1};
//    for(int i=0;i<4;i++){
//        *(vp.buffer+i)=header[i];
//    }
//    
//    int i;
//    for( i=0;i<10;i++){
//        printf("%x\n",vp.buffer[i]);
//    }
//    return vp;
    
}
-(void)close{
    free(_buffer);
    [self.fileStream close];
    [self clearH264Decoder];
    self.decodeCB = nil;
}









#pragma mark -- decodePart



-(BOOL)initH264Decoder{
    if(_decoderSession){
        return YES;
    }
    const uint8_t* const parameterSetPointers[2]={_sps,_pps};
    const size_t parameterSetSizes[2]={_spsSize,_ppsSize};
    
    OSStatus status = CMVideoFormatDescriptionCreateFromH264ParameterSets(kCFAllocatorDefault, 2, parameterSetPointers, parameterSetSizes, 4, &_decodeFormatDescription);
    if(status ==noErr){
        CFDictionaryRef attrs = NULL;
        const void *keys[]={kCVPixelBufferPixelFormatTypeKey};
        //      kCVPixelFormatType_420YpCbCr8Planar is YUV420
        //      kCVPixelFormatType_420YpCbCr8BiPlanarFullRange is NV12
        uint32_t v = kCVPixelFormatType_420YpCbCr8BiPlanarFullRange;
        const void *values[]={CFNumberCreate(NULL,kCFNumberSInt32Type,&v)};
        attrs = CFDictionaryCreate(NULL,keys,values,1,NULL,NULL);
        VTDecompressionOutputCallbackRecord callBackRecord;
        callBackRecord.decompressionOutputCallback=didDecompress;
        callBackRecord.decompressionOutputRefCon=NULL;
        status = VTDecompressionSessionCreate(kCFAllocatorDefault,
                                              _decodeFormatDescription,NULL,attrs,&callBackRecord,&_decoderSession);
        CFRelease(attrs);
    }else{
        NSLog(@"IOS8VT: reset decoder session failed status=%d", status);
    }
    return YES;
}


-(void)clearH264Decoder{
    if(_decoderSession){
        VTDecompressionSessionInvalidate(_decoderSession);
        CFRelease(_decoderSession);
        _decoderSession=0;
    }
    if(_decodeFormatDescription){
        CFRelease(_decodeFormatDescription);
        _decodeFormatDescription=0;
    }
    free(_sps);
    free(_pps);
    _spsSize=_ppsSize=0;
}


-(CVPixelBufferRef)decode:(VideoPacket *)vp{
    CVPixelBufferRef outputPixelBuffer = NULL;
    CMBlockBufferRef blockBuffer = NULL;
    OSStatus status  = CMBlockBufferCreateWithMemoryBlock(kCFAllocatorDefault, (void*)vp.buffer, vp.size, kCFAllocatorNull, NULL, 0, vp.size, 0, &blockBuffer);
    if(status==kCMBlockBufferNoErr){
        CMSampleBufferRef sampleBuffer = NULL;
        const size_t sampleSizeArray[]={vp.size};
        status = CMSampleBufferCreateReady(kCFAllocatorDefault, blockBuffer, _decodeFormatDescription, 1, 0, NULL, 1, sampleSizeArray, &sampleBuffer);
        if(status == kCMBlockBufferNoErr && sampleBuffer){
            VTDecodeFrameFlags flags = 0;
            VTDecodeInfoFlags flagOut = 0;
            OSStatus decodeStatus = VTDecompressionSessionDecodeFrame(_decoderSession, sampleBuffer, flags, &outputPixelBuffer, &flagOut);
            if(decodeStatus == kVTInvalidSessionErr){
                NSLog(@"IOS8VT: Invalid session, reset decoder session");
                
            }else if(decodeStatus == kVTVideoDecoderBadDataErr){
                NSLog(@"IOS8VT: decode failed status=%d(Bad data)", decodeStatus);
                
            }else if(decodeStatus!=noErr){
                NSLog(@"IOS8VT: decode failed status=%d ", decodeStatus);
                
            }
            CFRelease(sampleBuffer);
        }
        CFRelease(blockBuffer);
        
    }
    return outputPixelBuffer;
}

-(void)printData:(void *)data size:(int)size{
    for(int i=0;i<size;i++)
        printf("%d ",(*(int*)(data+i))&0x1f);
}
-(void)startDecode{
    
    VideoPacket *vp = nil;
    while(!_stop&&!_pause){
        vp=[self nextPacket];
        if(vp==nil){
            if(self.decodeCB)
                self.decodeCB(nil);
            self.stop=YES;
            break;
        }
        
        uint32_t nalSize = (uint32_t)(vp.size-4);
        uint8_t *pNalSize = (uint8_t*)(&nalSize);
        vp.buffer[0]=*(pNalSize+3);
        vp.buffer[1]=*(pNalSize+2);
        vp.buffer[2]=*(pNalSize+1);
        vp.buffer[3]=*(pNalSize);
        CVPixelBufferRef pixelBuffer = NULL;
        int nalType = vp.buffer[4]&0x1F;
        printf("\n=============%d-----%d---------\n",*pNalSize,nalType);
        switch(nalType){
            case 0x05:{
                NSLog(@"Nal type is IDR frame");
                if([self initH264Decoder]){
                    pixelBuffer = [self decode:vp];
                }
            }
                break;
            case 0x07:{
                NSLog(@"Nal type is SPS");
                _spsSize=vp.size-4;
                _sps=malloc(_spsSize);
                memcpy(_sps,vp.buffer+4, _spsSize);
            }
                break;
            case 0x08:{
                NSLog(@"Nal type is PPS");
                _ppsSize=vp.size-4;
                _pps=malloc(_ppsSize);
                memcpy(_pps, vp.buffer+4, _ppsSize);
            }
                break;
            default:{
                NSLog(@"Nal type is B/P frame");
                pixelBuffer=[self decode:vp];
                
            }
                break;
                
        }
        
        if(pixelBuffer){
            if(self.decodeCB)
                self.decodeCB(pixelBuffer);
            CVPixelBufferRelease(pixelBuffer);
        }
        NSLog(@"Read Nal size %ld",vp.size);
    }
    
}



-(CVPixelBufferRef)decodeIDR{
    
    VideoPacket *vp = nil;
    while(true){
        vp=[self nextPacket];
        if(vp==nil){
            break;
        }
        
        uint32_t nalSize = (uint32_t)(vp.size-4);
        uint8_t *pNalSize = (uint8_t*)(&nalSize);
        vp.buffer[0]=*(pNalSize+3);
        vp.buffer[1]=*(pNalSize+2);
        vp.buffer[2]=*(pNalSize+1);
        vp.buffer[3]=*(pNalSize);
        CVPixelBufferRef pixelBuffer = NULL;
        int nalType = vp.buffer[4]&0x1F;
        printf("\n=============%d--------------\n",nalType);
        switch(nalType){
            case 0x05:{
                NSLog(@"Nal type is IDR frame");
                if([self initH264Decoder]){
                    pixelBuffer = [self decode:vp];
                    return pixelBuffer;
                }
            }
                break;
            case 0x07:{
                NSLog(@"Nal type is SPS");
                _spsSize=vp.size-4;
                _sps=malloc(_spsSize);
                memcpy(_sps,vp.buffer+4, _spsSize);
            }
                break;
            case 0x08:{
                NSLog(@"Nal type is PPS");
                _ppsSize=vp.size-4;
                _pps=malloc(_ppsSize);
                memcpy(_pps, vp.buffer+4, _ppsSize);
            }
                break;
            default:{
                NSLog(@"Nal type is B/P frame");
                pixelBuffer=[self decode:vp];
            }
                break;
                
        }
        
        if(pixelBuffer){
            CVPixelBufferRelease(pixelBuffer);
        }
        NSLog(@"Read Nal size %ld",vp.size);
    }
    return nil;
}

@end
