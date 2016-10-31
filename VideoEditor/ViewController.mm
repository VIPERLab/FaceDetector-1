//
//  ViewController.m
//  VideoEditor
//
//  Created by Anuj Shah on 9/16/16.
//  Copyright © 2016 Anuj Shah. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif
#import "ViewController.h"
#import <opencv2/highgui/ios.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface ViewController (){
    
}
//using the CvVideoCamera class of opencv to work with videos
@property (nonatomic, retain) CvVideoCamera* videoCamera;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //using the  CVVideoCamera class of opnecv framework to use the AVFoundation for camera
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:_videoLayout];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)capture:(UIButton *)sender
{
    //start the video camera using opencv
   [self.videoCamera start];
}

- (void)processImage:(cv::Mat&)image;
{
    //providing the haar cascade file to detect faces
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt2"
                             ofType:@"xml"];
    faceDetector.load([cascadePath UTF8String]);
    
    // Convert to grayscale
    cv::Mat gray;
    cvtColor(image, gray, CV_BGR2GRAY);
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(image, tl, br, magenta, 4, 8, 0);
    }
    
    // Show resulting image
    _videoLayout.image = MatToUIImage(image);
    
}


@end
