//
//  NSView_Hello.m
//  Hello
//
//  Created by Holger Lech on 28.10.12.
//  Copyright (c) 2012 Dipl.Ing.(FH) Holger Lech. All rights reserved.
//

#import "NSView_Hello.h"

@implementation NSView_Hello

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if(self){
        // Initialization code here
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
// drawing code here
    NSString *hello = @"Hallo ihr Luschen!";
    NSPoint point = NSMakePoint(15,75);
    NSMutableDictionary *font_attributes = [[NSMutableDictionary alloc] init];
    NSFont *font = [NSFont fontWithName:@"Futura-MediumItalic" size:36];
    [font_attributes setObject:font forKey:NSFontAttributeName];
    [hello drawAtPoint:point withAttributes:font_attributes];
    [font_attributes release];
    
}

@end
