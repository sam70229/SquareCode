#import <Preferences/PSSpecifier.h>
#import <Preferences/PSControlTableCell.h>

@interface stepperCell : PSControlTableCell {
	NSString *title;
}
@property (nonatomic, retain) UIStepper *control;
@end

@implementation stepperCell

@dynamic control;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier]){
		self.accessoryView = self.control;
	}
	return self;
}

- (void)refreshCellContentsWithSpecifier :(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	title = [specifier propertyForKey:@"label"];
	[self _updateLabel];
}

- (UIStepper *)newControl {
	UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
	stepper.continuous = NO;
	stepper.value = 0;
	stepper.minimumValue = 0;
	stepper.maximumValue = 50;
	stepper.stepValue = 10;
	return stepper;
}

- (NSNumber *)controlValue {
	return @(self.control.value);
}

- (void)setValue:(NSNumber *)value {
	[super setValue:value];
	self.control.value = value.doubleValue;
}

- (void)controlChanged:(UIStepper *)stepper {
	[super controlChanged:stepper];
	[self _updateLabel];
}

- (void)_updateLabel {
	if (!self.control){
		return;
	}

	int value = (int)self.control.value;

	self.textLabel.text = [NSString stringWithFormat:@"%@: %d", title, value];

	[self setNeedsLayout];
}
@end