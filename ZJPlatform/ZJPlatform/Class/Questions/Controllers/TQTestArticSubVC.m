//
//  TQTestArticSubVC.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQTestArticSubVC.h"
#import <WebKit/WebKit.h>
#import "TQResultCell.h"

@interface TQTestArticSubVC ()<UITextViewDelegate>
{
    
}

@property(nonatomic, strong) UILabel *placeHolder;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *questionLabel;

@end

@implementation TQTestArticSubVC

-(UILabel *)contentLabel{
    if (_contentLabel == nil) {
        NSString *content = [[self.articleDict objectForKey:@"article"] objectForKey:@"content"];
        CGSize maximumLabelSize = CGSizeMake(MainScreenWidth - 30, 9999);//labelsize的最大值
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, MainScreenWidth - 30, 5)];
        _contentLabel.text = content;
        _contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = Font(15);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        _contentLabel.frame = CGRectMake(15, 80, expectSize.width, expectSize.height);
    }
    return _contentLabel;
}

-(UILabel *)questionLabel{
    if (_questionLabel == nil) {
        NSString *content = [Utility htmlEntityDecode:[[[self.articleDict objectForKey:@"questionsArticle"] objectForKey:@"questions"] objectForKey:@"question"]];
        
        content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];

        CGSize maximumLabelSize = CGSizeMake(MainScreenWidth - 30, 9999);//labelsize的最大值
        _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, MainScreenWidth - 30, 5)];
        _questionLabel.text = content;
        _questionLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _questionLabel.numberOfLines = 0;
        _questionLabel.font = Font(15);
        CGSize expectSize = [_questionLabel sizeThatFits:maximumLabelSize];
        _questionLabel.frame = CGRectMake(15, 43, expectSize.width, expectSize.height);
    }
    return _questionLabel;
}





-(void)viewDidLoad{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self createBackBtn];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    if (row == 0) {
        NSString *cellId = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font = Font(13);
        cell.detailTextLabel.font = Font(13);
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = @"";
        cell.detailTextLabel.attributedText = nil;
        
        cell.imageView.image = [UIImage imageNamed:@"test.png"];
        cell.textLabel.text = @"简答题";
        NSString *str = [NSString stringWithFormat:@"%zi/%zi",self.curNum + 1,self.totalCount];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:MainBlueColor
                        range:[str rangeOfString:[NSString stringWithFormat:@"%zi",self.curNum + 1]]];
        cell.detailTextLabel.attributedText = attrStr;
        return cell;
    }else if(row == 1){
        NSString *cellId = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
            label1.font = Font(15);
            label1.text = @"案例";
            [cell.contentView addSubview:label1];
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 43, 100, 30)];
            label2.font = Font(15);
            label2.text = @"背景资料";
            [cell.contentView addSubview:label2];
            
            [cell.contentView addSubview:self.contentLabel];
        }
        return cell;
    }else if(row == 2){
        NSString *cellId = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
            label1.font = Font(15);
            label1.text = @"问答题";
            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:self.questionLabel];
        }
        return cell;
    }else{
        NSString *cellId = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
            label1.font = Font(15);
            label1.text = @"回答";
            [cell.contentView addSubview:label1];
            
            _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 43, MainScreenWidth - 30, 100)];
            _myTextView.layer.masksToBounds = YES;
            _myTextView.layer.cornerRadius = 4;
            _myTextView.layer.borderWidth = 0.5;
            _myTextView.font = Font(15);
            _myTextView.delegate = self;
            _myTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.contentView addSubview:_myTextView];

            self.placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, MainScreenWidth - 2 * 15, 30)];
            self.placeHolder.text = @"请输入答案...";
            self.placeHolder.font = Font(15);
            self.placeHolder.textColor = [UIColor lightGrayColor];
            self.placeHolder.numberOfLines = 0;
            self.placeHolder.contentMode = UIViewContentModeTop;
            [_myTextView addSubview:self.placeHolder];
        }
        return cell;
    }
    return nil;
}



- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        self.placeHolder.alpha = 1;
    } else {
        self.placeHolder.alpha = 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return self.contentLabel.frame.size.height + 80 + 15;
    }else if(indexPath.row == 2){
        return self.questionLabel.frame.size.height + 43 + 15;
    }else if(indexPath.row == 3){
        return 100 + 43 + 8;
    }
    
    
    return 44;
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // 判断webView所在的cell是否可见，如果可见就layout
//    [self.webView setNeedsLayout];
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}

@end
