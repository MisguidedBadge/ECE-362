#include "derivative.h"
#include "funct.h"

unsigned int pot_value;

void read_pot(void)
{
	//turn on A/D
	ATDCTL2 = 0x80;

	//wait for power-up
	Delay(2);

	//start conversion channel 0
	ATDCTL5 = 0;

	//wait for conversion complete
	while(!(ATDSTAT0 & 0x80))
		;

	//get data
	pot_value = ATDDR0H;
}			
