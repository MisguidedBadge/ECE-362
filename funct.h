#ifndef FUNCT_H
#define FUNCT_H
#pragma CODE_SEG NON_BANKED
#define LCDDATA       PTADHi
#define LCDDATADDR    DDRADHi
#define LCDCONTROLDDR DDRM
#define ECLK          PTM_PTM4
#define RW            PTM_PTM5
#define RS            PTM_PTM6

#define LINE1 0x80
#define LINE2 0xc0

void init_LCD(void);
void display_string(char *);

void read_pot(void);
void Delay(unsigned int);

void delay_ms(int);
void epulse(void);
void sendCommand(int);

void SendsChr(char, int);
void PlayTone(void);

#endif
