//
//  JsonPlaceTableViewController.m
//  JsonPlaceHolderURL
//
//  Created by Student-004 on 10/11/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import "JsonPlaceTableViewController.h"
#import "Json.h"
#import "CustomTableViewCell.h"

@interface JsonPlaceTableViewController ()

@end

@implementation JsonPlaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array=[[NSMutableArray alloc]init];
    
    NSString *str=@"http://jsonplaceholder.typicode.com/posts/1/comments";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                
    {
        NSLog(@"%@",response);
                                    
        NSArray *outerarr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                    
        for(NSDictionary *temp in outerarr)
        {
            NSString *str1=[[temp objectForKey:@"postId"]description];
            NSString *str2=[[temp objectForKey:@"id"]description];
            NSString *str3=[temp objectForKey:@"name"];
            NSString *str4=[temp objectForKey:@"email"];
            NSString *str5= [temp objectForKey:@"body"];
            
             Json *j1=[[Json alloc]init];
            
            j1.jpostid=str1;
            j1.jid=str2;
            j1.jname=str3;
            j1.jemail=str4;
            j1.jbody=str5;
            
            [_array addObject:j1];
           
        }
                                    
    [self.tableView reloadData ];
                                    
    }];
    
    [task resume];
    
  [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Json *jtemp=[_array objectAtIndex:indexPath.row];
    
    cell.lbl1.text=jtemp.jpostid;
    
    cell.lbl2.text=jtemp.jid;
    
    cell.lbl3.text=jtemp.jname;
    cell.lbl3.numberOfLines=3;
    
    cell.lbl4.text=jtemp.jemail;
    cell.lbl4.numberOfLines=1;
    
    cell.lbl5.text=jtemp.jbody;
    cell.lbl5.numberOfLines=5;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
