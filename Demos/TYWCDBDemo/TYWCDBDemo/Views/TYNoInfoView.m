//
//  TYNoInfoView.m
//  TYWCDBDemo
//
//  Created by 田宇 on 2020/4/17.
//  Copyright © 2020 Sheldon. All rights reserved.
//

#import "TYNoInfoView.h"
#import "Masonry.h"

@interface TYNoInfoView()
@property(nonatomic, strong) UILabel * infoLbl;
@property(nonatomic, strong) UIButton * infoBtn;
@end

@implementation TYNoInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.infoLbl];
        [self addSubview:self.infoBtn];
        [self.infoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
        }];
        [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.infoLbl.mas_bottom).offset(8);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.infoLbl.text = text;
    [self layoutIfNeeded];
}
- (void)setActionText:(NSString *)actionText {
    _actionText = actionText;
    [self.infoBtn setTitle:actionText forState:UIControlStateNormal];
    [self layoutIfNeeded];
}

- (void)infoBtnClick:(UIButton *)sender {
    if (self.actionCallback) {
        self.actionCallback();
    }
}

- (UILabel *)infoLbl {
    if (!_infoLbl) {
        _infoLbl = [[UILabel alloc] init];
        _infoLbl.text = @"";
        _infoLbl.textColor = UIColor.blackColor;
        _infoLbl.textAlignment = NSTextAlignmentCenter;
        _infoLbl.font = [UIFont systemFontOfSize:18.0f];
    }
    return _infoLbl;
}
-(UIButton *)infoBtn {
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_infoBtn setTitle:@"" forState:UIControlStateNormal];
        [_infoBtn addTarget:self action:@selector(infoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _infoBtn;
}
@end
