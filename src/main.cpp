
#include <stm32f0xx.h>

#define CONFIG_USE_EXCEPTIONS

#define LED_GPIO GPIOA
#define LED_PIN  5 

#define BUTTON_GPIO GPIOC
#define BUTTON_PIN  13

static void init()
{
    RCC->AHBENR |= (RCC_AHBENR_GPIOAEN | RCC_AHBENR_GPIOCEN);

    // configure LED pin as output
    LED_GPIO->MODER |= 1 << (2 * LED_PIN);
}

#if defined CONFIG_USE_EXCEPTIONS

static void is_button_pressed()
{
    throw bool(((BUTTON_GPIO->IDR >> BUTTON_PIN) & 1) == 0);
}

#else

static bool is_button_pressed()
{
    return ((BUTTON_GPIO->IDR >> BUTTON_PIN) & 1) == 0;
}

#endif

static void set_led(bool on)
{
    if (on)
        LED_GPIO->BSRR |= (1U << LED_PIN);
    else
        LED_GPIO->BRR |= (1U << LED_PIN);
}

int main()
{
    init();
    for (;;) {
#if defined CONFIG_USE_EXCEPTIONS
        try {
            is_button_pressed();
        }
        catch (bool b) {
            set_led(b);
        }
#else
        set_led(is_button_pressed());
#endif
    }
    // gcc issues a warning when we omit the return, armcc complains if there
    // is the return statement because the function never returns.
#if defined __GNUC__
    return 0;
#endif
}

