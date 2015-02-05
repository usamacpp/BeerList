//
//  ViewController.m
//  BeerList
//
//  Created by Masih Tabrizi on 2/4/15.
//  Copyright (c) 2015 Masih. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    
    NSMutableDictionary *BeerList;
    NSMutableData *responseData;
    NSMutableString *currentElement;
    NSMutableArray *list;
    int i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [[NSMutableArray alloc]init];
    BeerList = [[NSMutableDictionary alloc]init];

    [self datadidload];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)datadidload {
    
    // load data from web service
    //
    NSString *envelopeText =
    @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
    "<soap12:Body>\n"
    "<getBeerList xmlns=\"http://tempuri.org/\" />\n"
    "</soap12:Body>\n"
    "</soap12:Envelope>";
    
    NSData *envelopeData = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *URL =@"http://softwaremerchant.com/onlinecourse.asmx";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelopeData];
    [request setValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%li", [envelopeData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
        responseData = [NSMutableData data];
    else
        NSLog(@"[NSURLConnction connectionWithRequest: delegate: ] failed to return a connection.");
    
}


#pragma mark - URL Connection Method

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed with error: %@ %@",
          [error localizedDescription], [error.userInfo objectForKey:NSURLErrorFailingURLErrorKey]);
}

#pragma mark - URL Connection Data Method

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSXMLParser *nsXmlparser = [[NSXMLParser alloc] initWithData:responseData];
    [nsXmlparser setDelegate:self];
    [nsXmlparser parse];
    NSString *responseDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
//    NSLog(@"%@", responseDataString);
    }

#pragma mark - XML Parser Method

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
   // NSLog(@"%@", currentElement);
    
    if ([elementName isEqualToString:@"beer_name"]) {
        [list addObject:currentElement];
        
    }
    
    if ([elementName isEqualToString:@"beer_location"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_ABV"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_size"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_price"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_description"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_category_name"]) {
        [list addObject:currentElement];
    }
    
    if ([elementName isEqualToString:@"beer_date_added"]) {
        [list addObject:currentElement];
    }
    
    
    
    
    
    
    
    

//    if ([elementName isEqualToString:@"beer_category_name"]) {

//        [list addObject:currentElement];
//        NSLog(@"%@", currentElement);
//        if ([BeerList objectForKey:currentElement] == nil) {
//            NSLog(@"%@",currentElement);
//            [BeerList setValue:@"obj"  forKey:currentElement];
//        } else {
//
//        }
//
//
//    }
    
    
//    for (NSString * obj in list) {
//        NSLog(@"Array = %@",obj);
//    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    currentElement = [NSMutableString string];

    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [currentElement appendString:string];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [list count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = list[indexPath.row];

    
    for (NSString * obj in list) {
        NSLog(@"Array = %@",obj);
    }
    
    return cell;
}




@end
