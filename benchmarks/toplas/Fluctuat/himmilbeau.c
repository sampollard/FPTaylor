#include "daed_builtins.h"
int main(void)
{
  double x1, x2;
  double res;

  x1 = DBETWEEN_WITH_ULP(-5.0, 5.0);
  x2 = DBETWEEN_WITH_ULP(-5.0, 5.0);

  res = (x1*x1 + x2 - 11)* (x1*x1 + x2 - 11) + (x1 + x2*x2 - 7)*(x1 + x2*x2 - 7);

  DSENSITIVITY(res);

  return 0;
}
