#include <stdio.h>
#include "platform.h"
#include <xgpio.h>
#include "xparameters.h"
#include "sleep.h"

int main()
{
	XGpio input, output;
	int button_data = 0;
	int switch_data = 0;

	XGpio_Initialize(&input, XPAR_AXI_GPIO_0_DEVICE_ID);	//initialize input XGpio variable
	XGpio_Initialize(&output, XPAR_AXI_GPIO_1_DEVICE_ID);	//initialize output XGpio variable

	XGpio_SetDataDirection(&input, 1, 0xF);			//set first channel tristate buffer to input
	XGpio_SetDataDirection(&input, 2, 0xF);			//set second channel tristate buffer to input

	XGpio_SetDataDirection(&output, 1, 0x0);		//set first channel tristate buffer to output

	init_platform();

	while(1){
		switch_data = XGpio_DiscreteRead(&input, 2);	//get switch data
		XGpio_DiscreteWrite(&output, 1, switch_data);	//write switch data to the LEDs

		//button_data = XGpio_DiscreteRead(&input, 1);

		usleep(200000);					//delay
	}
	cleanup_platform();
	return 0;
}
