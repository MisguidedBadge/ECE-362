#include <hidef.h>                  /* common defines and macros */
#include "derivative.h"             /* derivative-specific definitions */
#include "funct.h"

int tone=0;							//value to hold the tone to be generated
int tone_count=0;					//counter to test the tone to be generated

void SendsChr(char NewTone, int dummy)
{
	dummy++;						//increment the dummy value to supress the warning
	tone=NewTone;					//set the tone passed on the stack
}

void PlayTone(void)
{
	tone_count++;					//increment tone counter
	if(tone_count>=tone)			//if the tone count is equal to or higher than the tone
	{
		tone_count=0;			   //reset the counter
		PTT = PTT ^ 0x20;		   //toggle the speaker bit.
	}
}