//
//  ViewController.h
//  BeerList
//
//  Created by Masih Tabrizi on 2/4/15.
//  Copyright (c) 2015 Masih. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

    <UITableViewDataSource, UITableViewDelegate,
    NSXMLParserDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end

