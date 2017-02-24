#include "daed_builtins.h"
int main(void)
{
  double x;
  double res;

  x = DBETWEEN_WITH_ULP(0.0, 1.0);

  SUBDIV_BEGIN(x, 20)

  res = 1.0 + 0.5*x - 0.125*x*x + 0.0625*x*x*x - 0.0390625*x*x*x*x;

  SUBDIV_END

  DSENSITIVITY(res);

  return 0;
}
