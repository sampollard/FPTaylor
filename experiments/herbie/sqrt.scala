import leon.Real
import Real._

object RosaBenchmarks {
  def sqrt_sub(x: Real): Real = {
      require(x >< (1, 1000))
      sqrt(x + 1) - sqrt(x)
  }

  def sqrt_add(x: Real): Real = {
      require(x >< (1, 1000))
      1 / (sqrt(x + 1) + sqrt(x))
  }
}
