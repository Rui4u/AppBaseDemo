//
//  QuestionViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/9/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionBussiness.h"
#import "QuestionModel.h"
#import "QuestionDetailViewController.h"
@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
/**
 <#Description#>
 */
@property (nonatomic ,strong) QuestionModel * model
;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView reloadData];
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"客户服务"];
    
    [QuestionBussiness requestQuestionWithToken:TOKEN completionSuccessHandler:^(QuestionModel *succeed) {
        self.model = succeed;
        [self.mainTableView reloadData];
    } completionFailHandler:^(NSString *failMessage) {
        
    } completionError:^(NSString *netWorkErrorMessage) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.questionList[section].questions.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.questionList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableviewcell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.model.questionList[indexPath.section].questions[indexPath.row].question;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.model.questionList[section].name;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDetailViewController * questionDetailViewController = [[QuestionDetailViewController alloc] init];
    questionDetailViewController.question = self.model.questionList[indexPath.section].questions[indexPath.row];
    [self.navigationController pushViewController:questionDetailViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
