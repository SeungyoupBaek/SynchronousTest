//
//  ViewController.m
//  SynchronousTest
//
//  Created by SDT-1 on 2014. 1. 15..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_URL @"http://upload.wikimedia.org/wikipedia/commons/4/4d/Klimt_-_Der_Kuss.jpeg"
@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController{
    NSMutableData *buffer;
}
- (IBAction)asyncCall:(id)sender {
    self.imageView.image = nil;
    NSLog(@"START IMAGE DOWNLOAD REQUEST");
    
    NSURL *url = [NSURL URLWithString:IMAGE_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSLog(@"FINISHED IMAGE DOWNLOAD REQUEST");
}

// Response를 받으면 버퍼를 초기화
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    buffer = [[NSMutableData alloc] init];
}

// 데이터 패킷을 버퍼에 축적
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"RECEIVING : %d", data.length);
    [buffer appendData:data];
}

// 데이터 전송 완료
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.imageView.image = [UIImage imageWithData:buffer];
    NSLog(@"FINISHED IMAGE DOWNLOAD");
}

// 에러 발생
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"ERROR : %@", [error localizedDescription]);
}

- (IBAction)syncCall:(id)sender {
    self.imageView.image = nil;
    NSLog(@"STARTING IMAGE DOWNLOAD");
    NSURL *url = [NSURL URLWithString:IMAGE_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imageView.image = [UIImage imageWithData:data];
    NSLog(@"FINISHED IMAGE DOWNLOAD");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
