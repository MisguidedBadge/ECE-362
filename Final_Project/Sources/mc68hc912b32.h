/*****************************************************
     6812b32.h - Target interface library
     Describes I/O registers of MC68HC12B32
----------------------------------------------------
   Copyright (c) Metrowerks, Basel, Switzerland
                  Do not modify!
*****************************************************/

/****************************************!! WARNINGS !!*********************************************/
/*      1)PORT A, PORT B, and data direction registers DDRA and DDRB are not in map in expanded    */
/*      and peripheral modes                                                                       */
/*      2)PORT E and DDRE not in map in peripheral mode; also not in map in expanded modes with    */
/*      EME set.                                                                                   */
/*      3)MODE, PUCR, AND RDRIV not in map in peripheral mode.                                     */
/*      4)Choose carefully your variable names.For example: 'M' is the defined name of the bit 4   */
/*      from the register 'SC0CR1' (SCI Control Register 1).                                       */
/***************************************************************************************************/

#ifndef __6812B32_H__
#define __6812B32_H__

#define _IO_BASE_ADDR 0
#define _IO_AT(x)  @(_IO_BASE_ADDR+(x))

#ifndef __DECL__6812B32_H__
#define __DECL__6812B32_H__  extern
#endif

#pragma MESSAGE DISABLE C1106 /* WARNING C1106: Non-standard bitfield type */

#include <stdtypes.h>

/**************************************************************************************************/
/*                                         DEFINE PORT A                                          */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PORTA    _IO_AT(0x00);  /* port A */

__DECL__6812B32_H__ volatile  unsigned char DDRA     _IO_AT(0x02);  /* data direction port A */


/**************************************************************************************************/
/*                                         DEFINE PORT B                                          */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PORTB    _IO_AT(0x01);  /* port B */

__DECL__6812B32_H__ volatile  unsigned char DDRB     _IO_AT(0x03);  /* data direction port B */


/**************************************************************************************************/
/*                                         DEFINE PORT E                                          */
/**************************************************************************************************/


__DECL__6812B32_H__ volatile  unsigned char PORTE    _IO_AT(0x08);  /* port E */


__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char _DDE2:1;
    unsigned char _DDE3:1;
    unsigned char _DDE4:1;
    unsigned char _DDE5:1;
    unsigned char _DDE6:1;
    unsigned char _DDE7:1;
  } DDRE_BITS;
  unsigned char DDRE_BYTE;
}DDRE1  _IO_AT(0x09);

/* DEFINE REGISTER */
#define DDRE DDRE1.DDRE_BYTE

/*DEFINE REGISTER BITS*/
#define DDE2 DDRE1.DDRE_BITS._DDE2
#define DDE3 DDRE1.DDRE_BITS._DDE3
#define DDE4 DDRE1.DDRE_BITS._DDE4
#define DDE5 DDRE1.DDRE_BITS._DDE5
#define DDE6 DDRE1.DDRE_BITS._DDE6
#define DDE7 DDRE1.DDRE_BITS._DDE7

/**************************************************************************************************/
/*                               PORT E ASSIGNEMENT REGISTER                                      */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char _RDWE:1;
    unsigned char _LSTRE:1;
    unsigned char _NECLK:1;
    unsigned char _PIPOE:1;
    unsigned char _BIT6:1;
    unsigned char _NDBE:1;
  } PEAR_BITS;
  unsigned char PEAR_BYTE;
}PEAR1 _IO_AT(0x0a);

/*DEFINE FOR THE COMPATIBILITY WITH OLD VERSION*/
/*           "CKL" INSTEAD OF "CLK"            */
#define _NECKL _NECLK
#define NECKL NECLK

/*DEFINE REGISTER*/
#define PEAR PEAR1.PEAR_BYTE

/*DEFINE REGISTER BITS*/
#define RDWE PEAR1.PEAR_BITS._RDWE
#define LSTRE PEAR1.PEAR_BITS._LSTRE
#define NECLK PEAR1.PEAR_BITS._NECLK
#define PIPOE PEAR1.PEAR_BITS._PIPOE
#define NDBE PEAR1.PEAR_BITS._NDBE

/**************************************************************************************************/
/*                                            MODE REGISTER                                       */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EME:1     ;
    unsigned char _BIT1:1    ;
    unsigned char _EBSWAI:1  ;
    unsigned char _IVIS:1    ;
    unsigned char _ESTR:1    ;
    unsigned char _MODA:1    ;
    unsigned char _MODB:1    ;
    unsigned char _SMODN:1   ;
  } MODE_BITS;
  unsigned char MODE_BYTE;
}MODE1 _IO_AT(0x0B);

/*DEFINE REGISTER*/
#define MODE MODE1.MODE_BYTE

/*DEFINE REGISTER BITS*/
#define EME MODE1.MODE_BITS._EME
#define EBSWAI MODE1.MODE_BITS._EBSWAI
#define IVIS MODE1.MODE_BITS._IVIS
#define ESTR MODE1.MODE_BITS._ESTR
#define MODA MODE1.MODE_BITS._MODA
#define MODB MODE1.MODE_BITS._MODB
#define SMODN MODE1.MODE_BITS._SMODN

/**************************************************************************************************/
/*                               PULL-UP CONTROL REGISTER                                         */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PUPA:1;
    unsigned char _PUPB:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char _PUPE:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } PUCR_BITS;
  unsigned char PUCR_BYTE;
}PUCR1 _IO_AT(0x0C);

/*DEFINE REGISTER*/
#define PUCR PUCR1.PUCR_BYTE

/*DEFINE REGISTER BITS*/
#define PUPA PUCR1.PUCR_BITS._PUPA
#define PUPB PUCR1.PUCR_BITS._PUPB
#define PUPE PUCR1.PUCR_BITS._PUPE

/**************************************************************************************************/
/*                               REDUCED DRIVE OF I\O LINES                                       */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _RDPA:1;
    unsigned char _RDPB:1;
    unsigned char BIT2:1;
    unsigned char _RDPE:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } RDRIV_BITS;
  unsigned char RDRIV_BYTE;
}RDRIV1 _IO_AT(0x0D);

/*DEFINE REGISTER*/
#define RDRIV RDRIV1.RDRIV_BYTE

/*DEFINE REGISTER BITS*/
#define RDPA RDRIV1.RDRIV_BITS._RDPA
#define RDPB RDRIV1.RDRIV_BITS._RDPB
#define RDPE RDRIV1.RDRIV_BITS._RDPE

/**************************************************************************************************/
/*                    INITIALIZATION OF INTERNAL RAM POSITION REGISTER                            */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char _RAM11:1;
    unsigned char _RAM12:1;
    unsigned char _RAM13:1;
    unsigned char _RAM14:1;
    unsigned char _RAM15:1;
  } INITRM_BITS;
  unsigned char INITRM_BYTE;
}INITRM1 _IO_AT(0x10);

/*DEFINE REGISTER*/
#define INITRM INITRM1.INITRM_BYTE

/*DEFINE REGISTER BITS*/
#define RAM11 INITRM1.INITRM_BITS._RAM11
#define RAM12 INITRM1.INITRM_BITS._RAM12
#define RAM13 INITRM1.INITRM_BITS._RAM13
#define RAM14 INITRM1.INITRM_BITS._RAM14
#define RAM15 INITRM1.INITRM_BITS._RAM15

/**************************************************************************************************/
/*                    INITIALIZATION OF INTERNAL REGISTER POSITION REGISTER                       */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _MMSWAI:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char _REG11:1;
    unsigned char _REG12:1;
    unsigned char _REG13:1;
    unsigned char _REG14:1;
    unsigned char _REG15:1;
  } INITRG_BITS;
  unsigned char INITRG_BYTE;
}INITRG1 _IO_AT(0x11);

/*DEFINE REGISTER*/
#define INITRG INITRG1.INITRG_BYTE

/*DEFINE REGISTER BITS*/
#define MMSWAI INITRG1.INITRG_BITS._MMSWAI
#define REG11 INITRG1.INITRG_BITS._REG11
#define REG12 INITRG1.INITRG_BITS._REG12
#define REG13 INITRG1.INITRG_BITS._REG13
#define REG14 INITRG1.INITRG_BITS._REG14
#define REG15 INITRG1.INITRG_BITS._REG15

/**************************************************************************************************/
/*                    INITIALIZATION OF INTERNAL EEPROM POSITION REGISTER                         */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EEON:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char _EE12:1;
    unsigned char _EE13:1;
    unsigned char _EE14:1;
    unsigned char _EE15:1;
  } INITEE_BITS;
  unsigned char INITEE_BYTE;
}INITEE1 _IO_AT(0x12);

/*DEFINE REGISTER*/
#define INITEE INITEE1.INITEE_BYTE

/*DEFINE REGISTER BITS*/
#define EEON INITEE1.INITEE_BITS._EEON
#define EE12 INITEE1.INITEE_BITS._EE12
#define EE13 INITEE1.INITEE_BITS._EE13
#define EE14 INITEE1.INITEE_BITS._EE14
#define EE15 INITEE1.INITEE_BITS._EE15

/**************************************************************************************************/
/*                         MISCELLANEOUS MAPPING CONTROL REGISTER                                 */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _ROMON:1;
    unsigned char _MAPROM:1;
    unsigned char _EXSTR0:1;
    unsigned char _EXSTR1:1;
    unsigned char _RFSTR0:1;
    unsigned char _RFSTR1:1;
    unsigned char _NDRF:1;
    unsigned char BIT7:1;
  } MISC_BITS;
  unsigned char MISC_BYTE;
}MISC1 _IO_AT(0x13);

/*DEFINE REGISTER*/
#define MISC MISC1.MISC_BYTE

/*DEFINE REGISTER BITS*/
#define ROMON MISC1.MISC_BITS._ROMON
#define MAPROM MISC1.MISC_BITS._MAPROM
#define EXSTR0 MISC1.MISC_BITS._EXSTR0
#define EXSTR1 MISC1.MISC_BITS._EXSTR1
#define RFSTR0 MISC1.MISC_BITS._RFSTR0
#define RFSTR1 MISC1.MISC_BITS._RFSTR1
#define NDRF MISC1.MISC_BITS._NDRF

/**************************************************************************************************/
/*                                     REAL-TIME INTERRUPT ENABLE                                 */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _RTR0:1;
    unsigned char _RTR1:1;
    unsigned char _RTR2:1;
    unsigned char _RTBYP:1;
    unsigned char _BIT4:1;
    unsigned char _RSBCK:1;
    unsigned char _RSWAI:1;
    unsigned char _RTIE:1;
  } RTICTL_BITS;
  unsigned char RTICTL_BYTE;
}RTICTL1 _IO_AT(0x14);

/*DEFINE REGISTER*/
#define RTICTL RTICTL1.RTICTL_BYTE

/*DEFINE REGISTER BITS*/
#define RTR0 RTICTL1.RTICTL_BITS._RTR0
#define RTR1 RTICTL1.RTICTL_BITS._RTR1
#define RTR2 RTICTL1.RTICTL_BITS._RTR2
#define RTBYP RTICTL1.RTICTL_BITS._RTBYP
#define RSBCK RTICTL1.RTICTL_BITS._RSBCK
#define RSWAI RTICTL1.RTICTL_BITS._RSWAI
#define RTIE RTICTL1.RTICTL_BITS._RTIE

/**************************************************************************************************/
/*                                  REAL-TIME INTERRUPT FLAG REGISTER                             */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char _RTIF:1;
  } RTIFLG_BITS;
  unsigned char RTIFLG_BYTE;
}RTIFLG1 _IO_AT(0x15);

/*DEFINE REGISTER*/
#define RTIFLG RTIFLG1.RTIFLG_BYTE

/*DEFINE REGISTER BITS*/
#define RTIF RTIFLG1.RTIFLG_BITS._RTIF


/**************************************************************************************************/
/*                                       COP CONTROL REGISTER                                     */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _CR0:1;
    unsigned char _CR1:1;
    unsigned char _CR2:1;
    unsigned char _DISR:1;
    unsigned char _FCOP:1;
    unsigned char _FCM:1;
    unsigned char _FCME:1;
    unsigned char _CME:1;
  } COPCTL_BITS;
  unsigned char COPCTL_BYTE;
}COPCTL1 _IO_AT(0x16);

/*DEFINE REGISTER*/
#define COPCTL COPCTL1.COPCTL_BYTE

/*DEFINE REGISTER BITS*/
#define CR0 COPCTL1.COPCTL_BITS._CR0
#define CR1 COPCTL1.COPCTL_BITS._CR1
#define CR2 COPCTL1.COPCTL_BITS._CR2
#define DISR COPCTL1.COPCTL_BITS._DISR
#define FCOP COPCTL1.COPCTL_BITS._FCOP
#define FCM COPCTL1.COPCTL_BITS._FCM
#define FCME COPCTL1.COPCTL_BITS._FCME
#define CME COPCTL1.COPCTL_BITS._CME

/**************************************************************************************************/
/*                                 ARM/RESET COP TIMER REGISTER                                   */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char COPRST   _IO_AT(0x17);  /* COP arm/reset */

/**************************************************************************************************/
/*                                   INTERRUPT TEST REGISTERS                                     */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char ITST0    _IO_AT(0x18);  /* interrupt test 0 */
__DECL__6812B32_H__ volatile  unsigned char ITST1    _IO_AT(0x19);  /* interrupt test 1 */
__DECL__6812B32_H__ volatile  unsigned char ITST2    _IO_AT(0x1a);  /* interrupt test 2 */
__DECL__6812B32_H__ volatile  unsigned char ITST3    _IO_AT(0x1b);  /* interrupt test 3 */

/**************************************************************************************************/
/*                                     INTERRUPT CONTROL REGISTER                                 */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char _DLY:1;
    unsigned char _IRQEN:1;
    unsigned char _IRQE:1;
  } INTCR_BITS;
  unsigned char INTCR_BYTE;
}INTCR1 _IO_AT(0x1E);

/*DEFINE REGISTER*/
#define INTCR INTCR1.INTCR_BYTE

/*DEFINE REGISTER BITS*/
#define DLY   INTCR1.INTCR_BITS._DLY
#define IRQEN INTCR1.INTCR_BITS._IRQEN
#define IRQE  INTCR1.INTCR_BITS._IRQE

/**************************************************************************************************/
/*                                   HIGHEST PRIORITY I INTERRUPT                                 */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char _PSEL1:1;
    unsigned char _PSEL2:1;
    unsigned char _PSEL3:1;
    unsigned char _PSEL4:1;
    unsigned char _PSEL5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } HPRIO_BITS;
  unsigned char HPRIO_BYTE;
}HPRIO1 _IO_AT(0x1F);

/*DEFINE REGISTER*/
#define HPRIO HPRIO1.HPRIO_BYTE

/*DEFINE REGISTER BITS*/
#define PSEL1 HPRIO1.HPRIO_BITS._PSEL1
#define PSEL2 HPRIO1.HPRIO_BITS._PSEL2
#define PSEL3 HPRIO1.HPRIO_BITS._PSEL3
#define PSEL4 HPRIO1.HPRIO_BITS._PSEL4
#define PSEL5 HPRIO1.HPRIO_BITS._PSEL5

/**************************************************************************************************/
/*                                   BREAKPOINT CONTROL REGISTER 0                                */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char _BK0ALE:1;
    unsigned char _BK1ALE:1;
    unsigned char BIT4:1;
    unsigned char _BKPM:1;
    unsigned char _BKEN0:1;
    unsigned char _BKEN1:1;
  } BRKCT0_BITS;
  unsigned char BRKCT0_BYTE;
}BRKCT01 _IO_AT(0x20);

/*DEFINE REGISTER*/
#define BRKCT0 BRKCT01.BRKCT0_BYTE

/*DEFINE REGISTER BITS*/
#define BK0ALE BRKCT01.BRKCT0_BITS._BK0ALE
#define BK1ALE BRKCT01.BRKCT0_BITS._BK1ALE
#define BKPM   BRKCT01.BRKCT0_BITS._BKPM
#define BKEN0  BRKCT01.BRKCT0_BITS._BKEN0
#define BKEN1  BRKCT01.BRKCT0_BITS._BKEN1

#define BR0ALE BK0ALE
#define BR1ALE BK1ALE

/*******************************************************************************************/
/*                                   BREAKPOINT CONTROL REGISTER 1                         */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _BK0RW:1;
    unsigned char _BK0RWE:1;
    unsigned char _BK1RW:1;
    unsigned char _BK1RWE:1;
    unsigned char _BKMBL:1;
    unsigned char _BKMBH:1;
    unsigned char _BKDBE:1;
    unsigned char BIT7:1;
  } BRKCT1_BITS;
  unsigned char BRKCT1_BYTE;
}BRKCT11 _IO_AT(0x21);

/*DEFINE REGISTER*/
#define BRKCT1 BRKCT11.BRKCT1_BYTE

/*DEFINE REGISTER BITS*/
#define BK0RW  BRKCT11.BRKCT1_BITS._BK0RW
#define BK0RWE BRKCT11.BRKCT1_BITS._BK0RWE
#define BK1RW  BRKCT11.BRKCT1_BITS._BK1RW
#define BK1RWE BRKCT11.BRKCT1_BITS._BK1RWE
#define BKMBL  BRKCT11.BRKCT1_BITS._BKMBL
#define BKMBH  BRKCT11.BRKCT1_BITS._BKMBH
#define BKDBE  BRKCT11.BRKCT1_BITS._BKDBE

/*******************************************************************************************/
/*                           BREAKPOINT DATA AND ADDRESS REGISTERS                         */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char BRKAH    _IO_AT(0x22);  /* Breakpoint Address Register, High Byte*/
__DECL__6812B32_H__ volatile  unsigned char BRKAL    _IO_AT(0x23);  /* Breakpoint Address Register, Low Byte*/

__DECL__6812B32_H__ volatile  unsigned char BRKDH     _IO_AT(0x24);  /* Breakpoint Data Register, High Byte*/
__DECL__6812B32_H__ volatile  unsigned char BRKDL     _IO_AT(0x25);  /* Breakpoint Data Register, Low Byte*/

/*******************************************************************************************/
/*                              PWM CLOCKS AND CONCATENATE                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PCKB0:1;
    unsigned char _PCKB1:1;
    unsigned char _PCKB2:1;
    unsigned char _PCKA0:1;
    unsigned char _PCKA1:1;
    unsigned char _PCKA2:1;
    unsigned char _CON01:1;
    unsigned char _CON02:1;
  } PWCLK_BITS;
  unsigned char PWCLK_BYTE;
}PWCLK1 _IO_AT(0x40);

/*DEFINE FOR THE COMPATIBILITY WITH OLD VERSION*/
/*           "CKL" INSTEAD OF "CLK"           */
#define PWCKL_BITS PWCLK_BITS
#define PWCKL_BYTE PWCLK_BYTE
#define PWCKL1 PWCLK1
#define PWCKL  PWCLK

/*DEFINE REGISTER*/
#define PWCLK PWCLK1.PWCLK_BYTE

/*DEFINE REGISTER BITS*/
#define PCKB0 PWCLK1.PWCLK_BITS._PCKB0
#define PCKB1 PWCLK1.PWCLK_BITS._PCKB1
#define PCKB2 PWCLK1.PWCLK_BITS._PCKB2
#define PCKA0 PWCLK1.PWCLK_BITS._PCKA0
#define PCKA1 PWCLK1.PWCLK_BITS._PCKA1
#define PCKA2 PWCLK1.PWCLK_BITS._PCKA2
#define CON01 PWCLK1.PWCLK_BITS._CON01
#define CON02 PWCLK1.PWCLK_BITS._CON02

/*******************************************************************************************/
/*                              PWM CLOCK SELECT AND POLARITY                              */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PPOL0:1;
    unsigned char _PPOL1:1;
    unsigned char _PPOL2:1;
    unsigned char _PPOL3:1;
    unsigned char _PCLK0:1;
    unsigned char _PCLK1:1;
    unsigned char _PCLK2:1;
    unsigned char _PCLK3:1;
  } PWPOL_BITS;
  unsigned char PWPOL_BYTE;
}PWPOL1 _IO_AT(0x41);

/*DEFINE REGISTER*/
#define PWPOL PWPOL1.PWPOL_BYTE

/*DEFINE REGISTER BITS*/
#define PPOL0 PWPOL1.PWPOL_BITS._PPOL0
#define PPOL1 PWPOL1.PWPOL_BITS._PPOL1
#define PPOL2 PWPOL1.PWPOL_BITS._PPOL2
#define PPOL3 PWPOL1.PWPOL_BITS._PPOL3
#define PCLK0 PWPOL1.PWPOL_BITS._PCLK0
#define PCLK1 PWPOL1.PWPOL_BITS._PCLK1
#define PCLK2 PWPOL1.PWPOL_BITS._PCLK2
#define PCLK3 PWPOL1.PWPOL_BITS._PCLK3

/*******************************************************************************************/
/*                                          PWM ENABLE                                     */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PWEN0:1;
    unsigned char _PWEN1:1;
    unsigned char _PWEN2:1;
    unsigned char _PWEN3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } PWEN_BITS;
  unsigned char PWEN_BYTE;
}PWEN_1 _IO_AT(0x42);

/*DEFINE REGISTER*/
#define PWEN PWEN_1.PWEN_BYTE

/*DEFINE REGISTER BITS*/
#define PWEN0 PWEN_1.PWEN_BITS._PWEN0
#define PWEN1 PWEN_1.PWEN_BITS._PWEN1
#define PWEN2 PWEN_1.PWEN_BITS._PWEN2
#define PWEN3 PWEN_1.PWEN_BITS._PWEN3

/*******************************************************************************************/
/*                                 PWM PRESCALE COUNTER                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWPRES   _IO_AT(0x43);  /* PWM Prescale Counter */

/*******************************************************************************************/
/*                                 PWM SCALE REGISTER 0                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWSCAL0  _IO_AT(0x44); /* PWM Scale 0 */

/*******************************************************************************************/
/*                                 PWM SCALE COUNTER VALUE 0                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWSCNT0  _IO_AT(0x45); /* PWM Counter 0 */

/*******************************************************************************************/
/*                                 PWM SCALE REGISTER 1                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWSCAL1  _IO_AT(0x46); /* PWM Scale 1 */

/*******************************************************************************************/
/*                                 PWM SCALE COUNTER VALUE 1                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWSCNT1  _IO_AT(0x47); /* PWM Counter 1 */

/*******************************************************************************************/
/*                                      PWM CHANNEL COUNTERS                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWCNT0   _IO_AT(0x48);  /* PWM Channel Counter 0 */
__DECL__6812B32_H__ volatile  unsigned char PWCNT1   _IO_AT(0x49);  /* PWM Channel Counter 1 */
__DECL__6812B32_H__ volatile  unsigned char PWCNT2   _IO_AT(0x4a);  /* PWM Channel Counter 2 */
__DECL__6812B32_H__ volatile  unsigned char PWCNT3   _IO_AT(0x4b);  /* PWM Channel Counter 3 */

/*******************************************************************************************/
/*                              PWM CHANNEL PERIOD REGISTERS                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWPER0   _IO_AT(0x4c);  /* PWM Channel Period 0 */
__DECL__6812B32_H__ volatile  unsigned char PWPER1   _IO_AT(0x4d);  /* PWM Channel Period 1 */
__DECL__6812B32_H__ volatile  unsigned char PWPER2   _IO_AT(0x4e);  /* PWM Channel Period 2 */
__DECL__6812B32_H__ volatile  unsigned char PWPER3   _IO_AT(0x4f);  /* PWM Channel Period 3 */

/*******************************************************************************************/
/*                                PWM CHANNEL DUTY REGISTERS                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PWDTY0   _IO_AT(0x50);  /* PWM Channel Duty 0 */
__DECL__6812B32_H__ volatile  unsigned char PWDTY1   _IO_AT(0x51);  /* PWM Channel Duty 1 */
__DECL__6812B32_H__ volatile  unsigned char PWDTY2   _IO_AT(0x52);  /* PWM Channel Duty 2 */
__DECL__6812B32_H__ volatile  unsigned char PWDTY3   _IO_AT(0x53);  /* PWM Channel Duty 3 */

/*******************************************************************************************/
/*                                PWM CONTROL REGISTER                                     */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PSBCK:1;
    unsigned char _PUPP:1;
    unsigned char _RDPP:1;
    unsigned char _CENTR:1;
    unsigned char _PSWAI:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } PWCTL_BITS;
  unsigned char PWCTL_BYTE;
}PWCTL1 _IO_AT(0x54);

/*DEFINE REGISTER*/
#define PWCTL PWCTL1.PWCTL_BYTE

/*DEFINE REGISTER BITS*/
#define PSBCK PWCTL1.PWCTL_BITS._PSBCK
#define PUPP  PWCTL1.PWCTL_BITS._PUPP
#define RDPP  PWCTL1.PWCTL_BITS._RDPP
#define CENTR PWCTL1.PWCTL_BITS._CENTR
#define PSWAI PWCTL1.PWCTL_BITS._PSWAI

/*******************************************************************************************/
/*                              PWM SPECIAL MODE REGISTER (TEST)                           */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char _DISCAL:1;
    unsigned char _DISCP:1;
    unsigned char _DISCR:1;
  } PWTST_BITS;
  unsigned char PWTST_BYTE;
}PWTST1 _IO_AT(0x55);

/*DEFINE REGISTER*/
#define PWTST PWTST1.PWTST_BYTE

/*DEFINE REGISTER BITS*/
#define DISCAL PWTST1.PWTST_BITS._DISCAL
#define DISCP PWTST1.PWTST_BITS._DISCP
#define DISCR PWTST1.PWTST_BITS._DISCR

/**************************************************************************************************/
/*                                         DEFINE PORT P                                          */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PORTP    _IO_AT(0x56);  /* port P */

__DECL__6812B32_H__ volatile  unsigned char DDRP    _IO_AT(0x57);  /* data direction port P */

/**************************************************************************************************/
/*                                   ATD RESERVED REGISTERS                                       */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char ATDCTL0  _IO_AT(0x60); /* A/D control register 0 */
__DECL__6812B32_H__ volatile  unsigned char ATDCTL1  _IO_AT(0x61); /* A/D control register 1 */

/**************************************************************************************************/
/*                                    ATD CONTROL REGISTERS                                       */
/**************************************************************************************************/

/**********ATD CONTROL REGISTER 2********/
__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _ASCIF:1;
    unsigned char _ASCIE:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char _ASWAI:1;
    unsigned char _AFFC:1;
    unsigned char _ADPU:1;
  } ATDCTL2_BITS;
  unsigned char ATDCTL2_BYTE;
}ATDCTL21 _IO_AT(0x62);

/*DEFINE REGISTER*/
#define ATDCTL2 ATDCTL21.ATDCTL2_BYTE

/*DEFINE REGISTER BITS*/
#define ASCIF ATDCTL21.ATDCTL2_BITS._ASCIF
#define ASCIE ATDCTL21.ATDCTL2_BITS._ASCIE
#define ASWAI ATDCTL21.ATDCTL2_BITS._ASWAI
#define AFFC ATDCTL21.ATDCTL2_BITS._AFFC
#define ADPU ATDCTL21.ATDCTL2_BITS._ADPU

/**********ATD CONTROL REGISTER 3********/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _FRZ0:1;
    unsigned char _FRZ1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } ATDCTL3_BITS;
  unsigned char ATDCTL3_BYTE;
}ATDCTL31 _IO_AT(0x63);

/*DEFINE REGISTER*/
#define ATDCTL3 ATDCTL31.ATDCTL3_BYTE

/*DEFINE REGISTER BITS*/
#define FRZ0 ATDCTL31.ATDCTL3_BITS._FRZ0
#define FRZ1 ATDCTL31.ATDCTL3_BITS._FRZ1

/**********ATD CONTROL REGISTER 4********/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PRS0:1;
    unsigned char _PRS1:1;
    unsigned char _PRS2:1;
    unsigned char _PRS3:1;
    unsigned char _PRS4:1;
    unsigned char _SMP0:1;
    unsigned char _SMP1:1;
    unsigned char BIT7:1;
  } ATDCTL4_BITS;
  unsigned char ATDCTL4_BYTE;
}ATDCTL41 _IO_AT(0x64);

/*DEFINE REGISTER*/
#define ATDCTL4 ATDCTL41.ATDCTL4_BYTE

/*DEFINE REGISTER BITS*/
#define PRS0 ATDCTL41.ATDCTL4_BITS._PRS0
#define PRS1 ATDCTL41.ATDCTL4_BITS._PRS1
#define PRS2 ATDCTL41.ATDCTL4_BITS._PRS2
#define PRS3 ATDCTL41.ATDCTL4_BITS._PRS3
#define PRS4 ATDCTL41.ATDCTL4_BITS._PRS4
#define SMP0 ATDCTL41.ATDCTL4_BITS._SMP0
#define SMP1 ATDCTL41.ATDCTL4_BITS._SMP1

/**********ATD CONTROL REGISTER 5********/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _CA:1;
    unsigned char _CB:1;
    unsigned char _CC:1;
    unsigned char _CD:1;
    unsigned char _MULT:1;
    unsigned char _SCAN:1;
    unsigned char _S8CM:1;
    unsigned char BIT7:1;
  } ATDCTL5_BITS;
  unsigned char ATDCTL5_BYTE;
}ATDCTL51 _IO_AT(0x65);

/*DEFINE REGISTER*/
#define ATDCTL5 ATDCTL51.ATDCTL5_BYTE

/*DEFINE REGISTER BITS*/
#define CA ATDCTL51.ATDCTL5_BITS._CA
#define CB ATDCTL51.ATDCTL5_BITS._CB
#define CC ATDCTL51.ATDCTL5_BITS._CC
#define CD ATDCTL51.ATDCTL5_BITS._CD
#define MULT ATDCTL51.ATDCTL5_BITS._MULT
#define SCAN ATDCTL51.ATDCTL5_BITS._SCAN
#define S8CM ATDCTL51.ATDCTL5_BITS._S8CM

/**************************************************************************************************/
/*                                    ATD STATUS REGISTER                                         */
/**************************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned int  _CC0:1;
    unsigned int  _CC1:1;
    unsigned int  _CC2:1;
    unsigned int  BIT3:1;
    unsigned int  BIT4:1;
    unsigned int  BIT5:1;
    unsigned int  BIT6:1;
    unsigned int  _SCF:1;
    unsigned int  _CCF0:1;
    unsigned int  _CCF1:1;
    unsigned int  _CCF2:1;
    unsigned int  _CCF3:1;
    unsigned int  _CCF4:1;
    unsigned int  _CCF5:1;
    unsigned int  _CCF6:1;
    unsigned int  _CCF7:1;
  } ATDSTAT_BITS;
  unsigned int ATDSTAT_WORD;
}ATDSTAT1 _IO_AT(0x66);

/*DEFINE REGISTER*/
#define ATDSTAT ATDSTAT1.ATDSTAT_WORD

/*DEFINE REGISTER BITS*/
#define CC0 ATDSTAT1.ATDSTAT_BITS._CC0
#define CC1 ATDSTAT1.ATDSTAT_BITS._CC1
#define CC2 ATDSTAT1.ATDSTAT_BITS._CC2
#define SCF ATDSTAT1.ATDSTAT_BITS._SCF
#define CCF0 ATDSTAT1.ATDSTAT_BITS._CCF0
#define CCF1 ATDSTAT1.ATDSTAT_BITS._CCF1
#define CCF2 ATDSTAT1.ATDSTAT_BITS._CCF2
#define CCF3 ATDSTAT1.ATDSTAT_BITS._CCF3
#define CCF4 ATDSTAT1.ATDSTAT_BITS._CCF4
#define CCF5 ATDSTAT1.ATDSTAT_BITS._CCF5
#define CCF6 ATDSTAT1.ATDSTAT_BITS._CCF6
#define CCF7 ATDSTAT1.ATDSTAT_BITS._CCF7

/*******************************************************************************************/
/*                                        ATD TEST REGISTER                                */
/*******************************************************************************************/

/********ATD TEST REGISTER HIGH*********/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SAR2:1;
    unsigned char _SAR3:1;
    unsigned char _SAR4:1;
    unsigned char _SAR5:1;
    unsigned char _SAR6:1;
    unsigned char _SAR7:1;
    unsigned char _SAR8:1;
    unsigned char _SAR9:1;
  } ATDTSTH_BITS;
  unsigned char ATDTSTH_BYTE;
} ATDTSTH1 _IO_AT(0x68);

/*DEFINE REGISTER*/
#define ATDTSTH ATDTSTH1.ATDTSTH_BYTE

/*DEFINE REGISTER BITS*/
#define SAR2 ATDTSTH1.ATDTSTH_BITS._SAR2
#define SAR3 ATDTSTH1.ATDTSTH_BITS._SAR3
#define SAR4 ATDTSTH1.ATDTSTH_BITS._SAR4
#define SAR5 ATDTSTH1.ATDTSTH_BITS._SAR5
#define SAR6 ATDTSTH1.ATDTSTH_BITS._SAR6
#define SAR7 ATDTSTH1.ATDTSTH_BITS._SAR7
#define SAR8 ATDTSTH1.ATDTSTH_BITS._SAR8
#define SAR9 ATDTSTH1.ATDTSTH_BITS._SAR9


/********ATD TEST REGISTER LOW**********/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _TST0:1;
    unsigned char _TST1:1;
    unsigned char _TST2:1;
    unsigned char _TST3:1;
    unsigned char _TSTOUT:1;
    unsigned char _RST:1;
    unsigned char _SAR0:1;
    unsigned char _SAR1:1;
  } ATDTSTL_BITS;
  unsigned char ATDTSTL_BYTE;
} ATDTSTL1 _IO_AT(0x69);

/*DEFINE REGISTER*/
#define ATDTSTL ATDTSTL1.ATDTSTL_BYTE

/*DEFINE REGISTER BITS*/
#define TST0   ATDTSTL1.ATDTSTL_BITS._TST0
#define TST1   ATDTSTL1.ATDTSTL_BITS._TST1
#define TST2   ATDTSTL1.ATDTSTL_BITS._TST2
#define TST3   ATDTSTL1.ATDTSTL_BITS._TST3
#define TSTOUT ATDTSTL1.ATDTSTL_BITS._TSTOUT
#define RST    ATDTSTL1.ATDTSTL_BITS._RST
#define SAR0   ATDTSTL1.ATDTSTL_BITS._SAR0
#define SAR1   ATDTSTL1.ATDTSTL_BITS._SAR1

/*******************************************************************************************/
/*                                 PORT AD DATA INPUT REGISTER                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char PORTAD   _IO_AT(0x6f); /* port AD data input register */

/*******************************************************************************************/
/*                              ADT CONVERTER RESULT REGISTERS                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char ADR0H    _IO_AT(0x70); /* A/D result 0 */
__DECL__6812B32_H__ volatile  unsigned char ADR1H    _IO_AT(0x72); /* A/D result 1 */
__DECL__6812B32_H__ volatile  unsigned char ADR2H    _IO_AT(0x74); /* A/D result 2 */
__DECL__6812B32_H__ volatile  unsigned char ADR3H    _IO_AT(0x76); /* A/D result 3 */
__DECL__6812B32_H__ volatile  unsigned char ADR4H    _IO_AT(0x78); /* A/D result 4 */
__DECL__6812B32_H__ volatile  unsigned char ADR5H    _IO_AT(0x7a); /* A/D result 5 */
__DECL__6812B32_H__ volatile  unsigned char ADR6H    _IO_AT(0x7c); /* A/D result 6 */
__DECL__6812B32_H__ volatile  unsigned char ADR7H    _IO_AT(0x7e); /* A/D result 7 */

/*******************************************************************************************/
/*                           TIMER INPUT/OUTPUT COMPARE SELECT                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char TIOS     _IO_AT(0x80);

/*******************************************************************************************/
/*                          TIMER COMPARE FORCE REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char CFORC    _IO_AT(0x81);

/*******************************************************************************************/
/*                         OUTPUT COMPARE 7 MASK REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char OC7M     _IO_AT(0x82);

/*******************************************************************************************/
/*                         OUTPUT COMPARE 7 DATA REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char OC7D     _IO_AT(0x83);

/*******************************************************************************************/
/*                         OUTPUT COMPARE 7 DATA REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned int TCNT     _IO_AT(0x84);

/*******************************************************************************************/
/*                                TIMER SYSTEM CONTROL REGISTER                            */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char _TFFCA:1;
    unsigned char _TSBCK:1;
    unsigned char _TSWAI:1;
    unsigned char _TEN:1;
  } TSCR_BITS;
  unsigned char TSCR_BYTE;
} TSCR1 _IO_AT(0x86);

/*DEFINE REGISTER*/
#define TSCR TSCR1.TSCR_BYTE

/*DEFINE REGISTER BITS*/
#define TFFCA TSCR1.TSCR_BITS._TFFCA
#define TSBCK TSCR1.TSCR_BITS._TSBCK
#define TSWAI TSCR1.TSCR_BITS._TSWAI
#define TEN TSCR1.TSCR_BITS._TEN

/*******************************************************************************************/
/*                         TIMER QUEUE CONTROL REGISTER (RESERVED)                         */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char TQCR     _IO_AT(0x87);  /* timer queue control */

/*******************************************************************************************/
/*                                TIMER CONTROL REGISTER 1                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _OL4:1;
    unsigned char _OM4:1;
    unsigned char _OL5:1;
    unsigned char _OM5:1;
    unsigned char _OL6:1;
    unsigned char _OM6:1;
    unsigned char _OL7:1;
    unsigned char _OM7:1;
  } TCTL1_BITS;
  unsigned char TCTL1_BYTE;
} TCTL11 _IO_AT(0x88);

/*DEFINE REGISTER*/
#define TCTL1 TCTL11.TCTL1_BYTE

/*DEFINE REGISTER BITS*/
#define OL4 TCTL11.TCTL1_BITS._OL4
#define OM4 TCTL11.TCTL1_BITS._OM4
#define OL5 TCTL11.TCTL1_BITS._OL5
#define OM5 TCTL11.TCTL1_BITS._OM5
#define OL6 TCTL11.TCTL1_BITS._OL6
#define OM6 TCTL11.TCTL1_BITS._OM6
#define OL7 TCTL11.TCTL1_BITS._OL7
#define OM7 TCTL11.TCTL1_BITS._OM7

/*******************************************************************************************/
/*                                TIMER CONTROL REGISTER 2                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _OL0:1;
    unsigned char _OM0:1;
    unsigned char _OL1:1;
    unsigned char _OM1:1;
    unsigned char _OL2:1;
    unsigned char _OM2:1;
    unsigned char _OL3:1;
    unsigned char _OM3:1;
  } TCTL2_BITS;
  unsigned char TCTL2_BYTE;
} TCTL21 _IO_AT(0x89);

/*DEFINE REGISTER*/
#define TCTL2 TCTL21.TCTL2_BYTE

/*DEFINE REGISTER BITS*/
#define OL0 TCTL21.TCTL2_BITS._OL0
#define OM0 TCTL21.TCTL2_BITS._OM0
#define OL1 TCTL21.TCTL2_BITS._OL1
#define OM1 TCTL21.TCTL2_BITS._OM1
#define OL2 TCTL21.TCTL2_BITS._OL2
#define OM2 TCTL21.TCTL2_BITS._OM2
#define OL3 TCTL21.TCTL2_BITS._OL3
#define OM3 TCTL21.TCTL2_BITS._OM3

/*******************************************************************************************/
/*                                TIMER CONTROL REGISTER 3                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EDG4A:1;
    unsigned char _EDG4B:1;
    unsigned char _EDG5A:1;
    unsigned char _EDG5B:1;
    unsigned char _EDG6A:1;
    unsigned char _EDG6B:1;
    unsigned char _EDG7A:1;
    unsigned char _EDG7B:1;
  } TCTL3_BITS;
  unsigned char TCTL3_BYTE;
} TCTL31 _IO_AT(0x8A);

/*DEFINE REGISTER*/
#define TCTL3 TCTL31.TCTL3_BYTE

/*DEFINE REGISTER BITS*/
#define EDG4A TCTL31.TCTL3_BITS._EDG4A
#define EDG4B TCTL31.TCTL3_BITS._EDG4B
#define EDG5A TCTL31.TCTL3_BITS._EDG5A
#define EDG5B TCTL31.TCTL3_BITS._EDG5B
#define EDG6A TCTL31.TCTL3_BITS._EDG6A
#define EDG6B TCTL31.TCTL3_BITS._EDG6B
#define EDG7A TCTL31.TCTL3_BITS._EDG7A
#define EDG7B TCTL31.TCTL3_BITS._EDG7B

/*******************************************************************************************/
/*                                TIMER CONTROL REGISTER 4                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EDG0A:1;
    unsigned char _EDG0B:1;
    unsigned char _EDG1A:1;
    unsigned char _EDG1B:1;
    unsigned char _EDG2A:1;
    unsigned char _EDG2B:1;
    unsigned char _EDG3A:1;
    unsigned char _EDG3B:1;
  } TCTL4_BITS;
  unsigned char TCTL4_BYTE;
} TCTL41 _IO_AT(0x8B);

/*DEFINE REGISTER*/
#define TCTL4 TCTL41.TCTL4_BYTE

/*DEFINE REGISTER BITS*/
#define EDG0A TCTL41.TCTL4_BITS._EDG0A
#define EDG0B TCTL41.TCTL4_BITS._EDG0B
#define EDG1A TCTL41.TCTL4_BITS._EDG1A
#define EDG1B TCTL41.TCTL4_BITS._EDG1B
#define EDG2A TCTL41.TCTL4_BITS._EDG2A
#define EDG2B TCTL41.TCTL4_BITS._EDG2B
#define EDG3A TCTL41.TCTL4_BITS._EDG3A
#define EDG3B TCTL41.TCTL4_BITS._EDG3B

/*******************************************************************************************/
/*                                TIMER INTERRUPT MASK 1                                   */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _C0I:1;
    unsigned char _C1I:1;
    unsigned char _C2I:1;
    unsigned char _C3I:1;
    unsigned char _C4I:1;
    unsigned char _C5I:1;
    unsigned char _C6I:1;
    unsigned char _C7I:1;
  } TMSK1_BITS;
  unsigned char TMSK1_BYTE;
} TMSK11 _IO_AT(0x8C);

/*DEFINE REGISTER*/
#define TMSK1 TMSK11.TMSK1_BYTE

/*DEFINE REGISTER BITS*/
#define C0I TMSK11.TMSK1_BITS._C0I
#define C1I TMSK11.TMSK1_BITS._C1I
#define C2I TMSK11.TMSK1_BITS._C2I
#define C3I TMSK11.TMSK1_BITS._C3I
#define C4I TMSK11.TMSK1_BITS._C4I
#define C5I TMSK11.TMSK1_BITS._C5I
#define C6I TMSK11.TMSK1_BITS._C6I
#define C7I TMSK11.TMSK1_BITS._C7I

/*******************************************************************************************/
/*                                TIMER INTERRUPT MASK 2                                   */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PR0:1;
    unsigned char _PR1:1;
    unsigned char _PR2:1;
    unsigned char _TCRE:1;
    unsigned char _RDPT:1;
    unsigned char _PUPT:1;
    unsigned char _BIT6:1;
    unsigned char _TOI:1;
  } TMSK2_BITS;
  unsigned char TMSK2_BYTE;
} TMSK21 _IO_AT(0x8D);

/*DEFINE REGISTER*/
#define TMSK2 TMSK21.TMSK2_BYTE

/*DEFINE REGISTER BITS*/
#define PR0 TMSK21.TMSK2_BITS._PR0
#define PR1 TMSK21.TMSK2_BITS._PR1
#define PR2 TMSK21.TMSK2_BITS._PR2
#define TCRE TMSK21.TMSK2_BITS._TCRE
#define RDPT TMSK21.TMSK2_BITS._RDPT
#define PUPT TMSK21.TMSK2_BITS._PUPT
#define TOI TMSK21.TMSK2_BITS._TOI

/*******************************************************************************************/
/*                                TIMER INTERRUPT FLAG 1                                   */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _C0F:1;
    unsigned char _C1F:1;
    unsigned char _C2F:1;
    unsigned char _C3F:1;
    unsigned char _C4F:1;
    unsigned char _C5F:1;
    unsigned char _C6F:1;
    unsigned char _C7F:1;
  } TFLG1_BITS;
  unsigned char TFLG1_BYTE;
} TFLG11 _IO_AT(0x8E);

/*DEFINE REGISTER*/
#define TFLG1 TFLG11.TFLG1_BYTE

/*DEFINE REGISTER BITS*/
#define C0F TFLG11.TFLG1_BITS._C0F
#define C1F TFLG11.TFLG1_BITS._C1F
#define C2F TFLG11.TFLG1_BITS._C2F
#define C3F TFLG11.TFLG1_BITS._C3F
#define C4F TFLG11.TFLG1_BITS._C4F
#define C5F TFLG11.TFLG1_BITS._C5F
#define C6F TFLG11.TFLG1_BITS._C6F
#define C7F TFLG11.TFLG1_BITS._C7F

/*******************************************************************************************/
/*                                TIMER INTERRUPT FLAG 2                                   */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char _TOF:1;
  } TFLG2_BITS;
  unsigned char TFLG2_BYTE;
} TFLG21 _IO_AT(0x8F);

/*DEFINE REGISTER*/
#define TFLG2 TFLG21.TFLG2_BYTE

/*DEFINE REGISTER BITS*/
#define TOF TFLG21.TFLG2_BITS._TOF

/*******************************************************************************************/
/*                         TIMER INPUT CAPTURE/OUTPUT REGISTERS                            */
/*******************************************************************************************/

/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 0*****/
__DECL__6812B32_H__ volatile  unsigned int TC0      _IO_AT(0x90);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 1*****/
__DECL__6812B32_H__ volatile  unsigned int TC1      _IO_AT(0x92);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 2*****/
__DECL__6812B32_H__ volatile  unsigned int TC2      _IO_AT(0x94);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 3*****/
__DECL__6812B32_H__ volatile  unsigned int TC3      _IO_AT(0x96);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 4*****/
__DECL__6812B32_H__ volatile  unsigned int TC4      _IO_AT(0x98);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 5*****/
__DECL__6812B32_H__ volatile  unsigned int TC5      _IO_AT(0x9a);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 6*****/
__DECL__6812B32_H__ volatile  unsigned int TC6      _IO_AT(0x9c);


/*****TIMER INPUT CAPTURE/OUTPUT REGISTER 7*****/
__DECL__6812B32_H__ volatile  unsigned int TC7      _IO_AT(0x9e);

/*******************************************************************************************/
/*                        PULSE ACCUMULATOR CONTROL REGISTER                               */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PAI:1;
    unsigned char _PAOVI:1;
    unsigned char _CLOCK0:1;
    unsigned char _CLOCK1:1;
    unsigned char _PEDGE:1;
    unsigned char _PAMOD:1;
    unsigned char _PAEN:1;
    unsigned char BIT7:1;
  } PACTL_BITS;
  unsigned char PACTL_BYTE;
} PACTL1 _IO_AT(0xA0);

/*DEFINE REGISTER*/
#define PACTL PACTL1.PACTL_BYTE

/*DEFINE REGISTER BITS*/
#define PAI PACTL1.PACTL_BITS._PAI
#define PAOVI PACTL1.PACTL_BITS._PAOVI
#define CLOCK0 PACTL1.PACTL_BITS._CLOCK0
#define CLOCK1 PACTL1.PACTL_BITS._CLOCK1
#define PEDGE PACTL1.PACTL_BITS._PEDGE
#define PAMOD PACTL1.PACTL_BITS._PAMOD
#define PAEN PACTL1.PACTL_BITS._PAEN

/*******************************************************************************************/
/*                         PULSE ACCUMULATOR FLAG REGISTER                                 */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PAIF:1;
    unsigned char _PAOVF:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } PAFLG_BITS;
  unsigned char PAFLG_BYTE;
} PAFLG1 _IO_AT(0xA1);

/*DEFINE REGISTER*/
#define PAFLG PAFLG1.PAFLG_BYTE

/*DEFINE REGISTER BITS*/
#define PAIF PAFLG1.PAFLG_BITS._PAIF
#define PAOVF PAFLG1.PAFLG_BITS._PAOVF

/*******************************************************************************************/
/*                      16-BITS PULSE ACCUMULATOR COUNT REGISTER                           */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned int PACNT    _IO_AT(0xa2);

/*******************************************************************************************/
/*                                  TIMER TEST REGISTER                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PCBYP:1;
    unsigned char _TCBYP:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } TIMTST_BITS;
  unsigned char TIMTST_BYTE;
} TIMTST1 _IO_AT(0xAD);

/*DEFINE REGISTER*/
#define TIMTST TIMTST1.TIMTST_BYTE

/*DEFINE REGISTER BITS*/
#define PCBYP TIMTST1.TIMTST_BITS._PCBYP
#define TCBYP TIMTST1.TIMTST_BITS._TCBYP

/*******************************************************************************************/
/*                                  TIMER PORT DATA REGISTER                               */
/*******************************************************************************************/

/*****PORT T DEFINITION*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _I_OC0:1;
    unsigned char _I_OC1:1;
    unsigned char _I_OC2:1;
    unsigned char _I_OC3:1;
    unsigned char _I_OC4:1;
    unsigned char _I_OC5:1;
    unsigned char _I_OC6:1;
    unsigned char _I_OC7:1;
  } PORTT_BITS;
  unsigned char PORTT_BYTE;
} PORTT1 _IO_AT(0xAE);

/*DEFINE REGISTER*/
#define PORTT PORTT1.PORTT_BYTE

/*DEFINE REGISTER BITS*/
#define I_OC0 PORTT1.PORTT_BITS._I_OC0
#define I_OC1 PORTT1.PORTT_BITS._I_OC1
#define I_OC2 PORTT1.PORTT_BITS._I_OC2
#define I_OC3 PORTT1.PORTT_BITS._I_OC3
#define I_OC4 PORTT1.PORTT_BITS._I_OC4
#define I_OC5 PORTT1.PORTT_BITS._I_OC5
#define I_OC6 PORTT1.PORTT_BITS._I_OC6
#define I_OC7 PORTT1.PORTT_BITS._I_OC7

/*****DATA DIRECTION REGISTER FOR TIMER OUT*****/
__DECL__6812B32_H__ volatile  unsigned char DDRT     _IO_AT(0xaf);

/*******************************************************************************************/
/*                            SCI BAUD RATE CONTROL REGISTERS                              */
/*******************************************************************************************/

/*****SCI BAUD RATE CONTROL REGISTER HIGH*****/
__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SBR8:1;
    unsigned char _SBR9:1;
    unsigned char _SBR10:1;
    unsigned char _SBR11:1;
    unsigned char _SBR12:1;
    unsigned char _BRLD:1;
    unsigned char _BSPL:1;
    unsigned char _BTST:1;
  } SC0BDH_BITS;
  unsigned char SC0BDH_BYTE;
} SC0BDH1 _IO_AT(0xC0);

/*DEFINE REGISTER*/
#define SC0BDH SC0BDH1.SC0BDH_BYTE

/*DEFINE REGISTER BITS*/
#define SBR8 SC0BDH1.SC0BDH_BITS._SBR8
#define SBR9 SC0BDH1.SC0BDH_BITS._SBR9
#define SBR10 SC0BDH1.SC0BDH_BITS._SBR10
#define SBR11 SC0BDH1.SC0BDH_BITS._SBR11
#define SBR12 SC0BDH1.SC0BDH_BITS._SBR12
#define BRLD SC0BDH1.SC0BDH_BITS._BRLD
#define BSPL SC0BDH1.SC0BDH_BITS._BSPL
#define BTST SC0BDH1.SC0BDH_BITS._BTST


/*****SCI BAUD RATE CONTROL REGISTER LOW*****/
__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SBR0:1;
    unsigned char _SBR1:1;
    unsigned char _SBR2:1;
    unsigned char _SBR3:1;
    unsigned char _SBR4:1;
    unsigned char _SBR5:1;
    unsigned char _SBR6:1;
    unsigned char _SBR7:1;
  } SC0BDL_BITS;
  unsigned char SC0BDL_BYTE;
} SC0BDL1 _IO_AT(0xC1);

/*DEFINE REGISTER*/
#define SC0BDL SC0BDL1.SC0BDL_BYTE

/*DEFINE REGISTER BITS*/
#define SBR0 SC0BDL1.SC0BDL_BITS._SBR0
#define SBR1 SC0BDL1.SC0BDL_BITS._SBR1
#define SBR2 SC0BDL1.SC0BDL_BITS._SBR2
#define SBR3 SC0BDL1.SC0BDL_BITS._SBR3
#define SBR4 SC0BDL1.SC0BDL_BITS._SBR4
#define SBR5 SC0BDL1.SC0BDL_BITS._SBR5
#define SBR6 SC0BDL1.SC0BDL_BITS._SBR6
#define SBR7 SC0BDL1.SC0BDL_BITS._SBR7

/*******************************************************************************************/
/*                                 SCI  CONTROL REGISTERS                                  */
/*******************************************************************************************/

/*****SCI CONTROL REGISTER 1*****/
__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PT:1;
    unsigned char _PE:1;
    unsigned char _ILT:1;
    unsigned char _WAKE:1;
    unsigned char _M:1;
    unsigned char _RSRC:1;
    unsigned char _WOMS:1;
    unsigned char _LOOPS:1;
  } SC0CR1_BITS;
  unsigned char SC0CR1_BYTE;
} SC0CR11 _IO_AT(0xC2);

/*DEFINE REGISTER*/
#define SC0CR1 SC0CR11.SC0CR1_BYTE

/*DEFINE REGISTER BITS*/
#define PT SC0CR11.SC0CR1_BITS._PT
#define PE SC0CR11.SC0CR1_BITS._PE
#define ILT SC0CR11.SC0CR1_BITS._ILT
#define WAKE SC0CR11.SC0CR1_BITS._WAKE
#define M SC0CR11.SC0CR1_BITS._M
#define RSRC SC0CR11.SC0CR1_BITS._RSRC
#define WOMS SC0CR11.SC0CR1_BITS._WOMS
#define LOOPS SC0CR11.SC0CR1_BITS._LOOPS

/*****SCI CONTROL REGISTER 2*****/
__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SBK:1;
    unsigned char _RWU:1;
    unsigned char _RE:1;
    unsigned char _TE:1;
    unsigned char _ILIE:1;
    unsigned char _RIE:1;
    unsigned char _TCIE:1;
    unsigned char _TIE:1;
  } SC0CR2_BITS;
  unsigned char SC0CR2_BYTE;
} SC0CR21 _IO_AT(0xC3);

/*DEFINE REGISTER*/
#define SC0CR2 SC0CR21.SC0CR2_BYTE

/*DEFINE REGISTER BITS*/
#define SBK SC0CR21.SC0CR2_BITS._SBK
#define RWU SC0CR21.SC0CR2_BITS._RWU
#define RE SC0CR21.SC0CR2_BITS._RE
#define TE SC0CR21.SC0CR2_BITS._TE
#define ILIE SC0CR21.SC0CR2_BITS._ILIE
#define RIE SC0CR21.SC0CR2_BITS._RIE
#define TCIE SC0CR21.SC0CR2_BITS._TCIE
#define TIE SC0CR21.SC0CR2_BITS._TIE

/*******************************************************************************************/
/*                                   SCI STATUS REGISTERS                                  */
/*******************************************************************************************/

/*****SCI STATUS REGISTER 1*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PF:1;
    unsigned char _FE:1;
    unsigned char _NF:1;
    unsigned char _OR:1;
    unsigned char _IDLE:1;
    unsigned char _RDRF:1;
    unsigned char _TC:1;
    unsigned char _TDRE:1;
  } SC0SR1_BITS;
  unsigned char SC0SR1_BYTE;
} SC0SR11 _IO_AT(0xC4);

/*DEFINE REGISTER*/
#define SC0SR1 SC0SR11.SC0SR1_BYTE

/*DEFINE REGISTER BITS*/
#define PF SC0SR11.SC0SR1_BITS._PF
#define FE SC0SR11.SC0SR1_BITS._FE
#define NF SC0SR11.SC0SR1_BITS._NF
#define OR SC0SR11.SC0SR1_BITS._OR
#define IDLE SC0SR11.SC0SR1_BITS._IDLE
#define RDRF SC0SR11.SC0SR1_BITS._RDRF
#define TC SC0SR11.SC0SR1_BITS._TC
#define TDRE SC0SR11.SC0SR1_BITS._TDRE

/*****SCI STATUS REGISTER 2*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _RAF:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } SC0SR2_BITS;
  unsigned char SC0SR2_BYTE;
} SC0SR21 _IO_AT(0xC5);

/*DEFINE REGISTER*/
#define SC0SR2 SC0SR21.SC0SR2_BYTE

/*DEFINE REGISTER BITS*/
#define RAF SC0SR21.SC0SR2_BITS._RAF

/*******************************************************************************************/
/*                                   SCI DATA REGISTERS                                    */
/*******************************************************************************************/

/*****SCI DATA REGISTER HIGH*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char _T8:1;
    unsigned char _R8:1;
  } SC0DRH_BITS;
  unsigned char SC0DRH_BYTE;
} SC0DRH1 _IO_AT(0xC6);

/*DEFINE REGISTER*/
#define SC0DRH SC0DRH1.SC0DRH_BYTE

/*DEFINE REGISTER BITS*/
#define T8 SC0DRH1.SC0DRH_BITS._T8
#define R8 SC0DRH1.SC0DRH_BITS._R8

/*****SCI DATA REGISTER LOW*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _R0_T0:1;
    unsigned char _R1_T1:1;
    unsigned char _R2_T2:1;
    unsigned char _R3_T3:1;
    unsigned char _R4_T4:1;
    unsigned char _R5_T5:1;
    unsigned char _R6_T6:1;
    unsigned char _R7_T7:1;
  } SC0DRL_BITS;
  unsigned char SC0DRL_BYTE;
} SC0DRL1 _IO_AT(0xC7);

/*DEFINE REGISTER*/
#define SC0DRL SC0DRL1.SC0DRL_BYTE

/*DEFINE REGISTER BITS*/
#define R0_T0 SC0DRL1.SC0DRL_BITS._R0_T0
#define R1_T1 SC0DRL1.SC0DRL_BITS._R1_T1
#define R2_T2 SC0DRL1.SC0DRL_BITS._R2_T2
#define R3_T3 SC0DRL1.SC0DRL_BITS._R3_T3
#define R4_T4 SC0DRL1.SC0DRL_BITS._R4_T4
#define R5_T5 SC0DRL1.SC0DRL_BITS._R5_T5
#define R6_T6 SC0DRL1.SC0DRL_BITS._R6_T6
#define R7_T7 SC0DRL1.SC0DRL_BITS._R7_T7


/*******************************************************************************************/
/*                                 SPI  CONTROL REGISTERS                                  */
/*******************************************************************************************/

/*****SPI CONTROL REGISTER 1*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _LSBF:1;
    unsigned char _SSOE:1;
    unsigned char _CPHA:1;
    unsigned char _CPOL:1;
    unsigned char _MSTR:1;
    unsigned char _SWOM:1;
    unsigned char _SPE:1;
    unsigned char _SPIE:1;
  } SP0CR1_BITS;
  unsigned char SP0CR1_BYTE;
} SP0CR11 _IO_AT(0xD0);

/*DEFINE REGISTER*/
#define SP0CR1 SP0CR11.SP0CR1_BYTE

/*DEFINE REGISTER BITS*/
#define LSBF SP0CR11.SP0CR1_BITS._LSBF
#define SSOE SP0CR11.SP0CR1_BITS._SSOE
#define CPHA SP0CR11.SP0CR1_BITS._CPHA
#define CPOL SP0CR11.SP0CR1_BITS._CPOL
#define MSTR SP0CR11.SP0CR1_BITS._MSTR
#define SWOM SP0CR11.SP0CR1_BITS._SWOM
#define SPE SP0CR11.SP0CR1_BITS._SPE
#define SPIE SP0CR11.SP0CR1_BITS._SPIE

/*****SPI CONTROL REGISTER 2*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SPC0:1;
    unsigned char _SSWAI:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } SP0CR2_BITS;
  unsigned char SP0CR2_BYTE;
} SP0CR21 _IO_AT(0xD1);

/*DEFINE REGISTER*/
#define SP0CR2 SP0CR21.SP0CR2_BYTE

/*DEFINE REGISTER BITS*/
#define SPC0 SP0CR21.SP0CR2_BITS._SPC0
#define SSWAI SP0CR21.SP0CR2_BITS._SSWAI

/*******************************************************************************************/
/*                                 SPI BAUD RATE REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _SPR0:1;
    unsigned char _SPR1:1;
    unsigned char _SPR2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } SP0BR_BITS;
  unsigned char SP0BR_BYTE;
} SP0BR1 _IO_AT(0xD2);

/*DEFINE REGISTER*/
#define SP0BR SP0BR1.SP0BR_BYTE

/*DEFINE REGISTER BITS*/
#define SPR0 SP0BR1.SP0BR_BITS._SPR0
#define SPR1 SP0BR1.SP0BR_BITS._SPR1
#define SPR2 SP0BR1.SP0BR_BITS._SPR2

/*******************************************************************************************/
/*                                    SPI STATUS REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char _MODF:1;
    unsigned char BIT5:1;
    unsigned char _WCOL:1;
    unsigned char _SPIF:1;
  } SP0SR_BITS;
  unsigned char SP0SR_BYTE;
} SP0SR1 _IO_AT(0xD3);

/*DEFINE REGISTER*/
#define SP0SR SP0SR1.SP0SR_BYTE

/*DEFINE REGISTER BITS*/
#define MODF SP0SR1.SP0SR_BITS._MODF
#define WCOL SP0SR1.SP0SR_BITS._WCOL
#define SPIF SP0SR1.SP0SR_BITS._SPIF

/*******************************************************************************************/
/*                                   SCI DATA REGISTERS                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char SP0DR    _IO_AT(0xd5);

/*******************************************************************************************/
/*                                             PORT S                                      */
/*******************************************************************************************/

/*****PORT S DEFINITION*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _RXD0:1;
    unsigned char _TXD0:1;
    unsigned char _I_O1:1;
    unsigned char _I_O2:1;
    unsigned char _MISO_SISO:1;
    unsigned char _MOSI_MOMI:1;
    unsigned char _SCK:1;
    unsigned char _SS__CSA:1;
  } PORTS_BITS;
  unsigned char PORTS_BYTE;
} PORTS1 _IO_AT(0xD6);

/*DEFINE REGISTER*/
#define PORTS PORTS1.PORTS_BYTE

/*DEFINE REGISTER BITS*/
#define RXD0        PORTS1.PORTS_BITS._RXD0
#define TXD0        PORTS1.PORTS_BITS._TXD0
#define I_O1        PORTS1.PORTS_BITS._I_O1
#define I_O2        PORTS1.PORTS_BITS._I_O2
#define MISO_SISO   PORTS1.PORTS_BITS._MISO_SISO
#define MOSI_MOMI   PORTS1.PORTS_BITS._MOSI_MOMI
#define SCK         PORTS1.PORTS_BITS._SCK
#define _SS__CS     PORTS1.PORTS_BITS._SS__CSA

/*****DATA DIRECTION REGISTER FOR PORT S*****/

__DECL__6812B32_H__ volatile  unsigned char DDRS     _IO_AT(0xd7);

/*******************************************************************************************/
/*                   PULL_UP AND REDUCED DRIVE FOR PORT S                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _PUPS0:1;
    unsigned char _PUPS1:1;
    unsigned char _PUPS2:1;
    unsigned char BIT3:1;
    unsigned char _RDPS0:1;
    unsigned char _RDPS1:1;
    unsigned char _RDPS2:1;
    unsigned char BIT7:1;
  } PURDS_BITS;
  unsigned char PURDS_BYTE;
} PURDS1 _IO_AT(0xDB);

/*DEFINE REGISTER*/
#define PURDS PURDS1.PURDS_BYTE

/*DEFINE REGISTER BITS*/
#define PUPS0 PURDS1.PURDS_BITS._PUPS0
#define PUPS1 PURDS1.PURDS_BITS._PUPS1
#define PUPS2 PURDS1.PURDS_BITS._PUPS2
#define RDPS0 PURDS1.PURDS_BITS._RDPS0
#define RDPS1 PURDS1.PURDS_BITS._RDPS1
#define RDPS2 PURDS1.PURDS_BITS._RDPS2

/*******************************************************************************************/
/*                            EEPROM MODULE CONFIGURATION                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EERC:1;
    unsigned char _PROTLCK:1;
    unsigned char _EESWAI:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } EEMCR_BITS;
  unsigned char EEMCR_BYTE;
} EEMCR1 _IO_AT(0xF0);

/*DEFINE REGISTER*/
#define EEMCR EEMCR1.EEMCR_BYTE

/*DEFINE REGISTER BITS*/
#define EERC EEMCR1.EEMCR_BITS._EERC
#define PROTLCK EEMCR1.EEMCR_BITS._PROTLCK
#define EESWAI EEMCR1.EEMCR_BITS._EESWAI

/*******************************************************************************************/
/*                                   EEPROM BLOCK PROTECT                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _BPROT0:1;
    unsigned char _BPROT1:1;
    unsigned char _BPROT2:1;
    unsigned char _BPROT3:1;
    unsigned char _BPROT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } EEPROT_BITS;
  unsigned char EEPROT_BYTE;
} EEPROT1 _IO_AT(0xF1);

/*DEFINE REGISTER*/
#define EEPROT EEPROT1.EEPROT_BYTE

/*DEFINE REGISTER BITS*/
#define BPROT0 EEPROT1.EEPROT_BITS._BPROT0
#define BPROT1 EEPROT1.EEPROT_BITS._BPROT1
#define BPROT2 EEPROT1.EEPROT_BITS._BPROT2
#define BPROT3 EEPROT1.EEPROT_BITS._BPROT3
#define BPROT4 EEPROT1.EEPROT_BITS._BPROT4

/*******************************************************************************************/
/*                                       EEPROM TEST                                       */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char _EECPM:1;
    unsigned char BIT2:1;
    unsigned char _EECPRD:1;
    unsigned char _EECPD:1;
    unsigned char _MARG:1;
    unsigned char _EEVEN:1;
    unsigned char _EEODD:1;
  } EETST_BITS;
  unsigned char EETST_BYTE;
} EETST1 _IO_AT(0xF2);

/*DEFINE REGISTER*/
#define EETST EETST1.EETST_BYTE

/*DEFINE REGISTER BITS*/
#define EECPM EETST1.EETST_BITS._EECPM
#define EECPRD EETST1.EETST_BITS._EECPRD
#define EECPD EETST1.EETST_BITS._EECPD
#define MARG EETST1.EETST_BITS._MARG
#define EEVEN EETST1.EETST_BITS._EEVEN
#define EEODD EETST1.EETST_BITS._EEODD

/*******************************************************************************************/
/*                                       EEPROM CONTROL                                    */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _EEPGM:1;
    unsigned char _EELAT:1;
    unsigned char _ERASE:1;
    unsigned char _ROW:1;
    unsigned char _BYTE:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char _BULKP:1;
  } EEPROG_BITS;
  unsigned char EEPROG_BYTE;
} EEPROG1 _IO_AT(0xF3);

/*DEFINE REGISTER*/
#define EEPROG EEPROG1.EEPROG_BYTE

/*DEFINE REGISTER BITS*/
#define EEPGM EEPROG1.EEPROG_BITS._EEPGM
#define EELAT EEPROG1.EEPROG_BITS._EELAT
#define ERASE EEPROG1.EEPROG_BITS._ERASE
#define ROW EEPROG1.EEPROG_BITS._ROW
#define BYTE EEPROG1.EEPROG_BITS._BYTE
#define BULKP EEPROG1.EEPROG_BITS._BULKP

/*******************************************************************************************/
/*                          FLASH EEPROM LOCK CONTROL REGISTER                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _LOCK:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } FEELCK_BITS;
  unsigned char FEELCK_BYTE;
} FEELCK1 _IO_AT(0xF4);

/*DEFINE REGISTER*/
#define FEELCK FEELCK1.FEELCK_BYTE

/*DEFINE REGISTER BITS*/
#define LOCK FEELCK1.FEELCK_BITS._LOCK

/*******************************************************************************************/
/*                          FLASH EEPROM MODULE CONFIGURATION REGISTER                     */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _BOOTP:1;
    unsigned char BIT1:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } FEEMCR_BITS;
  unsigned char FEEMCR_BYTE;
} FEEMCR1 _IO_AT(0xF5);

/*DEFINE REGISTER*/
#define FEEMCR FEEMCR1.FEEMCR_BYTE

/*DEFINE REGISTER BITS*/
#define BOOTP FEEMCR1.FEEMCR_BITS._BOOTP

/*******************************************************************************************/
/*                              FLASH EEPROM MODULE TEST REGISTER                          */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _MWPR:1;
    unsigned char _STRE:1;
    unsigned char _VTCK:1;
    unsigned char _FDISVFP:1;
    unsigned char _FENLV:1;
    unsigned char _HVT:1;
    unsigned char _GADR:1;
    unsigned char _FSTE:1;
  } FEETST_BITS;
  unsigned char FEETST_BYTE;
} FEETST1 _IO_AT(0xF6);

/*DEFINE REGISTER*/
#define FEETST FEETST1.FEETST_BYTE

/*DEFINE REGISTER BITS*/
#define MWPR FEETST1.FEETST_BITS._MWPR
#define STRE FEETST1.FEETST_BITS._STRE
#define VTCK FEETST1.FEETST_BITS._VTCK
#define FDISVFP FEETST1.FEETST_BITS._FDISVFP
#define FENLV FEETST1.FEETST_BITS._FENLV
#define HVT FEETST1.FEETST_BITS._HVT
#define GADR FEETST1.FEETST_BITS._GADR
#define FSTE FEETST1.FEETST_BITS._FSTE

/*******************************************************************************************/
/*                              FLASH EEPROM CONTROL REGISTER                              */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _ENTPE:1;
    unsigned char _LAT:1;
    unsigned char _ERAS:1;
    unsigned char _SVFP:1;
    unsigned char _FEESWAI:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } FEECTL_BITS;
  unsigned char FEECTL_BYTE;
} FEECTL1 _IO_AT(0xF7);

/*DEFINE REGISTER*/
#define FEECTL FEECTL1.FEECTL_BYTE

/*DEFINE REGISTER BITS*/
#define ENTPE FEECTL1.FEECTL_BITS._ENTPE
#define LAT FEECTL1.FEECTL_BITS._LAT
#define ERAS FEECTL1.FEECTL_BITS._ERAS
#define SVFP FEECTL1.FEECTL_BITS._SVFP
#define FEESWAI FEECTL1.FEECTL_BITS._FEESWAI

/*******************************************************************************************/
/*                                     BDLC CONTROL REGISTER 1                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _WCM:1;
    unsigned char _IE:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char _R0:1;
    unsigned char _R1:1;
    unsigned char _CLOCKS:1;
    unsigned char _IMSG:1;
  } BCR1_BITS;
  unsigned char BCR1_BYTE;
} BCR11 _IO_AT(0xF8);

/*DEFINE REGISTER*/
#define BCR1 BCR11.BCR1_BYTE

/*DEFINE REGISTER BITS*/
#define WCM BCR11.BCR1_BITS._WCM
#define IE BCR11.BCR1_BITS._IE
#define R0 BCR11.BCR1_BITS._R0
#define R1 BCR11.BCR1_BITS._R1
#define CLOCKS BCR11.BCR1_BITS._CLOCKS
#define IMSG BCR11.BCR1_BITS._IMSG

/*******************************************************************************************/
/*                                  BDLC STATE VECTOR REGISTER                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char BIT0:1;
    unsigned char BIT1:1;
    unsigned char _I0:1;
    unsigned char _I1:1;
    unsigned char _I2:1;
    unsigned char _I3:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } BSVR_BITS;
  unsigned char BSVR_BYTE;
} BSVR1 _IO_AT(0xF9);

/*DEFINE REGISTER*/
#define BSVR BSVR1.BSVR_BYTE

/*DEFINE REGISTER BITS*/
#define I0 BSVR1.BSVR_BITS._I0
#define I1 BSVR1.BSVR_BITS._I1
#define I2 BSVR1.BSVR_BITS._I2
#define I3 BSVR1.BSVR_BITS._I3

/*******************************************************************************************/
/*                                     BDLC CONTROL REGISTER 2                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _TMIFR0:1;
    unsigned char _TMIFR1:1;
    unsigned char _TSIFR:1;
    unsigned char _TEOD:1;
    unsigned char _NBFS:1;
    unsigned char _RX4XE:1;
    unsigned char _DLOOP:1;
    unsigned char _ALOOP:1;
  } BCR2_BITS;
  unsigned char BCR2_BYTE;
} BCR21 _IO_AT(0xFA);

/*DEFINE REGISTER*/
#define BCR2 BCR21.BCR2_BYTE

/*DEFINE REGISTER BITS*/
#define TMIFR0 BCR21.BCR2_BITS._TMIFR0
#define TMIFR1 BCR21.BCR2_BITS._TMIFR1
#define TSIFR BCR21.BCR2_BITS._TSIFR
#define TEOD BCR21.BCR2_BITS._TEOD
#define RX4XE BCR21.BCR2_BITS._RX4XE
#define DLOOP BCR21.BCR2_BITS._DLOOP
#define ALOOP BCR21.BCR2_BITS._ALOOP

/*******************************************************************************************/
/*                                     BDLC DATA REGISTER                                  */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile  unsigned char BDR      _IO_AT(0xfB);

/*******************************************************************************************/
/*                        BDLC ANALOG ROUNDTRIP DELAY REGISTER                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _BO0:1;
    unsigned char _BO1:1;
    unsigned char _BO2:1;
    unsigned char _BO3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char _RXPOL:1;
    unsigned char _ATE:1;
  } BARD_BITS;
  unsigned char BARD_BYTE;
} BARD1 _IO_AT(0xFC);

/*DEFINE REGISTER*/
#define BARD BARD1.BARD_BYTE

/*DEFINE REGISTER BITS*/
#define BO0 BARD1.BARD_BITS._BO0
#define BO1 BARD1.BARD_BITS._BO1
#define BO2 BARD1.BARD_BITS._BO2
#define BO3 BARD1.BARD_BITS._BO3
#define RXPOL BARD1.BARD_BITS._RXPOL
#define ATE BARD1.BARD_BITS._ATE

/*******************************************************************************************/
/*                                   PORT DLC CONTROL REGISTER                             */
/*******************************************************************************************/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _RDPDLC:1;
    unsigned char _PUPDLC:1;
    unsigned char _BDLGEN:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } DLCSCR_BITS;
  unsigned char DLCSCR_BYTE;
} DLCSCR1 _IO_AT(0xFD);

/*DEFINE REGISTER*/
#define DLCSCR DLCSCR1.DLCSCR_BYTE

/*DEFINE REGISTER BITS*/
#define RDPDLC DLCSCR1.DLCSCR_BITS._RDPDLC
#define PUPDLC DLCSCR1.DLCSCR_BITS._PUPDLC
#define BDLGEN DLCSCR1.DLCSCR_BITS._BDLGEN

/*******************************************************************************************/
/*                                             PORT DLC                                      */
/*******************************************************************************************/

/*****PORT DLC DEFINITION*****/

__DECL__6812B32_H__ volatile union {
  struct {
    unsigned char _DLCRX:1;
    unsigned char _DLCTX:1;
    unsigned char BIT2:1;
    unsigned char BIT3:1;
    unsigned char BIT4:1;
    unsigned char BIT5:1;
    unsigned char BIT6:1;
    unsigned char BIT7:1;
  } PORTDLC_BITS;
  unsigned char PORTDLC_BYTE;
} PORTDLC1 _IO_AT(0xFE);

/*DEFINE REGISTER*/
#define PORTDLC PORTDLC1.PORTDLC_BYTE

/*DEFINE REGISTER BITS*/
#define DLCRX PORTDLC1.PORTDLC_BITS._DLCRX
#define DLCTX PORTDLC1.PORTDLC_BITS._DLCTX

/*****DATA DIRECTION REGISTER FOR PORT DLC*****/
__DECL__6812B32_H__ volatile  unsigned char DDRDLC   _IO_AT(0xff);  /* port DLC direction register */

#endif /* __6812B32_H__ */
