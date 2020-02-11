#include "FreeRTOS.h"
#include "task.h"
#include "diag.h"
#include "main.h"
#include <example_entry.h>

#if defined(UART_LOG_BAUD_1152)
#include "log_uart_api.h"
#endif

extern void console_init(void);


/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */

#ifdef CONFIG_NATIVE_BUILD
void main(void)
{
	/* Initialize log uart and at command service */
	console_init();	

	/* pre-processor of application example */
	pre_example_entry();

	/* wlan intialization */
#if defined(CONFIG_WIFI_NORMAL) && defined(CONFIG_NETWORK)
	wlan_network();
#endif

	/* Execute application example */
	example_entry();

    /*Enable Schedule, Start Kernel*/
#if defined(CONFIG_KERNEL) && !TASK_SCHEDULER_DISABLED
	#ifdef PLATFORM_FREERTOS
	vTaskStartScheduler();
	#endif
#else
	RtlConsolTaskRom(NULL);
#endif
}
#else
void main(void)
{
#if defined(UART_LOG_BAUD_1152)
    log_uart_t uobj;
    log_uart_baud(&uobj, UART_BAUD_RATE_115200);
#endif

	/* Initialize log uart and at command service */
	//console_init();

	/* pre-processor of application example */
	//pre_example_entry();

	/* wlan intialization */
#if defined(CONFIG_WIFI_NORMAL) && defined(CONFIG_NETWORK)
    //wlan_network();
#endif

	/* Execute application example */
    //example_entry();
	Application_Start();

    /*Enable Schedule, Start Kernel*/
#if defined(CONFIG_KERNEL) && !TASK_SCHEDULER_DISABLED
	#ifdef PLATFORM_FREERTOS
	vTaskStartScheduler();
	#endif
#else
	RtlConsolTaskRom(NULL);
#endif
}
#endif //CONFIG_NATIVE_BUILD
