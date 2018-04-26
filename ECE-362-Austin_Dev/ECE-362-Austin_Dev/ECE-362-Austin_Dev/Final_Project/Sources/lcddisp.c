#include "derivative.h"
#include "funct.h"

int data = 0; //used to determine if a command or data is being sent, sets RS

#define LCDDATA       PTADHi
#define LCDDATADDR    DDRADHi
#define LCDCONTROLDDR DDRM
#define ECLK          PTM_PTM4
#define RW            PTM_PTM5
#define RS            PTM_PTM6

#define LINE1 0x80
#define LINE2 0xc0

void delay_ms(int delay) //Not a precise delay
{
	int x;
	while (delay > 0)
	{
		for (x = 700; x > 0; x--);
		delay--;
	}
}

void init_LCD()
{
        LCDDATADDR = 0xFF; //Set PORT AD 8-15 as outputs, 
        LCDDATA = 0x00; // Clear Port AD 8-15 I/O register 
        LCDCONTROLDDR = LCDCONTROLDDR | 0x70; //Set bits 4, 5, and 6 of Port M as outputs (ECLK, RW, RS respectively)

	delay_ms(5);

        ECLK = 1;
        delay_ms(50); //Small Start Delay
  
        //LCD Initialization
        data = 0;
	LCDDATA = 0x03;
	epulse();
	delay_ms(5);
	epulse();
	delay_ms(5);
	epulse();
	delay_ms(5);
	
        //Setup LCD Screen
	sendCommand(0x3C); //Set Interface Length, 8-data lines, 2 display lines
	sendCommand(0x10); //Turn off Display
	sendCommand(0x01); //Clear Display
	sendCommand(0x06); //Set Cursor Move direction, Auto-Increment cursor after each byte written, dont shift display
	sendCommand(0x0c); //Display on, cursor off
}


void display_string(char* SendStr)
{
	unsigned char count=0;	

	//return home
	sendCommand(LINE1); //Start from the beginning of the LCD (Line 1)

	while(*SendStr!=0)
	{
		
		if(count == 16)
		{
			sendCommand(LINE2); //Switch to Line 2
		}
		++count;	
		data = 1; //Send Character
                LCDDATA = *SendStr;
	        epulse();
		++SendStr;
	}
}



void Delay(unsigned int DelayCount)
{
	unsigned int i, j;

	for(i = 0; i < DelayCount; i++)
		for(j = 0; j < 2000; j++)
			;
}


void epulse(void) //Pulse E Clock
{
	if (data) RS = 1;
	else RS = 0;
	delay_ms(1);

	ECLK = 0;
	delay_ms(1);
	ECLK = 1;
}


void sendCommand( int byte )//Send a byte command to LCD
{
	data = 0; //Send Command
	LCDDATA = byte;
	epulse();	
}