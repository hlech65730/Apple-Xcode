//
//  xyzViewController.m
//  Stopwatch
//
//  Created by PZ on 03.02.14.
//  Copyright (c) 2014 PZ. All rights reserved.
//

#import "xyzViewController.h"

//Makro LSB MSB von unsigned int
#define LSB(x) ((x)&0xff)
#define MSB(x) ((x)>>8)

uint16_t x=0;

uint8_t counter = 0;
uint8_t crc[32];

uint16_t length;
uint8_t txd[32];


uint16_t result=0;
uint8_t tastendruck=0;


NSInteger counter_color = 0;

NSInteger flag_pressed = 0;



//----------------------------------------------
//CRC 16
//----------------------------------------------
uint16_t CRC16 (const uint8_t *nData, uint16_t wLength)
{
    static const uint16_t wCRCTable[] = {
        0X0000, 0XC0C1, 0XC181, 0X0140, 0XC301, 0X03C0, 0X0280, 0XC241,
        0XC601, 0X06C0, 0X0780, 0XC741, 0X0500, 0XC5C1, 0XC481, 0X0440,
        0XCC01, 0X0CC0, 0X0D80, 0XCD41, 0X0F00, 0XCFC1, 0XCE81, 0X0E40,
        0X0A00, 0XCAC1, 0XCB81, 0X0B40, 0XC901, 0X09C0, 0X0880, 0XC841,
        0XD801, 0X18C0, 0X1980, 0XD941, 0X1B00, 0XDBC1, 0XDA81, 0X1A40,
        0X1E00, 0XDEC1, 0XDF81, 0X1F40, 0XDD01, 0X1DC0, 0X1C80, 0XDC41,
        0X1400, 0XD4C1, 0XD581, 0X1540, 0XD701, 0X17C0, 0X1680, 0XD641,
        0XD201, 0X12C0, 0X1380, 0XD341, 0X1100, 0XD1C1, 0XD081, 0X1040,
        0XF001, 0X30C0, 0X3180, 0XF141, 0X3300, 0XF3C1, 0XF281, 0X3240,
        0X3600, 0XF6C1, 0XF781, 0X3740, 0XF501, 0X35C0, 0X3480, 0XF441,
        0X3C00, 0XFCC1, 0XFD81, 0X3D40, 0XFF01, 0X3FC0, 0X3E80, 0XFE41,
        0XFA01, 0X3AC0, 0X3B80, 0XFB41, 0X3900, 0XF9C1, 0XF881, 0X3840,
        0X2800, 0XE8C1, 0XE981, 0X2940, 0XEB01, 0X2BC0, 0X2A80, 0XEA41,
        0XEE01, 0X2EC0, 0X2F80, 0XEF41, 0X2D00, 0XEDC1, 0XEC81, 0X2C40,
        0XE401, 0X24C0, 0X2580, 0XE541, 0X2700, 0XE7C1, 0XE681, 0X2640,
        0X2200, 0XE2C1, 0XE381, 0X2340, 0XE101, 0X21C0, 0X2080, 0XE041,
        0XA001, 0X60C0, 0X6180, 0XA141, 0X6300, 0XA3C1, 0XA281, 0X6240,
        0X6600, 0XA6C1, 0XA781, 0X6740, 0XA501, 0X65C0, 0X6480, 0XA441,
        0X6C00, 0XACC1, 0XAD81, 0X6D40, 0XAF01, 0X6FC0, 0X6E80, 0XAE41,
        0XAA01, 0X6AC0, 0X6B80, 0XAB41, 0X6900, 0XA9C1, 0XA881, 0X6840,
        0X7800, 0XB8C1, 0XB981, 0X7940, 0XBB01, 0X7BC0, 0X7A80, 0XBA41,
        0XBE01, 0X7EC0, 0X7F80, 0XBF41, 0X7D00, 0XBDC1, 0XBC81, 0X7C40,
        0XB401, 0X74C0, 0X7580, 0XB541, 0X7700, 0XB7C1, 0XB681, 0X7640,
        0X7200, 0XB2C1, 0XB381, 0X7340, 0XB101, 0X71C0, 0X7080, 0XB041,
        0X5000, 0X90C1, 0X9181, 0X5140, 0X9301, 0X53C0, 0X5280, 0X9241,
        0X9601, 0X56C0, 0X5780, 0X9741, 0X5500, 0X95C1, 0X9481, 0X5440,
        0X9C01, 0X5CC0, 0X5D80, 0X9D41, 0X5F00, 0X9FC1, 0X9E81, 0X5E40,
        0X5A00, 0X9AC1, 0X9B81, 0X5B40, 0X9901, 0X59C0, 0X5880, 0X9841,
        0X8801, 0X48C0, 0X4980, 0X8941, 0X4B00, 0X8BC1, 0X8A81, 0X4A40,
        0X4E00, 0X8EC1, 0X8F81, 0X4F40, 0X8D01, 0X4DC0, 0X4C80, 0X8C41,
        0X4400, 0X84C1, 0X8581, 0X4540, 0X8701, 0X47C0, 0X4680, 0X8641,
        0X8201, 0X42C0, 0X4380, 0X8341, 0X4100, 0X81C1, 0X8081, 0X4040 };
    
    uint8_t nTemp;
    uint16_t wCRCWord = 0xFFFF;
    
    while (wLength--)
    {
        nTemp = *nData++ ^ wCRCWord;
        wCRCWord >>= 8;
        wCRCWord ^= wCRCTable[nTemp];
    }
    return wCRCWord;
    
}





@interface xyzViewController ()

@end

@implementation xyzViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initNetworkCommunication];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------------------------------------------
//Timer
//----------------------------------------------
- (void)updateTimer
{
    
    self.lblStopWatch.text = [NSString stringWithFormat:@"Counter: %i", counter++];

    counter_color++;
    if (counter_color>10) {
        self.lblStopWatch.backgroundColor = [UIColor redColor];
    }
    if (counter_color>20) {
        self.lblStopWatch.backgroundColor = [UIColor whiteColor];
        counter_color=0;
    }
    
    
//    for(x=0;x<32;x++){
//        txd[x]=0;
//    }
//    
//    //Telegramm
//    txd[0]=0x02; //STX
//    
//    txd[23]=0x02; //Adresse High
//    txd[24]=0x4b; //Adresse Mid
//    txd[25]=0x01; //Adresse Low
//    
//    result = CRC16 (txd, 29); //Checksumme berechnen und vergleichen
//    txd[29] = MSB(result); //CRC High
//    txd[30] = LSB(result); //CRC LOW
//    
//    txd[31] = 0x03; //ETX
//    
//    //uint8_t arr[] = {0x1, 0x2, 0xA, 0x4, 0xF};
//    NSData * data = [NSData dataWithBytes:txd length:32];
//    
//	[outputStream write:[data bytes] maxLength:[data length]];
    
}

- (IBAction)onStartPressed:(id)sender {
    
//    crc[0]=0x31;
//    crc[1]=0x32;
//    crc[2]=0x33;
//    crc[3]=0x34;
//    crc[4]=0x35;
//    crc[5]=0x36;
//    crc[6]=0x37;
//    crc[7]=0x38;
//    crc[8]=0x39;
//    
//    result = CRC16 (crc, 9);
//
//    self.lblCrc.text = [NSString stringWithFormat:@"CRC: %x", result];
    
    if (flag_pressed==0) {
        
        counter=0;
        // Create the stop watch timer that fires every 100 ms
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];

        flag_pressed=1;
    }
    
}


- (IBAction)onStopPressed:(id)sender {
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    
    flag_pressed=0;
}


- (IBAction)btnFunction1:(id)sender {
    tastendruck|= (1 << 7);
    self.lblErgebnis.text = [NSString stringWithFormat:@"%i", tastendruck];
}

- (IBAction)btnFunction1Up:(id)sender {
    tastendruck &= ~(1 << 7);
    self.lblErgebnis.text = [NSString stringWithFormat:@"%i", tastendruck];

}

- (IBAction)btnFunction2:(id)sender {

    tastendruck|= (1 << 6);
    self.lblErgebnis.text = [NSString stringWithFormat:@"%i", tastendruck];
}


- (IBAction)btnFunction2Up:(id)sender {
    tastendruck &= ~(1 << 6);
    self.lblErgebnis.text = [NSString stringWithFormat:@"%i", tastendruck];
}


//----------------------------------------------
//TXD
//----------------------------------------------
- (IBAction)btnFunction3:(id)sender {
    
    for(x=0;x<32;x++){
        txd[x]=0;
    }
    
    //Telegramm
    txd[0]=0x02; //STX
    
    txd[23]=0x02; //Adresse High
    txd[24]=0x4b; //Adresse Mid
    txd[25]=0x01; //Adresse Low
    
    result = CRC16 (txd, 29); //Checksumme berechnen und vergleichen
    txd[29] = MSB(result); //CRC High
    txd[30] = LSB(result); //CRC LOW
    
    txd[31] = 0x03; //ETX
    
    //uint8_t arr[] = {0x1, 0x2, 0xA, 0x4, 0xF};
    NSData * data = [NSData dataWithBytes:txd length:32];
    
	[outputStream write:[data bytes] maxLength:[data length]];
   
}

- (IBAction)btnIrgendwas:(id)sender {


}

//----------------------------------------------
//Socket Initialisierung
//----------------------------------------------
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.178.22", 2000, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}

//----------------------------------------------
//Event Handler RXD
//----------------------------------------------
//- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
//    enum {
//        NSStreamEventNone = 0,
//        NSStreamEventOpenCompleted = 1 << 0,
//        NSStreamEventHasBytesAvailable = 1 << 1,
//        NSStreamEventHasSpaceAvailable = 1 << 2,
//        NSStreamEventErrorOccurred = 1 << 3,
//        NSStreamEventEndEncountered = 1 << 4
//    };
//    uint8_t buffer[1024];
//    int len;
//    
//    switch (streamEvent) {
//            
//        case NSStreamEventOpenCompleted:
//            NSLog(@"Stream opened now");
//            break;
//        case NSStreamEventHasBytesAvailable:
//            NSLog(@"has bytes");
//            if (theStream == inputStream) {
//                while ([inputStream hasBytesAvailable]) {
//                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
//                    if (len > 0) {
//                        
//                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
//                        
//                        if (nil != output) {
//                            NSLog(@"server said: %@", output);
//                        }
//                    }
//                }
//            } else {
//                NSLog(@"it is NOT theStream == inputStream");
//            }
//            break;
//        case NSStreamEventHasSpaceAvailable:
//            NSLog(@"Stream has space available now");
//            break;
//            
//            
//        case NSStreamEventErrorOccurred:
//            NSLog(@"Can not connect to the host!");
//            break;
//            
//            
//        case NSStreamEventEndEncountered:
//            
//            [theStream close];
//            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//            
//            break;
//            
//        default:
//            NSLog(@"Unknown event %i", streamEvent);
//    }
//    
//}


@end
