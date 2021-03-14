//
//  xyzViewController.h
//  Stopwatch
//
//  Created by PZ on 03.02.14.
//  Copyright (c) 2014 PZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//----------------------------------------------
//Socket
//----------------------------------------------

NSInputStream *inputStream;
NSOutputStream *outputStream;


//@interface xyzViewController : UIViewController
@interface xyzViewController : UIViewController <NSStreamDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblStopWatch;
@property (weak, nonatomic) IBOutlet UILabel *lblIrgendwas;

@property (weak, nonatomic) IBOutlet UILabel *lblCrc;
- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;


- (IBAction)btnFunction1:(id)sender;
- (IBAction)btnFunction1Up:(id)sender;

- (IBAction)btnFunction2:(id)sender;
- (IBAction)btnFunction3:(id)sender;
- (IBAction)btnIrgendwas:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblErgebnis;

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time




@end
