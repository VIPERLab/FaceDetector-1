//
//  ViewController.h
//  VideoEditor
//
//  Created by Anuj Shah on 9/16/16.
//  Copyright © 2016 Anuj Shah. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "opencv2/highgui/ios.h"

@interface ViewController : UIViewController <CvVideoCameraDelegate>{

    CvVideoCamera* videoCamera;
    
    //cascade for face detector
    cv::CascadeClassifier faceDetector;
    }

@property (strong, nonatomic) IBOutlet UIImageView *videoLayout;


- (IBAction)capture:(UIButton *)sender;

@end

