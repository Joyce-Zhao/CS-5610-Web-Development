defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "example1" do
    assert Calc.eval("2 + 3") == 5
  end

  test "example2" do
    assert Calc.eval("5 * 1") == 5
  end

  test "example3" do
    assert Calc.eval("20 / 4") == 5
  end

  test "example4" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
  end

  test "example5" do
    assert Calc.eval("1 + 3 * 3 + 1") == 11
  end
end
