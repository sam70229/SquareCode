@protocol TPNumberPadButtonProtocol <NSObject>
@end

@interface TPNumberPadButton : UIControl <TPNumberPadButtonProtocol> {
	UIView * _circleView;
	UIColor* _buttonColor;
	UIColor* _color;
}
- (UIView *)circleView;
- (void) setCircleView: (UIView *)arg1;
- (UIColor *)buttonColor;
- (UIColor *)color;
- (void)setColor:(UIColor *)arg1;
@end

@interface TPNumberPad : UIControl {

	NSMutableArray* _buttons;
	BOOL _numberButtonsEnabled;
	double _buttonBackgroundAlpha;

}
-(void)setButtons:(NSArray *)arg1 ;
-(NSArray *)buttons;
-(void)_layoutGrid;
@end

@interface SBSimplePasscodeEntryFieldButton : UIView {

	BOOL _useLightStyle;
	BOOL _revealed;
	UIEdgeInsets _paddingOutsideRing;
	UIColor* _color;
	UIView* _ringView;

}
- (void)layoutSubviews;
@end

@interface SBUIPasscodeEntryField : UIView <UITextFieldDelegate> {

	NSMutableCharacterSet* _numericTrimmingSet;
	BOOL _ignoreCallbacks;
	BOOL _resigningFirstResponder;
	UIColor* _customBackgroundColor;

}
@end