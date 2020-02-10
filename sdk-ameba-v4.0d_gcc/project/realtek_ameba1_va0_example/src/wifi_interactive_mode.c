#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "main.h"
#include <platform/platform_stdlib.h>

#define STACKSIZE               1024

static void cmd_exit(int argc, char **argv)
{
	printf("\n\rLeave INTERACTIVE MODE");
	vTaskDelete(NULL);
}

static void cmd_help(int argc, char **argv);

typedef struct _cmd_entry {
	char *command;
	void (*function)(int, char **);
} cmd_entry;

static const cmd_entry cmd_table[] = {
	{"exit", cmd_exit},
	{"help", cmd_help}
};

#if CONFIG_INTERACTIVE_EXT
/* must include here, ext_cmd_table in wifi_interactive_ext.h uses struct cmd_entry */
#include <wifi_interactive_ext.h>
#endif

static void cmd_help(int argc, char **argv)
{
	int i;

	printf("\n\rCOMMAND LIST:");
	printf("\n\r==============================");

	for(i = 0; i < sizeof(cmd_table) / sizeof(cmd_table[0]); i ++)
		printf("\n\r    %s", cmd_table[i].command);
#if CONFIG_INTERACTIVE_EXT
	for(i = 0; i < sizeof(ext_cmd_table) / sizeof(ext_cmd_table[0]); i ++)
		printf("\n\r    %s", ext_cmd_table[i].command);
#endif
}

#define MAX_ARGC	6

static int parse_cmd(char *buf, char **argv)
{
	int argc = 0;

	memset(argv, 0, sizeof(argv)*MAX_ARGC);
	while((argc < MAX_ARGC) && (*buf != '\0')) {
		argv[argc] = buf;
		argc ++;
		buf ++;

		while((*buf != ' ') && (*buf != '\0'))
			buf ++;

		while(*buf == ' ') {
			*buf = '\0';
			buf ++;
		}
		// Don't replace space
		if(argc == 1){
			if(strcmp(argv[0], "iwpriv") == 0){
				if(*buf != '\0'){
					argv[1] = buf;
					argc ++;
				}
				break;
			}
		}
	}

	return argc;
}

char uart_buf[64];
void interactive_mode(void *param)
{
	int i, argc;
	char *argv[MAX_ARGC];
	extern xSemaphoreHandle	uart_rx_interrupt_sema;

	printf("\n\rEnter INTERACTIVE MODE\n\r");
	printf("\n\r# ");

	while(1){
		while(xSemaphoreTake(uart_rx_interrupt_sema, portMAX_DELAY) != pdTRUE);

		if((argc = parse_cmd(uart_buf, argv)) > 0) {
			int found = 0;

			for(i = 0; i < sizeof(cmd_table) / sizeof(cmd_table[0]); i ++) {
				if(strcmp((const char *)argv[0], (const char *)(cmd_table[i].command)) == 0) {
					cmd_table[i].function(argc, argv);
					found = 1;
					break;
				}
			}
#if CONFIG_INTERACTIVE_EXT
			if(!found) {
				for(i = 0; i < sizeof(ext_cmd_table) / sizeof(ext_cmd_table[0]); i ++) {
					if(strcmp(argv[0], ext_cmd_table[i].command) == 0) {
						ext_cmd_table[i].function(argc, argv);
						found = 1;
						break;
					}
				}
			}
#endif
			if(!found)
				printf("\n\runknown command '%s'", argv[0]);
			printf("\n\r[MEM] After do cmd, available heap %d\n\r", xPortGetFreeHeapSize());
		}

		printf("\r\n\n# ");
		uart_buf[0] = '\0';
	}
}

void start_interactive_mode(void)
{
#ifdef SERIAL_DEBUG_RX
	if(xTaskCreate(interactive_mode, (char const *)"interactive_mode", STACKSIZE, NULL, tskIDLE_PRIORITY + 4, NULL) != pdPASS)
		printf("\n\r%s xTaskCreate failed", __FUNCTION__);
#else
	printf("\n\rERROR: No SERIAL_DEBUG_RX to support interactive mode!");
#endif
}
