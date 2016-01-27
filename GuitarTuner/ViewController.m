#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_pitchView.centerPitch = 45;
	_pitchLabel.text = @"A-String";
	dispatcher = [[PdDispatcher alloc] init];
	[dispatcher addListener:self forSource:@"pitch"];
	[PdBase setDelegate:dispatcher];
	patch = [PdBase openFile:@"tuner.pd" path:[[NSBundle mainBundle] resourcePath]];

	if (!patch) {
		NSLog(@"Failed to open patch!"); // Gracefully handle failure...
	}
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[PdBase closeFile:patch];
	[PdBase setDelegate:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)playNote:(int)n {
	_pitchView.centerPitch = n;
	[PdBase sendFloat:n toReceiver:@"midinote"];
}

- (IBAction)playE:(id)sender {
	_pitchLabel.text = @"E-String (low)";
	[self playNote:40];
}

-(IBAction)playA:(id)sender {
	_pitchLabel.text = @"A-String";
	[self playNote:45];
}

-(IBAction)playD:(id)sender {
	_pitchLabel.text = @"D-String";
	[self playNote:50];
}

-(IBAction)playG:(id)sender {
	_pitchLabel.text = @"G-String";
	[self playNote:55];
}

-(IBAction)playB:(id)sender {
	_pitchLabel.text = @"B-String";
	[self playNote:59];
}

-(IBAction)playE2:(id)sender {
	_pitchLabel.text = @"E-String (high)";
	[self playNote:64];
}

#pragma mark - PdListener callbacks

-(void)receiveFloat:(float)value fromSource:(NSString *)source {
	NSLog(@"Pitch: %f", value);
	_pitchView.currentPitch = value;
}

@end
